# frozen_string_literal: true

require_relative 'application'

class Performance < Application
  attr_reader :connection_validator, :folder_validator, :folder_path, :reader, :file_path

  def initialize(connection_validator, folder_validator, folder_path, reader, file_path)
    @connection_validator = connection_validator
    @folder_validator = folder_validator
    @folder_path = folder_path
    @reader = reader
    @file_path = file_path
  end

  def call
    connection_validator.call
    folder_validator.call(folder_path)
    reader.call(file_path)
  end
end
