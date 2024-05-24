module AresMUSH
  module Faserip
    class AbilitySetCmd
      include CommandHandler
      
      attr_accessor :name, :rank

      def parse_args
          args = cmd.parse_args(ArgParser.arg1_equals_arg2)
          self.name = titlecase_arg(args.arg1)
          self.rank = args.arg2
      end

      def required_args
        [ self.name, self.rank ]
      end

      def check_chargen_locked
        Chargen.check_chargen_locked(enactor)
      end
      
      def handle
        ability_type = Faserip.ability_type(self.name)

        case ability_type
          when :advantage, :disadvantage, :power
            client.emit "Please use the command option/set."
            return
        end

        if (ability_type == :attribute)
           valid_ranks = Faserip.attribute_ranks.map{ |a| a["short"]}
           if !valid_ranks.include?(self.rank)
             client.emit "Invalid rank! Please choose one of the following: " + valid_ranks.join(", ")
             return 
           else
             rank = Faserip.attribute_ranks.first { |a| a["short"] == self.rank }["value"]
           end
        else
           rank = self.rank
        end
        Faserip.set_ability(enactor, self.name, rank)
        client.emit_success Faserip.ability_raised_text(enactor, self.name)
      end

    end
  end
end
