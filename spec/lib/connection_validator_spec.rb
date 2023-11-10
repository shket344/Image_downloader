# frozen_string_literal: true

require_relative '../../lib/connection_validator'

describe ConnectionValidator do
  describe '#call' do
    subject { described_class.call }

    context 'when has connection' do
      before do
        allow_any_instance_of(Resolv::DNS).to receive(:getaddress)
      end

      it 'returns true' do
        expect { subject }.to output("Connection valid:\n").to_stderr
      end
    end

    context 'when no connection' do
      before do
        allow_any_instance_of(Resolv::DNS).to receive(:getaddress).and_raise(Resolv::ResolvError)
      end

      it 'returns true' do
        expect { subject }.to raise_error SystemExit
      end
    end
  end
end
