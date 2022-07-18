class Ingredient < ApplicationRecord
  include ConstantValidatable

  # jitera-anchor-dont-touch: relations

  belongs_to :recipe

  # jitera-anchor-dont-touch: enum
  enum unit: %w[cup teaspoons gram kilogram], _suffix: true

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :unit, presence: true

  validates :amount,
            numericality: { greater_than: 0.0, less_than: 3.402823466e+38, message: I18n.t('.out_of_range_error') }, presence: true

  # jitera-anchor-dont-touch: reset_password

  WEIGHT_CONVERTER = {
    "cup": {
      "teaspoons": 1 * 48,
      "gram": 1 * 200,
      "kilogram": 1 / 8.to_f
    },
    "teaspoons": {
      "cup": 1 / 48.to_f,
      "gram": 1 * 5.69.to_f,
      "kilogram": 1 / 240.to_f
    },
    "gram": {
      "cup": 1 / 200.to_f,  
      "teaspoons": 1 * 0.24.to_f,
      "kilogram": 1 / 1000.to_f
    },
    "kilogram": {
      "cup": 1 * 8,
      "teaspoons": 1 * 240,
      "gram": 1 * 1000.to_f,
    }
  }

  class << self
    def weight_converter(params)
      return if params.blank?

      new_amount = params[:amount].to_f * (WEIGHT_CONVERTER.dig(params[:unit_from].to_sym, params[:unit_to].to_sym)).to_f

      {
        unit_from: params[:unit_from],
        unit_to: params[:unit_to],
        old_amount: params[:amount],
        new_amount: new_amount
      }
    end
  end
end
