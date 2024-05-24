module AresMUSH
  module Faserip
    class ResetCmd
      include CommandHandler

      def check_chargen_locked
        Chargen.check_chargen_locked(enactor)
      end

      def handle
        Faserip.reset_char(enactor)        
        client.emit_success t('faserip.reset_complete')
      end
    end
  end
end
