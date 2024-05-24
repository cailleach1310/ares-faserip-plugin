module AresMUSH
  class FaseripSkill < Ohm::Model
    include ObjectModel
    
    reference :character, "AresMUSH::Character"
    attribute :name
    attribute :rank, :type => DataType::Integer, :default => 1
    
    index :name
    
  end
end
