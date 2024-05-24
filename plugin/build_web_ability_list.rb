module AresMUSH
  module Faserip
    class WebAbilityListBuilder

      def build(char, viewer, chargen)

        is_owner = (viewer && viewer.id == char.id)

        show_sheet = Faserip.can_view_sheets?(viewer) || is_owner

        if (chargen)
          {
             attrs: ability_chargen_list(char, "attribute"),
             skills: ability_chargen_list(char, "skill"),
             powers: option_chargen_list(char, Faserip.powers),
             advantages: option_chargen_list(char, Faserip.advantages),
             disadvantages: option_chargen_list(char, Faserip.disadvantages),
             secondary_attributes: Faserip.secondary_attributes(char),
             reset_needed: Faserip.abilities_not_set(char)
          }
        else
         if (show_sheet)
          {
            attrs: ability_list(char, "attribute"),
            skills: ability_list(char, "skill"),
            advantages: option_list(char.advantages),
            disadvantages: option_list(char.disadvantages),
            secondary_attributes: Faserip.secondary_attributes(char),
            show_sheet: show_sheet
          }
         end
        end
      end

      def ability_list(char, type)
        list = []
        if (type == "attribute")
           char.attributes.each do |a|
             list << { name: a.name, rank: a.rank, rank_name: Faserip.get_rank_name(a.rank), rank_short: Faserip.get_rank_short(a.rank) }
           end
        elsif (type == "skill")
           char.skills.each do |s|
             list << { name: s.name, rank: s.rank }
           end 
        end
        return list
      end

      def ability_chargen_list(char, type)
        list = []
        if (type == "attribute")
           Faserip.primary_attributes.each do |a|
           ability = Faserip.find_ability(char, a['name'])
           list << { name: a['name'], rank: ability.rank, desc: a["desc"] }
           end
        elsif (type == "skill")
           Faserip.skills.each do |a|
              ability = Faserip.find_ability(char, a['name'])
              if (ability)
                 skill_rank = ability.rank
              else
                 skill_rank = 0
              end
              list << { name: a['name'], rank: skill_rank, desc: a["desc"] }
           end
        end
        return list
      end

      def option_list(option_list)
        list = []
        option_list.each do |s|
           list << { name: s.name, rank: s.rank, notes: s.notes }
        end
        return list
      end

      def option_chargen_list(char, cg_list)
        list = []
        cg_list.each do |a|
           ability = Faserip.find_ability(char, a['name'])
           if (ability)
             list << { name: a['name'], rank: ability.rank, notes: ability.notes }
           end
        end
        return list
      end

    end
  end
end
