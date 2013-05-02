class Cal
  attr_reader :month
  attr_reader :year

  def get_month_list get_first_day = false
    month_list = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    month_list = month_list.rotate!(2) if get_first_day
    month_list
  end # get_month_list method

  def get_day_list get_first_day = false
    day_list = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    day_list = day_list.rotate!(-1) if get_first_day
    day_list
  end # get_day_list method

  def initialize month = nil, year = nil
    month_list = get_month_list
    # Returns 0 if string doesn't begin with a number.
    numerical_month = month.to_i
    numerical_year = year.to_i
    if month && year
      if numerical_month == 0
        month_list.each do | current_month |
          @month = current_month if current_month.downcase[month.downcase]
        end
      else
        @month = month_list[numerical_month - 1] if (1..12).include?(numerical_month)
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
  end # get_year_header method

  def get_month_header month, year = nil
    month_header = "#{month} #{year}"
    month_header = "#{month}" if year.nil?
    month_header.center(20).rstrip!
  end #  month_head method

  def get_day_header
    "Su Mo Tu We Th Fr Sa"
  end # get_day_header method

  def get_first_day month, year
    # See http://en.wikipedia.org/wiki/Zeller's_congruence for an explanation of Zeller's congruence.
    day_list = get_day_list(true)
    month_list = get_month_list(true)
    m = month_list.index(month) + 3
    y = m > 12 ? year - 1 : year
    day_index = (1 + (((m + 1) * 26) / 10).floor + y + (y / 4).floor + (6 * (y / 100).floor) + (y / 400).floor) % 7
    day_list[day_index]
  end # get_first_day_index method

  def get_first_day_index month, year
    day_list = get_day_list
    first_day = get_first_day(month, year)
    day_list.index(first_day)
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

  def get_week_range week, month, year
    month_days = get_month_days(month, year)
    first_week_days = 7 - get_first_day_index(month, year)
    if week == 0
      first_date = 1
      last_date = first_week_days
    else
      first_date = first_week_days + 1 + ((week - 1) * 7)
      last_date = first_date + 6 < month_days ? first_date + 6 : month_days
    end
    (first_date..last_date)
  end # get_week_range method

  def format_week week, month, year
    # Week arguments are zero indexing.
    formatted_week = ""
    first_day_index = get_first_day_index(month, year)
    first_day_index.times { formatted_week += "   " } if week == 0
    week_range = get_week_range(week, month, year)
    # A downward range results in an empty string.
    week_range.each do | date |
      formatted_week += " " if date < 10
      formatted_week += "#{date}"
      formatted_week += " " unless date == week_range.end
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

  def get_month_line first_index, last_index
    month_list = get_month_list
    month_line = ""
    (first_index..last_index).each do | month_index |
      month_header = get_month_header(month_list[month_index])
      month_line += month_header
      unless month_index == last_index
        trailing_spaces = 20 - month_header.length
        trailing_spaces.times { month_line += " " }
        month_line += "  "
      end
    end
    month_line
  end # get_month_line method

  def get_day_line
    day_line = ""
    3.times do | number |
      day_header = get_day_header
      day_line += day_header
      day_line += "  " unless number == 2
    end
    day_line
  end # get_day_line method

  def get_week_block first_index, last_index
    month_list = get_month_list
    week_block = ""
    (0..5).each do | week_index |
      (first_index..last_index).each do | month_index |
        formatted_week = format_week(week_index, month_list[month_index], year)
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
    week_block
  end # get_week_block method

  def format_year year
    year_header = get_year_header(year)
    formatted_year = "#{year_header}\n\n"
    (0..11).step(3) do | first_index |
      last_index = first_index + 2
      month_line = get_month_line(first_index, last_index)
      day_line = get_day_line
      week_block = get_week_block(first_index, last_index)
      formatted_year += "#{month_line}\n#{day_line}\n#{week_block}"
    end
    formatted_year
  end # format_year method

  def easter_egg
    %(                 uuuuuuu\n             uu$$$$$$$$$$$uu\n          uu$$$$$$$$$$$$$$$$$uu\n         u$$$$$$$$$$$$$$$$$$$$$u\n        u$$$$$$$$$$$$$$$$$$$$$$$u\n       u$$$$$$$$$$$$$$$$$$$$$$$$$u\n       u$$$$$$$$$$$$$$$$$$$$$$$$$u\n       u$$$$$$"   "$$$"   "$$$$$$u\n       "$$$$"      u$u       $$$$"\n        $$$u       u$u       u$$$\n        $$$u      u$$$u      u$$$\n         "$$$$uu$$$   $$$uu$$$$"\n          "$$$$$$$"   "$$$$$$$"\n            u$$$$$$$u$$$$$$$u\n             u$"$"$"$"$"$"$u\n  uuu        $$u$ $ $ $ $u$$       uuu\n u$$$$        $$$$$u$u$u$$$       u$$$$\n  $$$$$uu      "$$$$$$$$$"     uu$$$$$$\nu$$$$$$$$$$$uu    """""    uuuu$$$$$$$$$$\n$$$$"""$$$$$$$$$$uuu   uu$$$$$$$$$"""$$$"\n """      ""$$$$$$$$$$$uu ""$"""\n           uuuu ""$$$$$$$$$$uuu\n  u$$$uuu$$$$$$$$$uu ""$$$$$$$$$$$uuu$$$\n  $$$$$$$$$$""""           ""$$$$$$$$$$$"\n   "$$$$$"                      ""$$$$""\n     $$$"                         $$$$")
  end # easter_egg method

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

end # Cal class

# Executes program if called from the command line.
if __FILE__ == $0
  cmd_month = ARGV[0]
  cmd_year = ARGV[1]
  cal = Cal.new(cmd_month, cmd_year)
  cal.render
end