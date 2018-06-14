class User < ActiveRecord::Base
  has_many :boards
  has_many :trips, through: :boards

  has_secure_password
  validates :username, :email, :password, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: true

  def slug
    if self.username.include?(" ")
      self.username.downcase.gsub(" ", "-")
    else
      self.username.downcase
    end
  end

  def self.find_by_slug(slugified_name)
    self.all.detect{|user| user.slug == slugified_name}
  end

end
