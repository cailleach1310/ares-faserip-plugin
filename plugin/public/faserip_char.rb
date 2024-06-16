module AresMUSH
  class Character
    collection :primary_attributes, "AresMUSH::FaseripAttribute"
    collection :skills, "AresMUSH::FaseripSkill"
    collection :powers, "AresMUSH::FaseripPower"
    collection :advantages, "AresMUSH::FaseripAdvantage"
    collection :disadvantages, "AresMUSH::FaseripDisadvantage"

    before_delete :delete_abilities
    
    def delete_abilities
      [ self.primary_attributes, self.skills, self.advantages, self.disadvantages, self.powers ].each do |list|
        list.each do |a|
          a.delete
        end
      end
    end

  end
end
