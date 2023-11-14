# frozen_string_literal: true

require_relative '../../lib/image_downloader'

describe ImageDownloader do
  describe '#call' do
    subject { described_class.call([url], path_for_downloads) }
    let(:path_for_downloads) { 'spec/fixtures/test_images/' }
    let(:name) { 'test_name' }
    let(:url) { "https://test/#{name}.png" }

    before do
      stub_request(:get, url)
    end

    context 'when no similar names' do
      let(:result) do
        "#{name}.png downloaded succesfully!\nAll allowed files were successfully downloaded!\n"
      end

      before do
        Dir.mkdir(path_for_downloads)
      end

      it 'download images' do
        expect { subject }.to output(result).to_stderr
      end
    end

    context 'when similar names' do
      let(:result) do
        "#{name}_new.png downloaded succesfully!\nAll allowed files were successfully downloaded!\n"
      end

      after do
        FileUtils.rm_rf("#{path_for_downloads}/.", secure: true)
        Dir.delete(path_for_downloads)
      end

      it 'download images' do
        expect { subject }.to output(result).to_stderr
      end
    end
  end
end
