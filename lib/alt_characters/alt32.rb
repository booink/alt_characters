require "alt_characters/alt_base"

module AltCharacters
  class Alt32 < AltBase
    DEFAULT_CHARACTERS = 'ABCDEFGHJKLMNPQRSTWXYfghkmprstwx'.freeze

    def initialize(characters: DEFAULT_CHARACTERS)
      super(32, characters: characters)
    end
  end
end
