class Answer < ApplicationRecord
  belongs_to :survey
  has_many :author_answers, dependent: :destroy
  has_many :authors, through: :author_answers, source: :author

  validates :content, presence: true
end
