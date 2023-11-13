# frozen_string_literal: true

require_relative '../../lib/folder_validator'

describe FolderValidator do
  describe '#call' do
    subject { described_class.call(folder_path) }
    let(:folder_path) { 'spec/fixtures/unknown_folder' }

    context 'when folder exist' do
      before do
        allow(Dir).to receive(:exist?).with(folder_path).and_return(true)
      end

      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when folder not exist' do
      after do
        Dir.delete(folder_path)
      end

      it 'creates folder' do
        expect { subject }.to output("Folder #{folder_path} has been created!\n").to_stderr
      end
    end
  end
end
