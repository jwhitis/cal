require "test/unit"
require "./cal.rb"

class CalUnitTest < Test::Unit::TestCase

  def test_13_creates_a_new_instance_of_cal
    cal = Cal.new("April", 1865)
    assert(cal)
  end

  def test_14_get_month_list_returns_month_list
    cal = Cal.new("October", 2145)
    month_list = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    assert_equal(month_list, cal.get_month_list)
  end

  def test_15_get_month_list_returns_zellers_month_list
    cal = Cal.new("October", 2145)
    month_list = ["March", "April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February"]
    assert_equal(month_list, cal.get_month_list(true))
  end

  def test_16_new_instance_stores_month_value
    cal = Cal.new("September", 2050)
    assert_equal("September", cal.month)
  end

  def test_17_new_instance_stores_year_value
    cal = Cal.new("September", 2050)
    assert_equal(2050, cal.year)
  end

  def test_18_accepts_incomplete_month_name_arguments
    cal = Cal.new("Dec", 2545)
    assert_equal("December", cal.month)
  end

  def test_19_accepts_numerical_month_arguments
    cal = Cal.new(2, 2284)
    assert_equal("February", cal.month)
  end

  def test_20_raises_error_if_month_is_invalid_string
    assert_raise(SystemExit) do
      cal = Cal.new("Mach", 1910)
    end
  end

  def test_21_raises_error_if_month_is_invalid_number
    assert_raise(SystemExit) do
      cal = Cal.new(13, 1910)
    end
  end

  def test_22_raises_error_if_year_is_invalid
    assert_raise(SystemExit) do
      cal = Cal.new("July", 1776)
    end
  end

  def test_23_accepts_year_but_no_month
    assert_nothing_raised do
      cal = Cal.new(1983)
    end
  end

  def test_24_month_value_for_full_year_is_all
    cal = Cal.new(1983)
    assert_equal("all", cal.month)
  end

  def test_25_year_value_for_full_year_is_year
    cal = Cal.new(1983)
    assert_equal(1983, cal.year)
  end

  def test_26_raises_error_if_given_month_but_no_year
    assert_raise(SystemExit) do
      cal = Cal.new("January")
    end
  end

  def test_27_raises_error_if_given_no_month_and_invalid_year
    assert_raise(SystemExit) do
      cal = Cal.new("1500")
    end
  end

  # Expected value should be current month.
  def test_28_stores_current_month_if_given_no_arguments
    cal = Cal.new()
    assert_equal("May", cal.month)
  end

  # Expected value should be current year.
  def test_29_stores_current_year_if_given_no_arguments
    cal = Cal.new()
    assert_equal(2013, cal.year)
  end

  def test_30_get_year_header_returns_centered_year
    cal = Cal.new(2999)
    assert_equal("                             2999", cal.get_year_header(2999))
  end

  def test_31_get_month_header_returns_centered_month_and_year_with_even_spaces
    cal = Cal.new("May", 1966)
    assert_equal("      May 1966", cal.get_month_header("May", 1966))
  end

  def test_32_get_month_header_returns_centered_month_and_year_with_odd_spaces
    cal = Cal.new("November", 1966)
    assert_equal("   November 1966", cal.get_month_header("November", 1966))
  end

  def test_33_get_month_header_returns_centered_month_with_even_spaces
    cal = Cal.new(1804)
    assert_equal("       March", cal.get_month_header("March"))
  end

  def test_34_get_month_header_returns_centered_month_with_odd_spaces
    cal = Cal.new(1804)
    assert_equal("      December", cal.get_month_header("December"))
  end

  def test_35_get_day_header_returns_days_of_week
    cal = Cal.new("June", 1844)
    assert_equal("Su Mo Tu We Th Fr Sa", cal.get_day_header)
  end

  def test_36_get_first_day_index_returns_index_of_first_day_of_month_in_common_year
    cal = Cal.new("August", 2109)
    assert_equal(4, cal.get_first_day_index("August", 2109))
  end

  def test_37_get_first_day_index_returns_index_of_first_day_of_month_in_leap_year
    cal = Cal.new("February", 2092)
    assert_equal(5, cal.get_first_day_index("February", 2092))
  end

  def test_38_get_month_days_returns_number_of_days_in_month_with_31_days
    cal = Cal.new("January", 2779)
    assert_equal(31, cal.get_month_days("January", 2779))
  end

  def test_39_get_month_days_returns_number_of_days_in_month_with_30_days
    cal = Cal.new("September", 2483)
    assert_equal(30, cal.get_month_days("September", 2483))
  end

  def test_40_get_month_days_returns_number_of_days_in_month_with_28_days
    cal = Cal.new("February", 1811)
    assert_equal(28, cal.get_month_days("February", 1811))
  end

  def test_41_get_month_days_returns_number_of_days_in_month_with_29_days
    cal = Cal.new("February", 2072)
    assert_equal(29, cal.get_month_days("February", 2072))
  end

  def test_42_get_week_range_returns_date_range_for_first_week
    cal = Cal.new("November", 1945)
    assert_equal((1..3), cal.get_week_range(0, "November", 1945))
  end

  def test_43_get_week_range_returns_date_range_for_second_week
    cal = Cal.new("November", 1945)
    assert_equal((4..10), cal.get_week_range(1, "November", 1945))
  end

  def test_44_get_week_range_returns_date_range_for_third_week
    cal = Cal.new("November", 1945)
    assert_equal((11..17), cal.get_week_range(2, "November", 1945))
  end

  def test_45_get_week_range_returns_date_range_for_fourth_week
    cal = Cal.new("November", 1945)
    assert_equal((18..24), cal.get_week_range(3, "November", 1945))
  end

  def test_46_get_week_range_returns_date_range_for_fifth_week
    cal = Cal.new("November", 1945)
    assert_equal((25..30), cal.get_week_range(4, "November", 1945))
  end

  def test_47_get_week_range_returns_date_range_for_sixth_week
    cal = Cal.new("November", 1945)
    assert_equal((32..30), cal.get_week_range(5, "November", 1945))
  end

  def test_48_format_week_returns_first_formatted_week
    cal = Cal.new("July", 2490)
    assert_equal("                   1", cal.format_week(0, "July", 2490))
  end

  def test_49_format_week_returns_second_formatted_week
    cal = Cal.new("July", 2490)
    assert_equal(" 2  3  4  5  6  7  8", cal.format_week(1, "July", 2490))
  end

  def test_50_format_week_returns_third_formatted_week
    cal = Cal.new("July", 2490)
    assert_equal(" 9 10 11 12 13 14 15", cal.format_week(2, "July", 2490))
  end

  def test_51_format_week_returns_fourth_formatted_week
    cal = Cal.new("July", 2490)
    assert_equal("16 17 18 19 20 21 22", cal.format_week(3, "July", 2490))
  end

  def test_52_format_week_returns_fifth_formatted_week
    cal = Cal.new("July", 2490)
    assert_equal("23 24 25 26 27 28 29", cal.format_week(4, "July", 2490))
  end

  def test_53_format_week_returns_sixth_formatted_week
    cal = Cal.new("July", 2490)
    assert_equal("30 31", cal.format_week(5, "July", 2490))
  end

  def test_54_format_month_returns_formatted_month
    cal = Cal.new("August", 1979)
    assert_equal(`cal August 1979`, cal.format_month("August", 1979))
  end

  def test_55_get_month_line_returns_first_month_line
    cal = Cal.new("December", 2372)
    month_line = "      January               February               March"
    assert_equal(month_line, cal.get_month_line(0, 2))
  end

  def test_56_get_month_line_returns_second_month_line
    cal = Cal.new("December", 2372)
    month_line = "       April                  May                   June"
    assert_equal(month_line, cal.get_month_line(3, 5))
  end

  def test_57_get_month_line_returns_third_month_line
    cal = Cal.new("December", 2372)
    month_line = "        July                 August              September"
    assert_equal(month_line, cal.get_month_line(6, 8))
  end

  def test_58_get_month_line_returns_fourth_month_line
    cal = Cal.new("December", 2372)
    month_line = "      October               November              December"
    assert_equal(month_line, cal.get_month_line(9, 11))
  end

  def test_59_get_day_line_returns_day_line
    cal = Cal.new("April", 1872)
    day_line = "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa"
    assert_equal(day_line, cal.get_day_line)
  end

  def test_60_get_week_block_returns_first_week_block
    cal = Cal.new("March", 2601)
    week_block = <<BLOCK
             1  2  3   1  2  3  4  5  6  7   1  2  3  4  5  6  7
 4  5  6  7  8  9 10   8  9 10 11 12 13 14   8  9 10 11 12 13 14
11 12 13 14 15 16 17  15 16 17 18 19 20 21  15 16 17 18 19 20 21
18 19 20 21 22 23 24  22 23 24 25 26 27 28  22 23 24 25 26 27 28
25 26 27 28 29 30 31                        29 30 31
                                            
BLOCK
    assert_equal(week_block, cal.get_week_block(0, 2))
  end

  def test_61_get_week_block_returns_second_week_block
    cal = Cal.new("March", 2601)
    week_block = <<BLOCK
          1  2  3  4                  1  2      1  2  3  4  5  6
 5  6  7  8  9 10 11   3  4  5  6  7  8  9   7  8  9 10 11 12 13
12 13 14 15 16 17 18  10 11 12 13 14 15 16  14 15 16 17 18 19 20
19 20 21 22 23 24 25  17 18 19 20 21 22 23  21 22 23 24 25 26 27
26 27 28 29 30        24 25 26 27 28 29 30  28 29 30
                      31                    
BLOCK
    assert_equal(week_block, cal.get_week_block(3, 5))
  end

  def test_62_get_week_block_returns_third_week_block
    cal = Cal.new("March", 2601)
    week_block = <<BLOCK
          1  2  3  4                     1         1  2  3  4  5
 5  6  7  8  9 10 11   2  3  4  5  6  7  8   6  7  8  9 10 11 12
12 13 14 15 16 17 18   9 10 11 12 13 14 15  13 14 15 16 17 18 19
19 20 21 22 23 24 25  16 17 18 19 20 21 22  20 21 22 23 24 25 26
26 27 28 29 30 31     23 24 25 26 27 28 29  27 28 29 30
                      30 31                 
BLOCK
    assert_equal(week_block, cal.get_week_block(6, 8))
  end

  def test_63_get_week_block_returns_fourth_week_block
    cal = Cal.new("March", 2601)
    week_block = <<BLOCK
             1  2  3   1  2  3  4  5  6  7         1  2  3  4  5
 4  5  6  7  8  9 10   8  9 10 11 12 13 14   6  7  8  9 10 11 12
11 12 13 14 15 16 17  15 16 17 18 19 20 21  13 14 15 16 17 18 19
18 19 20 21 22 23 24  22 23 24 25 26 27 28  20 21 22 23 24 25 26
25 26 27 28 29 30 31  29 30                 27 28 29 30 31
                                            
BLOCK
    assert_equal(week_block, cal.get_week_block(9, 11))
  end

  def test_64_format_year_returns_formatted_year
    cal = Cal.new(2755)
    assert_equal(`cal 2755`, cal.format_year(2755))
  end

end