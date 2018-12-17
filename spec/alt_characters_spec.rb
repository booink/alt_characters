# frozen_string_literal: true

RSpec.describe AltCharacters do
  it 'has a version number' do
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
      input = 1_234_567_890
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

  describe 'encodable characters' do
    it 'Just length' do
      encodable_characters = 'abcdefghijklmnopqrstuvwxyz012345'
      expect(AltCharacters::Alt32.new(characters: encodable_characters)).to be_a AltCharacters::Alt32
    end

    it 'Not enough' do
      encodable_characters = 'abcdefghijklmnopqrstuvwxyz'
      expect { AltCharacters::Alt32.new(characters: encodable_characters) }.to(
        raise_error AltCharacters::AltBase::EncodableCharactersError
      )
    end

    it 'Too many' do
      encodable_characters = 'abcdefghijklmnopqrstuvwxyz0123456789'
      expect { AltCharacters::Alt32.new(characters: encodable_characters) }.to(
        output("[warn] Too many characters specified. The last 4 characters are not used\n").to_stderr
      )
      expect(AltCharacters::Alt32.new(characters: encodable_characters)).to be_a AltCharacters::Alt32
    end
  end
end
