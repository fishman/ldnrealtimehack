class Win < ActiveRecord::Base
  belongs_to :user
  before_create :reset_count

  def reset_count
    self.count = 0
  end

  def text
    user.name
  end

  def value
    count
  end
end
