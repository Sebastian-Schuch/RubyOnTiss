class Person < ApplicationRecord
  has_many :favorites, as: :favoritable, dependent: :destroy

  def full_name
    [prefix_title, firstname, lastname, postfix_title].compact.join(' ')
  end

  def title_with_short
    full_name
  end

end
