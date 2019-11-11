module ParamsUtils
  def float?(arg)
    Float(arg) unless arg.blank?
  rescue ArgumentError
    raise Exceptions::InvalidParameters, arg + ' is not a valid Float'
  end
  
  def parse_dates(start_date, end_date)
    start_date = parse_date(start_date)
    end_date = parse_date(end_date)
    if end_date.present?
      end_date = end_date.to_time.end_of_day
      if start_date.present?
        start_date = start_date.to_time.beginning_of_day
        if end_date < start_date
          raise Exceptions::InvalidParameters, 'The start date must be before the end date'
        end
      end
    end

    [start_date, end_date]
  rescue ArgumentError => e
    raise Exceptions::InvalidParameters, e
  end
end
