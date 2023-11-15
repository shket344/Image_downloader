# frozen_string_literal: true

require 'open3'

RSpec.describe 'script' do
  let(:stdoutput) { Open3.capture3("./bin/main #{path_for_downloads} #{file}") }
  let(:file) { 'spec/fixtures/test.txt' }
  let(:path_for_downloads) { 'spec/fixtures/images/' }
  let(:output) { stdoutput[1] }
  let(:expected_result) do
    "Connection valid!\n1.png downloaded succesfully!\nAll allowed files were successfully downloaded!\n"
  end
  let(:url) { 'https://s3.eu-central-1.amazonaws.com/nftlaunchpad.com-media/competition/BAYC/1.png' }

  before do
    stub_request(:get, url)
  end

  context 'when file not provided' do
    let(:file) {}

    it { expect(output).to eq("Please, write folder path and file name.\n") }
  end

  context 'when path for downloads not provided' do
    let(:path_for_downloads) {}

    it { expect(output).to eq("Please, write folder path and file name.\n") }
  end

  context 'when invalid file' do
    let(:file) { 'spec/fixtures/some.txt' }

    it { expect(output).to include('StandardError') }
  end

  context 'when success' do
    after do
      FileUtils.rm_rf("#{path_for_downloads}/.", secure: true)
    end

    it { expect(output).to eq(expected_result) }
  end
end
