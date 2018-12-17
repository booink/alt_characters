RSpec.describe AltCharacters::AltBase do
  describe 'encodable characters' do
    it "Just length" do
      encodable_characters = "abcdefghijklmnopqrstuvwxyz012345"
      expect(AltCharacters::Alt32.new(characters: encodable_characters)).to be_a AltCharacters::Alt32
    end

    it "Not enough" do
      encodable_characters = "abcdefghijklmnopqrstuvwxyz"
      expect { AltCharacters::Alt32.new(characters: encodable_characters) }.to raise_error AltCharacters::AltBase::EncodableCharactersError
    end

    it "Too many" do
      encodable_characters = "abcdefghijklmnopqrstuvwxyz0123456789"
      expect { AltCharacters::Alt32.new(characters: encodable_characters) }.to output("[warn] Too many characters specified. The last 4 characters are not used\n").to_stderr
      expect(AltCharacters::Alt32.new(characters: encodable_characters)).to be_a AltCharacters::Alt32
    end
  end

  describe 'other length' do
    before do
      class Alt64 < AltCharacters::AltBase
        def initialize(characters: [('A'..'Z').to_a, ('a'..'z').to_a, (0..9).to_a, '/', '+'].flatten)
          super(64, characters: characters)
        end
      end
    end

    it 'encode and decode' do
      input = 1
      encoded = Alt64.new.encode(input)
      expect(Alt64.new.decode(encoded)).to eq(input.to_s)
    end
  end
end
