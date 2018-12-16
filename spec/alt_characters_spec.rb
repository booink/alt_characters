# encoding: utf-8

RSpec.describe AltCharacters do
  it "has a version number" do
    expect(AltCharacters::VERSION).not_to be nil
  end

  describe 'encode and decode' do
    it '1' do
      input = 1
      encoded = AltCharacters.alt32_encode(input)
      expect(AltCharacters.alt32_decode(encoded)).to eq(input.to_s)
    end

    it 'a' do
      input = 'a'
      encoded = AltCharacters.alt32_encode(input)
      expect(AltCharacters.alt32_decode(encoded)).to eq(input.to_s)
    end

    it '1234567890' do
      input = 1234567890
      encoded = AltCharacters.alt32_encode(input)
      expect(AltCharacters.alt32_decode(encoded)).to eq(input.to_s)
    end

    it 'abcdefg' do
      input = 'abcdefg'
      encoded = AltCharacters.alt32_encode(input)
      expect(AltCharacters.alt32_decode(encoded)).to eq(input.to_s)
    end

    it '!#$%&()=~|' do
      input = '!#$%&()=~|'
      encoded = AltCharacters.alt32_encode(input)
      expect(AltCharacters.alt32_decode(encoded)).to eq(input.to_s)
    end

    it 'あいうえお' do
      input = 'あいうえお'
      encoded = AltCharacters.alt32_encode(input)
      expect(AltCharacters.alt32_decode(encoded)).to eq(input.to_s)
    end
  end

  it 'decode error' do
    expect { AltCharacters.alt32_decode('abcde') }.to raise_error Alt32::DecodeError
    expect { AltCharacters.alt32_decode('12345') }.to raise_error Alt32::DecodeError
    expect { AltCharacters.alt32_decode('!#$%&') }.to raise_error Alt32::DecodeError
    expect { AltCharacters.alt32_decode('あいうえお') }.to raise_error Alt32::DecodeError
  end
end
