class Cal
  attr_reader :month
  attr_reader :year

  def initialize month = nil, year = nil
    possible_months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    # Returns 0 if string doesn't begin with a number.
    numerical_month = month.to_i
    numerical_year = year.to_i
    if month && year
      if numerical_month == 0
        possible_months.each do | current_month |
          @month = current_month if current_month.downcase[month.downcase]
        end
      else
        @month = possible_months[numerical_month - 1] if (1..12).include?(numerical_month)
      end
      abort("cal: #{month} is neither a month number (1..12) nor a name") if @month.nil?
      @year = numerical_year
    elsif month && year.nil?
      @month = "all"
      @year = numerical_month
    else
      @month = `date +"%B"`.chomp!
      @year = `date +"%Y"`.to_i
    end
    abort("cal: year #{@year} not in range 1800..3000") unless (1800..3000).include?(@year)
  end # initialize method

  def get_year_header year
    year_header = "#{year}"
    year_header.center(62).rstrip!
  end

  def get_month_header month, year = nil
    month_header = "#{month} #{year}"
    month_header = "#{month}" if year.nil?
    month_header.center(20).rstrip!
  end #  month_head method

  def get_day_header
    "Su Mo Tu We Th Fr Sa"
  end # get_day_header method

  def get_first_day month, year
    # The day indexing used in Zeller's Congruence starts on Saturday rather than Sunday.
    formula_days = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    formula_months = ["March", "April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February"]
    m = formula_months.index(month) + 3
    y = m > 12 ? year - 1 : year
    day_index = (1 + (((m + 1) * 26) / 10).floor + y + (y / 4).floor + (6 * (y / 100).floor) + (y / 400).floor) % 7
    formula_days[day_index]
  end # get_first_day_index method

  def get_first_day_index month, year
    possible_days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    first_day = get_first_day(month, year)
    possible_days.index(first_day)
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
      first_date = 1
      last_date = first_week_days
    else
      first_date = first_week_days + 1 + ((week - 1) * 7)
      last_date = first_date + 6 < month_days ? first_date + 6 : month_days
    end
    # A downward range results in an empty string.
    (first_date..last_date).each do | date|
      formatted_week += " " if date < 10
      formatted_week += "#{date}"
      formatted_week += " " unless date == last_date
    end
    formatted_week
  end # format_week method

  def format_month month, year
    month_header = get_month_header(month, year)
    day_header = get_day_header
    formatted_month = "#{month_header}\n#{day_header}\n"
    (0..5).each do | week |
      formatted_week = format_week(week, month, year)
      formatted_month += formatted_week + "\n"
    end
    formatted_month
  end # format_month method

  def format_year year
    possible_months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    year_header = get_year_header(year)
    formatted_year = "#{year_header}\n\n"
    (0..11).step(3) do | first_index |
      last_index = first_index + 2
      # Formats row of month headers.
      month_line = ""
      (first_index..last_index).each do | month_index |
        month_header = get_month_header(possible_months[month_index])
        month_line += month_header
        unless month_index == last_index
          trailing_spaces = 20 - month_header.length
          trailing_spaces.times { month_line += " " }
          month_line += "  "
        end
      end
      # Formats row of day headers.
      day_line = ""
      (first_index..last_index).each do | number |
        day_header = get_day_header
        day_line += day_header
        day_line += "  " unless number == last_index
      end
      # Formats six rows of weeks.
      week_block = ""
      (0..5).each do | week_index |
        (first_index..last_index).each do | month_index |
          formatted_week = format_week(week_index, possible_months[month_index], year)
          week_block += formatted_week
          if month_index == last_index
            week_block += "\n"
          else
            trailing_spaces = 20 - formatted_week.length
            trailing_spaces.times { week_block += " " }
            week_block += "  "
          end
        end
      end
      formatted_year += "#{month_line}\n#{day_line}\n#{week_block}"
    end
    formatted_year
  end # format_year method

  def render
    cal = if @month == "June" && @year == 1966
            easter_egg
          elsif @month == "all"
            format_year(@year)
          else
            format_month(@month, @year)
          end
    puts cal
  end # print_cal method

  def easter_egg
    %(                 uuuuuuu\n             uu$$$$$$$$$$$uu\n          uu$$$$$$$$$$$$$$$$$uu\n         u$$$$$$$$$$$$$$$$$$$$$u\n        u$$$$$$$$$$$$$$$$$$$$$$$u\n       u$$$$$$$$$$$$$$$$$$$$$$$$$u\n       u$$$$$$$$$$$$$$$$$$$$$$$$$u\n       u$$$$$$"   "$$$"   "$$$$$$u\n       "$$$$"      u$u       $$$$"\n        $$$u       u$u       u$$$\n        $$$u      u$$$u      u$$$\n         "$$$$uu$$$   $$$uu$$$$"\n          "$$$$$$$"   "$$$$$$$"\n            u$$$$$$$u$$$$$$$u\n             u$"$"$"$"$"$"$u\n  uuu        $$u$ $ $ $ $u$$       uuu\n u$$$$        $$$$$u$u$u$$$       u$$$$\n  $$$$$uu      "$$$$$$$$$"     uu$$$$$$\nu$$$$$$$$$$$uu    """""    uuuu$$$$$$$$$$\n$$$$"""$$$$$$$$$$uuu   uu$$$$$$$$$"""$$$"\n """      ""$$$$$$$$$$$uu ""$"""\n           uuuu ""$$$$$$$$$$uuu\n  u$$$uuu$$$$$$$$$uu ""$$$$$$$$$$$uuu$$$\n  $$$$$$$$$$""""           ""$$$$$$$$$$$"\n   "$$$$$"                      ""$$$$""\n     $$$"                         $$$$")
  end # easter_egg method

end # Cal class

# Executes program if called from the command line.
if __FILE__ == $0
  cmd_month = ARGV[0]
  cmd_year = ARGV[1]
  cal = Cal.new(cmd_month, cmd_year)
  cal.render
end