$:.unshift File.dirname(__FILE__)

module AresMUSH
  module Faserip

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("faserip", "shortcuts")
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "abilities"
        return AbilitiesCmd
      when "set"
        return AbilitySetCmd
      when "sheet"
        return SheetCmd
      when "reset"
        return ResetCmd
      end
      nil
    end

    def self.get_event_handler(event_name)
      nil
    end

    def self.get_web_request_handler(request)
      case request.cmd
      when "abilities"
        return AbilitiesRequestHandler
      when "resetFaseripAbilities"
        return ResetAbilitiesRequestHandler
      end
      nil
    end

  end
end
