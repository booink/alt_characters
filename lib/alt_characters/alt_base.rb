# frozen_string_literal: true

module AltCharacters
  class AltBase
    class DecodeError < StandardError; end
    class EncodableCharactersError < StandardError; end

    OCTET = 8 # bit

    def initialize(length, characters: nil, padding_character: '=')
      @length = length
      @padding_character = padding_character
      @logarithm = Math.log2(length).to_i # 2**n
      @characters = characters
      @characters = characters.split(//) if characters.class == String
      count = @characters.count
      raise EncodableCharactersError, "Not enough characters. #{count} characters specified" if count < length

      warn "[warn] Too many characters specified. The last #{count - length} characters are not used" if count > length
    end

    # rubocop:disable Metrics/AbcSize
    def encode(text, padding: false)
      binary = text.to_s.unpack1('B*')
      encoded_characters = binary.chars.each_slice(@logarithm).map do |chunk|
        chunk << '0' * (@logarithm - chunk.count) if chunk.count < @logarithm
        i = chunk.join.to_i(2)
        @characters[i]
      end
      encoded_characters = add_padding(encoded_characters) if padding && need_padding?(encoded_characters)

      encoded_characters.join
    end
    # rubocop:enable Metrics/AbcSize

    def decode(encoded_text, padding: false)
      binary = ''
      encoded_text.to_s.chars.each do |character|
        break if padding && character == @padding_character

        i = @characters.index(character)
        raise DecodeError, "character(#{character}) does not exists" if i.nil?

        binary += format("%0#{@logarithm}d", i.to_s(2))
      end
      string = [binary].pack('B*')
      # string.encoding # => ASCII-8BIT
      string.force_encoding('UTF-8').delete("\x00")
    end

    private

    def missing_chunks(characters)
      number_of_group_characters = @logarithm.lcm(OCTET) / @logarithm
      modulo = characters.count % number_of_group_characters
      modulo.zero? ? 0 : number_of_group_characters - modulo
    end

    def need_padding?(characters)
      missing_chunks(characters) != 0
    end

    def add_padding(characters)
      missing_chunks(characters).times do
        characters << @padding_character
      end
      characters
    end
  end
end
