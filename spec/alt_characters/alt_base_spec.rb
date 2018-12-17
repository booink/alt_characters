# http://www5d.biglobe.ne.jp/stssk/rfc/rfc4648j.html

RSpec.describe AltCharacters::AltBase do
  describe '32' do
    before do
      class Base32 < AltCharacters::AltBase
        def initialize(characters: [('A'..'Z').to_a, ('2'..'7').to_a].flatten)
          super(32, characters: characters)
        end
      end
    end

    describe 'with padding' do
      let(:encoded_text) { Base32.new.encode(input, padding: true) }

      context '(blank)' do
        let(:input) { '' }
        it do
          expect(encoded_text).to eq ''
          expect(Base32.new.decode(encoded_text, padding: true)).to eq input
        end
      end

      context 'f' do
        let(:input) { 'f' }
        it do
          expect(encoded_text).to eq 'MY======'
          expect(Base32.new.decode(encoded_text, padding: true)).to eq input
        end
      end

      context 'fo' do
        let(:input) { 'fo' }
        it do
          expect(encoded_text).to eq 'MZXQ===='
          expect(Base32.new.decode(encoded_text, padding: true)).to eq input
        end
      end
    end
  end

  describe '64' do
    before do
      class Base64 < AltCharacters::AltBase
        def initialize(characters: [('A'..'Z').to_a, ('a'..'z').to_a, ('0'..'9').to_a, '/', '+'].flatten)
          super(64, characters: characters)
        end
      end
    end

    it 'encode and decode' do
      input = 1
      encoded = Base64.new.encode(input)
      expect(Base64.new.decode(encoded)).to eq(input.to_s)
    end

    describe 'with padding' do
      let(:encoded_text) { Base64.new.encode(input, padding: true) }

      context '(blank)' do
        let(:input) { '' }
        it do
          expect(encoded_text).to eq ''
          expect(Base64.new.decode(encoded_text, padding: true)).to eq input
        end
      end

      context 'f' do
        let(:input) { 'f' }
        it do
          expect(encoded_text).to eq 'Zg=='
          expect(Base64.new.decode(encoded_text, padding: true)).to eq input
        end
      end

      context 'fo' do
        let(:input) { 'fo' }
        it do
          expect(encoded_text).to eq 'Zm8='
          expect(Base64.new.decode(encoded_text, padding: true)).to eq input
        end
      end

      context 'foo' do
        let(:input) { 'foo' }
        it do
          expect(encoded_text).to eq 'Zm9v'
          expect(Base64.new.decode(encoded_text, padding: true)).to eq input
        end
      end
    end
  end

  describe '16' do
    before do
      class Base16 < AltCharacters::AltBase
        def initialize(characters: [('0'..'9').to_a, ('A'..'F').to_a].flatten)
          super(16, characters: characters)
        end
      end
    end

    it 'encode and decode' do
      input = 1
      encoded = Base16.new.encode(input)
      expect(Base16.new.decode(encoded)).to eq(input.to_s)
    end

    describe 'with padding' do
      let(:encoded_text) { Base16.new.encode(input, padding: true) }

      context '(blank)' do
        let(:input) { '' }
        it do
          expect(encoded_text).to eq ''
          expect(Base16.new.decode(encoded_text, padding: true)).to eq input
        end
      end

      context 'f' do
        let(:input) { 'f' }
        it do
          expect(encoded_text).to eq '66'
          expect(Base16.new.decode(encoded_text, padding: true)).to eq input
        end
      end

      context 'fo' do
        let(:input) { 'fo' }
        it do
          expect(encoded_text).to eq '666F'
          expect(Base16.new.decode(encoded_text, padding: true)).to eq input
        end
      end

      context 'foo' do
        let(:input) { 'foo' }
        it do
          expect(encoded_text).to eq '666F6F'
          expect(Base16.new.decode(encoded_text, padding: true)).to eq input
        end
      end
    end
  end
end
