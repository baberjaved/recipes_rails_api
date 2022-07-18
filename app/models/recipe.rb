class Recipe < ApplicationRecord
  include ConstantValidatable
  include Searchable

  # jitera-anchor-dont-touch: relations

  has_many :ingredients, dependent: :destroy

  has_many :ratings, dependent: :destroy

  has_many :reviewers, through: :ratings, class_name: 'User', source: :user

  belongs_to :category

  belongs_to :user

  # jitera-anchor-dont-touch: enum
  enum difficulty: %w[easy normal challenging], _suffix: true

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :title, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  validates :descriptions, length: { maximum: 65_535, minimum: 0, message: I18n.t('.out_of_range_error') },
                           presence: true

  validates :time, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  validates :difficulty, presence: true

  accepts_nested_attributes_for :ingredients

  after_save :compute_time_in_seconds

  def self.associations
    [:ingredients]
  end

  # jitera-anchor-dont-touch: reset_password

  class << self
  end

  def compute_time_in_seconds
    if saved_changes.include? "time"
      integer_time = time.to_i

      update(time_in_seconds: integer_time.send(time.delete(' ').gsub(/\d/, '')).in_seconds)
    end
  end
end
