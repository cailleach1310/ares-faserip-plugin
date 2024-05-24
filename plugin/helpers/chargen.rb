module AresMUSH
  module Faserip

    def self.abilities_not_set(char)
       return char.attributes.empty?
    end

    def self.reset_char(char)
      char.attributes.each { |s| s.delete }
      char.skills.each { |s| s.delete }
      char.powers.each { |s| s.delete }
      char.advantages.each { |s| s.delete }
      char.disadvantages.each { |s| s.delete }
      Faserip.primary_attributes.map{ |a| a["name"] }.each do |a|
        set_ability(char, a, 1, nil)
      end
    end

    def self.set_ability(char, name, rank, notes)
      name = name.titleize
      ability_type = Faserip.ability_type(name)
      return nil if !ability_type
      ability = Faserip.find_ability(char, name)
      if (ability)
        ability.update(rank: rank)
        case ability_type
        when :advantage, :disadvantage, :power
          ability.update(notes: notes)
        end
      else
        ability_type = Faserip.ability_type(name)
        case ability_type
        when :attribute
          ability = FaseripAttribute.create(character: char, name: name, rank: rank )
        when :skill
          ability = FaseripSkill.create(character: char, name: name, rank: rank )
        when :power
          ability = FaseripPower.create(character: char, name: name, rank: rank, notes: notes )
        when :advantage
          ability = FaseripAdvantage.create(character: char, name: name, rank: rank, notes: notes )
        when :disadvantage
          ability = FaseripDisadvantage.create(character: char, name: name, rank: rank, notes: notes )
        end
      end
      return nil
    end

# Saving abilities from web chargen
    def self.save_web_abilities(char, chargen_data)
       save_attrs(char, chargen_data[:custom][:attrs])
       save_skills(char, chargen_data[:custom][:skills])
       save_option_list(char, chargen_data[:custom][:advantages])
       save_option_list(char, chargen_data[:custom][:disadvantages])
       save_option_list(char, chargen_data[:custom][:powers])
    end

    def self.save_attrs(char, list)
      alerts = []
      (list || {}).each do |a, b|
        Global.logger.debug "Saving " + a + " - " + b.to_s
        error = set_ability(char, a, b, nil)
        if (error)
          alerts << t('faserip.error_saving_ability', :name => a, :error => error)
        end
      end
     return alerts
    end

    def self.save_skills(char, list)
      alerts = []
      (list || {}).each do |a, b|
        Global.logger.debug "Saving " + a + " - " + b.to_s
        if (b.to_i > 0)
           error = set_ability(char, a, b.to_i, nil)
           if (error)
             alerts << t('faserip.error_saving_ability', :name => a, :error => error)
           end
        else
          skill = find_ability(char, a)
          if (skill)
            skill.delete
          end          
        end
      end
     return alerts
    end

    def self.save_option_list(char, list)
      alerts = []
      (list || {}).each do |a, b|
        Global.logger.debug "Saving " + a + " -  " + b
        rank = b.split(":")[0].to_i
        notes = b.split(":")[1]
        if (rank > 0)
           error = set_ability(char, a, rank, notes )
           if (error)
              alerts << t('faserip.error_saving_ability', :name => a, :error => error)
           end
        else
          option = find_ability(char, a)
          if (option)
            option.delete
          end
        end
      end
     return alerts
    end

  end
end
