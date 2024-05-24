module AresMUSH
  module Faserip

    def self.build_web_char_data(char, viewer, chargen)
      builder = WebAbilityListBuilder.new
      builder.build(char, viewer, chargen)
    end

    def self.build_web_chargen_info()
      builder = WebChargenInfoBuilder.new
      builder.build()
    end

  end
end
