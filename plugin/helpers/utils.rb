module AresMUSH
  module Faserip

    def self.primary_attributes
      Global.read_config("faserip", "primary_attributes")
    end

    def self.attribute_ranks
      Global.read_config("faserip", "attribute_ranks")
    end

    def self.skills
      Global.read_config("faserip", "skills")
    end

    def self.advantages
      Global.read_config("faserip", "advantages")
    end

    def self.disadvantages
      Global.read_config("faserip", "disadvantages")
    end

    def self.powers
      Global.read_config("faserip", "powers")
    end

    def self.attributes_blurb
      Global.read_config("faserip", "attributes_blurb")
    end

    def self.skills_blurb
      Global.read_config("faserip", "skills_blurb")
    end

    def self.powers_blurb
      Global.read_config("faserip", "powers_blurb")
    end

    def self.advantages_blurb
      Global.read_config("faserip", "advantages_blurb")
    end

    def self.disadvantages_blurb
      Global.read_config("faserip", "disadvantages_blurb")
    end

    def self.can_view_sheets?(actor)
      return true if Global.read_config("faserip", "show_sheet")
      return false if !actor
      actor.has_permission?("view_sheets")
    end

    def self.secondary_attributes(char)
      list = []
      secondary_list = Global.read_config("faserip", "secondary_attributes")
      secondary_list.each do |sec|
        list << { 'name' => sec["name"], 'rank' => calc_sum(char, sec["attributes"].split(" ")) }
      end
      return list
    end

    def self.calc_sum(char, list)
      sum = 0
      list.each do |attr|
         sum = sum + ability_rank(char, attr)
      end
      return sum     
    end

    def self.ability_rank(char, ability_name)
      ability = find_ability(char, ability_name)
      if (ability)
         return ability.rank
      else
         return
      end
    end

    def self.ability_type(ability)
      ability = ability.titlecase
      if primary_attributes.map { |a| a["name"].titlecase }.include?(ability)
        return :attribute
      elsif skills.map { |a| a["name"].titlecase }.include?(ability)
        return :skill
      elsif advantages.map { |a| a["name"] }.include?(ability)
        return :advantage
      elsif disadvantages.map { |a| a["name"] }.include?(ability)
        return :disadvantage
      elsif powers.map { |a| a["name"] }.include?(ability)
        return :power
      else
        return nil
      end
    end

    def self.get_rank_name(rank)
      return attribute_ranks.find{ |a| a["value"] == rank }["name"]
    end

    def self.get_rank_short(rank)
      return attribute_ranks.find{ |a| a["value"] == rank }["short"]
    end

    def self.find_ability(char, ability_name)
      return nil if !ability_name
      ability_name = ability_name.titlecase
      ability_type = ability_type(ability_name)
      case ability_type
      when :attribute
        char.attributes.find(name: ability_name).first
      when :skill
        char.skills.find(name: ability_name).first
      when :power
        char.powers.find(name: ability_name).first
      when :advantage
        char.advantages.find(name: ability_name).first
      when :disadvantage
        char.disadvantages.find(name: ability_name).first
      else
        nil
      end
    end

  end
end
