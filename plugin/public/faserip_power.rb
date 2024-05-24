module AresMUSH
  class FaseripPower < Ohm::Model
    include ObjectModel
    
    reference :character, "AresMUSH::Character"
    attribute :name
    attribute :notes
    attribute :rank, :type => DataType::Integer, :default => 1
    
    index :name
    
  end
end
