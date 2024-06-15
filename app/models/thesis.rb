class Thesis < ApplicationRecord
  has_many :favorites, as: :favoritable, dependent: :destroy

  def title_with_short
    "#{title} - #{short}"
  end
end
