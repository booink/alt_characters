# frozen_string_literal: true

require 'alt_characters/alt_base'

module AltCharacters
  class Alt32 < AltBase
    DEFAULT_CHARACTERS = 'ABCDEFGHJKLMNPQRSTWXYfghkmprstwx'

    def initialize(characters: DEFAULT_CHARACTERS)
      super(32, characters: characters)
    end
  end
end
