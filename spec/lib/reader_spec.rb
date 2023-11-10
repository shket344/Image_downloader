# frozen_string_literal: true

require_relative '../../lib/reader'

describe Reader do
  describe '#call' do
    subject { described_class.call(file) }

    context 'when valid file' do
      let(:file) { 'spec/fixtures/test.txt' }

      let(:expected_result) { File.read(file) }

      it 'returns string with data from file' do
        expect { subject }.not_to raise_error StandardError
        expect(subject).to eq expected_result
      end
    end

    context 'when file does not exist' do
      let(:file) { 'spec/fixtures/unknown.txt' }

      it 'raise StandardError' do
        expect { subject }.to raise_error StandardError
      end
    end

    context 'when file is empty' do
      let(:file) { 'spec/fixtures/empty.txt' }

      it 'return warning message' do
        expect { subject }.to output("#{file} is empty.\n").to_stderr
                                                           .and raise_error SystemExit
      end
    end
  end
end
