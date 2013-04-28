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

  def month_header
    header = "#{@month} #{@year}"
    leading_spaces = ((20 - header.length) / 2).floor
    leading_spaces.times { header.prepend(" ") }
    trailing_spaces = 20 - header.length
    trailing_spaces.times { header += " " }
    header
  end #  month_head method

  def day_header
    "Su Mo Tu We Th Fr Sa"
  end # day_header method

  def get_first_day
    formula_days = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    formula_months = ["March", "April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February"]
    m = formula_months.index(@month) + 3
    y = @year
    y -= 1 if m > 12
    index = (1 + (((m + 1) * 26) / 10).floor + y + (y / 4).floor + (6 * (y / 100).floor) + (y / 400).floor) % 7
    formula_days[index]
  end # get_first_day_index method

  def format_weeks

    # days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    # first_day = get_first_day
    # index = days.index(first_day)
    # number_of_days = 31
    # number_of_days = 30 if ["April", "June", "September", "November"].include?(@month)
    # number_of_days = 28 if @month == "February"
    # index

  end

  # def print_cal
  #   puts "#{@month} #{@year}"
  # end

end # Cal class

# cal = Cal.new(month_arg, year_arg)
# cal.print_cal

# print `cal #{month_arg} #{year_arg}`