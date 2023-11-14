# frozen_string_literal: true

require_relative 'application'

class UrlValidator < Application
  attr_reader :urls

  MAX_SIZE = 10_485_760

  def initialize(urls)
    @urls = urls
  end

  def call
    validate_urls
  end

  private

  def validate_urls
    request = Mechanize.new
    request.redirection_limit = 1

    image_urls = []
    valid_urls = urls.split.select { |url| valid_url?(url) }.uniq
    exit_with_warning('No valid urls were found!') if valid_urls.empty?

    Parallel.each(valid_urls, in_threads: 10) do |url|
      image_urls << url if image?(url, request)
    end

    exit_with_warning('No reliable files were found!') if image_urls.empty?

    image_urls
  end

  def valid_url?(url)
    url_regexp = %r{\A(http|https)://[a-z0-9]+([\-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(/.*)?\z}ix
    !(url =~ url_regexp).nil?
  end

  def image?(url, request)
    response = request.get(url).response
    response['content-type'].start_with?('image') && response['content-lenght'].to_i < MAX_SIZE
  end
end
