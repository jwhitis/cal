require "test/unit"
require "./cal.rb"

class CalUnitTest < Test::Unit::TestCase

  def test_13_creates_a_new_instance_of_cal
    cal = Cal.new("April", 1865)
    assert(cal)
  end

  def test_14_get_month_list_returns_month_list
    cal = Cal.new("October", 2145)
    assert_equal(["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], cal.get_month_list)
    assert_equal(["March", "April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February"], cal.get_month_list(true))
  end

  def test_15_new_instance_stores_month_and_year_values
    cal = Cal.new("September", 2050)
    assert_equal("September", cal.month)
    assert_equal(2050, cal.year)
  end

  def test_16_accepts_incomplete_month_arguments
    cal = Cal.new("Dec", 2545)
    assert_equal("December", cal.month)
  end

  def test_17_accepts_numerical_month_arguments
    cal = Cal.new(2, 2284)
    assert_equal("February", cal.month)
  end

  def test_18_raises_error_if_month_is_invalid
    assert_raise(SystemExit) do
      cal = Cal.new("Mach", 1910)
    end
    assert_raise(SystemExit) do
      cal = Cal.new(13, 1910)
    end
  end

  def test_19_raises_error_if_year_is_invalid
    assert_raise(SystemExit) do
      cal = Cal.new("July", 1776)
    end
  end

  def test_20_accepts_year_but_no_month
    cal = Cal.new(1983)
    assert_equal("all", cal.month)
    assert_equal(1983, cal.year)
  end

  def test_21_raises_error_if_given_month_but_no_year
    assert_raise(SystemExit) do
      cal = Cal.new("January")
    end
  end

  def test_22_raises_error_if_given_no_month_and_invalid_year
    assert_raise(SystemExit) do
      cal = Cal.new("1500")
    end
  end

  def test_23_stores_current_month_and_year_if_given_no_arguments
    cal = Cal.new()
    assert_equal("May", cal.month)
    assert_equal(2013, cal.year)
  end

  def test_24_get_year_header_returns_centered_year
    cal = Cal.new("August", 2999)
    assert_equal("                             2999", cal.get_year_header(2999))
  end

  def test_25_get_month_header_returns_centered_month_and_year
    even_spaces = Cal.new("May", 1966)
    odd_spaces = Cal.new("November", 1938)
    assert_equal("      May 1966", even_spaces.get_month_header("May", 1966))
    assert_equal("   November 1938", odd_spaces.get_month_header("November", 1938))
  end

  def test_26_get_month_header_returns_centered_month_only
    even_spaces = Cal.new(1804)
    assert_equal("       March", even_spaces.get_month_header("March"))
  end

  def test_27_get_day_header_returns_days_of_week
    cal = Cal.new("June", 1844)
    assert_equal("Su Mo Tu We Th Fr Sa", cal.get_day_header)
  end

  def test_28_get_first_day_index_returns_index_of_first_day_of_month
    common_year = Cal.new("August", 2109)
    leap_year = Cal.new("February", 2092)
    assert_equal(4, common_year.get_first_day_index("August", 2109))
    assert_equal(5, leap_year.get_first_day_index("February", 2092))
  end

  def test_29_get_month_days_returns_number_of_days_in_month
    common_year_31 = Cal.new("January", 2779)
    common_year_30 = Cal.new("September", 2483)
    common_year_28 = Cal.new("February", 1811)
    leap_year = Cal.new("February", 2072)
    assert_equal(31, common_year_31.get_month_days("January", 2779))
    assert_equal(30, common_year_30.get_month_days("September", 2483))
    assert_equal(28, common_year_28.get_month_days("February", 1811))
    assert_equal(29, leap_year.get_month_days("February", 2072))
  end

  def test_30_get_week_range_returns_date_range_for_week
    cal = Cal.new("November", 1945)
    assert_equal((1..3), cal.get_week_range(0, "November", 1945))
    assert_equal((4..10), cal.get_week_range(1, "November", 1945))
    assert_equal((11..17), cal.get_week_range(2, "November", 1945))
    assert_equal((18..24), cal.get_week_range(3, "November", 1945))
    assert_equal((25..30), cal.get_week_range(4, "November", 1945))
    assert_equal((32..30), cal.get_week_range(5, "November", 1945))
  end

  def test_31_format_week_returns_five_formatted_weeks
    cal = Cal.new("April", 2003)
    assert_equal("       1  2  3  4  5", cal.format_week(0, "April", 2003))
    assert_equal(" 6  7  8  9 10 11 12", cal.format_week(1, "April", 2003))
    assert_equal("13 14 15 16 17 18 19", cal.format_week(2, "April", 2003))
    assert_equal("20 21 22 23 24 25 26", cal.format_week(3, "April", 2003))
    assert_equal("27 28 29 30", cal.format_week(4, "April", 2003))
    assert_equal("", cal.format_week(5, "April", 2003))
  end

  def test_32_format_week_returns_six_formatted_weeks
    cal = Cal.new("July", 2490)
    assert_equal("                   1", cal.format_week(0, "July", 2490))
    assert_equal(" 2  3  4  5  6  7  8", cal.format_week(1, "July", 2490))
    assert_equal(" 9 10 11 12 13 14 15", cal.format_week(2, "July", 2490))
    assert_equal("16 17 18 19 20 21 22", cal.format_week(3, "July", 2490))
    assert_equal("23 24 25 26 27 28 29", cal.format_week(4, "July", 2490))
    assert_equal("30 31", cal.format_week(5, "July", 2490))
  end

  def test_33_format_month_returns_formatted_month
    cal = Cal.new("August", 1979)
    assert_equal(`cal August 1979`, cal.format_month("August", 1979))
  end

  def test_34_get_month_line_returns_month_line
    cal = Cal.new("December", 2372)
    assert_equal("      January               February               March", cal.get_month_line(0, 2))
    assert_equal("       April                  May                   June", cal.get_month_line(3, 5))
    assert_equal("        July                 August              September", cal.get_month_line(6, 8))
    assert_equal("      October               November              December", cal.get_month_line(9, 11))
  end

  def test_35_get_day_line_returns_day_line
    cal = Cal.new("April", 1872)
    assert_equal("Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa", cal.get_day_line)
  end

  def test_36_get_week_block_returns_week_block
    cal = Cal.new("March", 2601)
    jan_feb_mar = <<BLOCK
             1  2  3   1  2  3  4  5  6  7   1  2  3  4  5  6  7
 4  5  6  7  8  9 10   8  9 10 11 12 13 14   8  9 10 11 12 13 14
11 12 13 14 15 16 17  15 16 17 18 19 20 21  15 16 17 18 19 20 21
18 19 20 21 22 23 24  22 23 24 25 26 27 28  22 23 24 25 26 27 28
25 26 27 28 29 30 31                        29 30 31
                                            
BLOCK
    apr_may_june = <<BLOCK
          1  2  3  4                  1  2      1  2  3  4  5  6
 5  6  7  8  9 10 11   3  4  5  6  7  8  9   7  8  9 10 11 12 13
12 13 14 15 16 17 18  10 11 12 13 14 15 16  14 15 16 17 18 19 20
19 20 21 22 23 24 25  17 18 19 20 21 22 23  21 22 23 24 25 26 27
26 27 28 29 30        24 25 26 27 28 29 30  28 29 30
                      31                    
BLOCK
    july_aug_sept = <<BLOCK
          1  2  3  4                     1         1  2  3  4  5
 5  6  7  8  9 10 11   2  3  4  5  6  7  8   6  7  8  9 10 11 12
12 13 14 15 16 17 18   9 10 11 12 13 14 15  13 14 15 16 17 18 19
19 20 21 22 23 24 25  16 17 18 19 20 21 22  20 21 22 23 24 25 26
26 27 28 29 30 31     23 24 25 26 27 28 29  27 28 29 30
                      30 31                 
BLOCK
    oct_nov_dec = <<BLOCK
             1  2  3   1  2  3  4  5  6  7         1  2  3  4  5
 4  5  6  7  8  9 10   8  9 10 11 12 13 14   6  7  8  9 10 11 12
11 12 13 14 15 16 17  15 16 17 18 19 20 21  13 14 15 16 17 18 19
18 19 20 21 22 23 24  22 23 24 25 26 27 28  20 21 22 23 24 25 26
25 26 27 28 29 30 31  29 30                 27 28 29 30 31
                                            
BLOCK
    assert_equal(jan_feb_mar, cal.get_week_block(0, 2))
    assert_equal(apr_may_june, cal.get_week_block(3, 5))
    assert_equal(july_aug_sept, cal.get_week_block(6, 8))
    assert_equal(oct_nov_dec, cal.get_week_block(9, 11))
  end

  def test_37_format_year_returns_formatted_year
    cal = Cal.new(2755)
    assert_equal(`cal 2755`, cal.format_year(2755))
  end

  def test_38_get_first_day_index_returns_index_of_first_day_of_month
    cal = VertiCal.new("June", 2020)
    assert_equal(0, cal.get_first_day_index("June", 2020))
  end

  def test_39_get_day_array_returns_array_of_days
    cal = VertiCal.new("December", 2867)
    assert_equal(["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"], cal.get_day_array)
  end

  def test_40_format_row_returns_formatted_row
    cal = VertiCal.new("January", 1891)
    assert_equal("Mo     5 12 19 26", cal.format_row(0, "January", 1891))
    assert_equal("Tu     6 13 20 27", cal.format_row(1, "January", 1891))
    assert_equal("We     7 14 21 28", cal.format_row(2, "January", 1891))
    assert_equal("Th  1  8 15 22 29", cal.format_row(3, "January", 1891))
    assert_equal("Fr  2  9 16 23 30", cal.format_row(4, "January", 1891))
    assert_equal("Sa  3 10 17 24 31", cal.format_row(5, "January", 1891))
    assert_equal("Su  4 11 18 25", cal.format_row(6, "January", 1891))
  end

  def test_41_format_month_returns_formatted_month
    cal = VertiCal.new("May", 2013)
    assert_equal(`CAL March 2560`, cal.format_month("March", 2560))
  end

end