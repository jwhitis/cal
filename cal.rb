month_arg = ARGV[0]
year_arg = ARGV[1]

class Cal
  attr_reader :month
  attr_reader :year

  def initialize month = nil, year = nil
    possible_months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    if month && year
      if month.class == Fixnum
        @month = possible_months[month - 1] if (1..12).include?(month)
      elsif month.class == String
        possible_months.each do | current_month |
          @month = current_month if current_month.downcase[month.downcase]
        end
      end
      raise ArgumentError, "#{month} is not a valid month." if @month.nil?
      @year = year
    elsif month && year.nil?
      @month = "all"
      @year = month
    else
      @month = "April"
      @year = 2013
    end
    raise ArgumentError, "#{year} is not a valid year." unless (1800..3000).include?(@year)
  end # initialize method

  def month_header month, year = nil
    header = "#{month} #{year}"
    header = "#{month}" if year.nil?
    leading_spaces = ((20 - header.length) / 2).floor
    leading_spaces.times { header.prepend(" ") }
    trailing_spaces = 20 - header.length
    trailing_spaces.times { header += " " }
    header
  end #  month_head method

  def day_header
    "Su Mo Tu We Th Fr Sa"
  end # day_header method

  def get_first_day month, year
    # The day indexing used in Zeller's Congruence starts on Saturday rather than Sunday.
    formula_days = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    formula_months = ["March", "April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February"]
    m = formula_months.index(month) + 3
    y = year
    y -= 1 if m > 12
    day_index = (1 + (((m + 1) * 26) / 10).floor + y + (y / 4).floor + (6 * (y / 100).floor) + (y / 400).floor) % 7
    formula_days[day_index]
  end # get_first_day_index method

  def get_first_day_index month, year
    possible_days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    first_day = get_first_day(month, year)
    first_day_index = possible_days.index(first_day)
    first_day_index
  end # get_first_day_index method

  def get_month_days month, year
    month_days = 31
    month_days = 30 if ["April", "June", "September", "November"].include?(month)
    if month == "February"
      month_days = year % 4 == 0 ? 29 : 28
      month_days = 28 if year % 100 == 0 && year % 400 != 0
    end
    month_days
  end # get_month_days method

  def format_week week, month, year
    # Week arguments are zero indexing.
    month_days = get_month_days(month, year)
    first_day_index = get_first_day_index(month, year)
    first_week_days = 7 - first_day_index
    formatted_week = ""
    if week == 0
      first_day_index.times { formatted_week += "   " }
      (1..first_week_days).each do | date |
        formatted_week += " #{date}"
        formatted_week += " " unless date == first_week_days
      end
    else
      first_date = first_week_days + 1 + ((week - 1) * 7)
      last_date = first_date + 6 < month_days ? first_date + 6 : month_days 
      (first_date..last_date).each do | date|
        formatted_week += " " if date < 10
        formatted_week += "#{date}"
        formatted_week += " " unless date == last_date
      end
      if formatted_week.length < 20
        trailing_spaces = 20 - formatted_week.length
        trailing_spaces.times { formatted_week += " " }
      end
    end
    formatted_week
  end # format_week method

  # def print_cal
  #   puts "#{@month} #{@year}"
  # end

end # Cal class

# cal = Cal.new(month_arg, year_arg)
# cal.print_cal

# print `cal #{month_arg} #{year_arg}`