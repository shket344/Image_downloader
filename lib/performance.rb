# frozen_string_literal: true

require_relative 'application'

class Performance < Application
  attr_reader :connection_validator, :folder_validator, :folder_path, :reader, :file_path, :url_validator,
              :image_downloader

  def initialize(connection_validator, folder_validator, folder_path, reader, file_path, url_validator,
                 image_downloader)
    @connection_validator = connection_validator
    @folder_validator = folder_validator
    @folder_path = folder_path
    @reader = reader
    @file_path = file_path
    @url_validator = url_validator
    @image_downloader = image_downloader
  end

  def call
    connection_validator.call
    folder_validator.call(folder_path)
    read_file = reader.call(file_path)
    urls = url_validator.call(read_file)
    image_downloader.call(urls, folder_path)
  end
end
