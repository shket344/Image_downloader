# frozen_string_literal: true

require_relative '../../lib/connection_validator'
require_relative '../../lib/folder_validator'
require_relative '../../lib/reader'
require_relative '../../lib/url_validator'
require_relative '../../lib/image_downloader'
require_relative '../../lib/performance'

describe Performance do
  describe '#call' do
    subject do
      described_class.call(ConnectionValidator, FolderValidator, folder_path, Reader, file, UrlValidator,
                           ImageDownloader)
    end

    let(:folder_path) { 'spec/fixtures/test_images/' }
    let(:file) { 'spec/fixtures/test.txt' }
    let(:name) { 'test_name' }
    let(:url) { "https://test/#{name}.png" }

    before do
      allow_any_instance_of(Reader).to receive(:call).and_return(url)
      allow_any_instance_of(UrlValidator).to receive(:call).and_return([url])
      stub_request(:get, url)
    end

    after do
      FileUtils.rm_rf("#{folder_path}/.", secure: true)
      Dir.delete(folder_path)
    end

    context 'with valid params' do
      let(:result) do
        first_part = "Connection valid!\nFolder spec/fixtures/test_images/ has been created!"
        "#{first_part}\n#{name}.png downloaded succesfully!\nAll allowed files were successfully downloaded!\n"
      end

      it 'download images' do
        expect { subject }.to output(result).to_stderr
      end
    end
  end
end
