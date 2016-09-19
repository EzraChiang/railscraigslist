class Article < ApplicationRecord
  validates :title, :body, presence: true

  belongs_to :category

  def secret_generate
    new_secret = self.randomizer
    self.secret = new_secret
  end

  def randomizer
    it = [('a'..'z'), ('A'..'Z')].map{|i| i.to_a}.flatten
    strings = (0...7).map{it[rand(it.length)]}.join
    strings
  end

end
