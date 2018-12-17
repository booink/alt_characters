module AltCharacters
  class AltBase
    class DecodeError < StandardError; end
    class EncodableCharactersError < StandardError; end

    def initialize(length, characters: nil)
      @length = length
      @logarithm = Math.log2(length)
      @characters = characters
      @characters = characters.split(//) if characters.class == String
      count = @characters.count
      if count < length
        raise EncodableCharactersError, "Not enough characters. #{count} characters specified"
      elsif count > length
        warn "[warn] Too many characters specified. The last #{count - length} characters are not used"
      end
    end

    def encode(text)
      binary = text.to_s.unpack("B*").first
      binary.chars.each_slice(@logarithm).map do |chunk|
        chunk << "0" * (@logarithm - chunk.count) if chunk.count < @logarithm
        i = chunk.join.to_i(2)
        @characters[i]
      end.join
    end

    def decode(encoded_text)
      binary = ""
      encoded_text.to_s.chars.each do |character|
        i = @characters.index(character)
        raise DecodeError, "character(#{character}) does not exists" if i.nil?
        binary += format("%0#{@logarithm}d", i.to_s(2))
      end
      string = [binary].pack("B*")
      # string.encoding # => ASCII-8BIT
      string.force_encoding("UTF-8").gsub("\x00", "")
    end
  end
end
