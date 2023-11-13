# frozen_string_literal: true

require_relative 'application'

class FolderValidator < Application
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def call
    folder_exists? || create_folder
  end

  private

  def folder_exists?
    Dir.exist?(path)
  end

  def create_folder
    Dir.mkdir(path)
    warn "Folder #{path} has been created!"
  end
end
