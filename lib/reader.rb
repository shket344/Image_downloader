# frozen_string_literal: true

require_relative 'application'

class Reader < Application
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    raise StandardError unless File.exist?(file_path)

    file ||= File.read(file_path)
    file.empty? ? exit_with_warning("#{file_path} is empty.") : file
  end
end
