class Survey < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :answers, dependent: :destroy, class_name: 'Answer', inverse_of: :survey
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  validates :content, presence: true
  validates :author, presence: true
  validates :end_date, presence: true
  validate :end_date_cannot_be_in_the_past
  validate :must_have_at_least_two_answers

  scope :active, -> { where('end_date >= ?', Time.zone.today) }

  scope :inactive, -> { where('end_date < ?', Time.zone.today) }

  def active?
    end_date >= Time.zone.today
  end

  private

  def end_date_cannot_be_in_the_past
    errors.add(:end_date, "can't be in the past") if end_date.present? && end_date < Time.zone.today
  end

  def must_have_at_least_two_answers
    return unless answers.reject(&:marked_for_destruction?).size < 2

    errors.add(:survey, 'must have at least two answers')
  end
end
