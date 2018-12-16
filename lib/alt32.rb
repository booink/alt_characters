class Alt32
  DEFAULT_CHARACTERS = 'ABCDEFGHJKLMNPQRSTWXYfghkmprstwx'.freeze

  class DecodeError < StandardError; end

  def initialize(characters: DEFAULT_CHARACTERS)
    @characters = characters.split(//) if characters.class == String
  end

  def encode(text)
    binary = text.to_s.unpack("B*").first
    binary.chars.each_slice(5).map do |chunk|
      chunk << "0" * (5 - chunk.count) if chunk.count < 5
      i = chunk.join.to_i(2)
      @characters[i]
    end.join
  end

  def decode(encoded_text)
    binary = ""
    encoded_text.to_s.chars.each do |character|
      i = @characters.index(character)
      raise DecodeError, "character(#{character}) does not exists" if i.nil?
      binary += format("%05d", i.to_s(2))
    end
    string = [binary].pack("B*")
    # string.encoding # => ASCII-8BIT
    string.force_encoding("UTF-8").gsub("\x00", "")
  end
end
