# frozen_string_literal: true

require 'alt_characters/version'
require 'alt32'

module AltCharacters
  class << self
    def alt32_encode(text)
      Alt32.new.encode(text)
    end

    def alt32_decode(encoded_text)
      Alt32.new.decode(encoded_text)
    end
  end
end
