# frozen_string_literal: true

require_relative '../../lib/url_validator'

describe UrlValidator do
  describe '#call' do
    subject { described_class.call(urls) }
    let(:urls) { 'https://www.google.com/' }

    before do
      stub_request(:get, urls)
    end

    context 'when invalid urls format' do
      let(:urls) { 'fhrghfth htttp/gr' }

      it 'warns about no valid urls' do
        expect { subject }.to output("No valid urls were found!\n").to_stderr
                                                                   .and raise_error SystemExit
      end
    end

    context 'when invalid images' do
      context 'when huge content-length' do
        before do
          allow_any_instance_of(Mechanize::File).to receive(:response)
            .and_return({ 'content-type' => 'image/png',
                          'content-lenght' => UrlValidator::MAX_SIZE })
        end

        it 'warns about no reliable files' do
          expect { subject }.to output("No reliable files were found!\n").to_stderr
                                                                         .and raise_error SystemExit
        end
      end

      context 'when invalid content-type' do
        before do
          allow_any_instance_of(Mechanize::File).to receive(:response)
            .and_return({ 'content-type' => 'text/html' })
        end

        it 'warns about no reliable files' do
          expect { subject }.to output("No reliable files were found!\n").to_stderr
                                                                         .and raise_error SystemExit
        end
      end
    end

    context 'when valid images' do
      before do
        allow_any_instance_of(Mechanize::File).to receive(:response).and_return({ 'content-type' => 'image/png' })
      end

      it 'returns array of images' do
        expect(subject).to eq [urls]
      end
    end
  end
end
