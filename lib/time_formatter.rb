# frozen_string_literal: true

class TimeFormatter
  TIME_FORMATS = { year: '%Y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%S' }.freeze

  def initialize(params)
    @params = params
    validate_time_formats
  end

  def result
    valid? ? converted_time_format : "Unknown time format #{@invalid_params}"
  end

  def valid?
    @invalid_params.empty?
  end

  private

  def validate_time_formats
    all_params = @params.split(',')
    @invalid_params = all_params.reject { |f| TIME_FORMATS.key? f.to_sym }
    @valid_params = all_params - @invalid_params
  end

  def converted_time_format
    format = @valid_params.map { |f| TIME_FORMATS[f.to_sym] }
    Time.now.strftime(format.join('-'))
  end
end
