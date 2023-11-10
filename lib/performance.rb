# frozen_string_literal: true

require_relative 'application'

class Performance < Application
  attr_reader :connection_validator, :reader, :file_path

  def initialize(connection_validator, reader, file_path)
    @connection_validator = connection_validator
    @reader = reader
    @file_path = file_path
  end

  def call
    connection_validator.call
    reader.call(file_path)
  end
end
