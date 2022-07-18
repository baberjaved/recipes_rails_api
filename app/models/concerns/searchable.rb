module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def full_text_search(keyword, fields)
      ilike_query = ilike(fields)

      where(ilike_query, keyword: "%#{keyword}%")
    end

    def filter_time_range(time_range)
      range_array = time_range.delete(' ').split('-')
      start_time = range_array.first.to_i
      end_time = range_array.last.to_i

      start_time = start_time.send(validate_time_methods(range_array.first)).in_seconds
      end_time = end_time.send(validate_time_methods(range_array.last)).in_seconds

      where("time_in_seconds BETWEEN ? AND ?", start_time, end_time)
    end

    def filter_difficulty(difficulty_level)
      where(difficulty: difficulty_level)
    end

    private
    def ilike(fields)
      fields.map { |field| "#{field} LIKE :keyword" }.join(" OR ")
    end

    def validate_time_methods(value)
      unit = value.gsub(/\d/, '')
      return unit if ['hour', 'minute', 'second'].include? unit
      return 'minutes' if unit == 'mins'

      (['hour', 'minute', 'second'].select { |arr| arr.include?(unit) }).first
    end
  end
end
  
