class Match < ActiveRecord::Base
  belongs_to :player1, :class_name => "User"
  belongs_to :player2, :class_name => "User"
  
  before_create :set_match_id

  def set_match_id
    self.unique_id = SecureRandom.uuid.gsub("-", "")
  end
end
