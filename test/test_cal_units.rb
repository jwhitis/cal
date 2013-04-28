require "test/unit"
require "./cal.rb"

class CalUnitTest < Test::Unit::TestCase

  def test_11_creates_a_new_instance_of_cal
    cal = Cal.new("April", 1865)
    assert (cal)
  end

  def test_12_new_instance_stores_month_and_year_values
    cal = Cal.new("September", 2050)
    assert_equal("September", cal.month)
    assert_equal(2050, cal.year)
  end

  def test_13_accepts_incomplete_month_arguments
    cal = Cal.new("Dec", 2545)
    assert_equal("December", cal.month)
  end

  def test_14_accepts_numerical_month_arguments
    cal = Cal.new(2, 2284)
    assert_equal("February", cal.month)
  end

  def test_15_raises_error_if_month_is_invalid
    assert_raise(ArgumentError) do
      cal = Cal.new("Mach", 1910)
    end
    assert_raise(ArgumentError) do
      cal = Cal.new("13", 1910)
    end
  end

  def test_16_raises_error_if_year_is_invalid
    assert_raise(ArgumentError) do
      cal = Cal.new("July", 1776)
    end
  end

  def test_17_accepts_year_but_no_month
    cal = Cal.new(1983)
    assert_equal("all", cal.month)
    assert_equal(1983, cal.year)
  end

  def test_18_raises_error_if_given_month_but_no_year
    assert_raise(ArgumentError) do
      cal = Cal.new("January")
    end
  end

  def test_19_raises_error_if_given_no_month_and_invalid_year
    assert_raise(ArgumentError) do
      cal = Cal.new("1500")
    end
  end

  def test_20_raises_error_if_given_too_many_arguments
    assert_raise(ArgumentError) do
      cal = Cal.new("August", 2005, 1825)
    end
  end

  def test_21_month_header_returns_indented_month_and_year
    even_spaces = Cal.new("May", 1966)
    odd_spaces = Cal.new("November", 1938)
    assert_equal("      May 1966      ", even_spaces.month_header("May", 1966))
    assert_equal("   November 1938    ", odd_spaces.month_header("November", 1938))
  end

  def test_22_month_header_returns_indented_month_only
    even_spaces = Cal.new(1804)
    assert_equal("       March        ", even_spaces.month_header("March"))
  end

  def test_23_day_header_returns_days_of_week
    cal = Cal.new("June", 1844)
    assert_equal("Su Mo Tu We Th Fr Sa", cal.day_header)
  end

  def test_24_get_first_day_returns_first_day_of_month
    common_year = Cal.new("May", 2501)
    leap_year = Cal.new("February", 1984)
    assert_equal("Sunday", common_year.get_first_day("May", 2501))
    assert_equal("Wednesday", leap_year.get_first_day("February", 1984))
  end

  def test_25_get_first_day_index_returns_index_of_first_day_of_month
    common_year = Cal.new("August", 2109)
    leap_year = Cal.new("February", 2092)
    assert_equal(4, common_year.get_first_day_index("August", 2109))
    assert_equal(5, leap_year.get_first_day_index("February", 2092))
  end

  def test_26_get_month_days_returns_number_of_days_in_month
    common_year_31 = Cal.new("January", 2779)
    common_year_30 = Cal.new("September", 2483)
    common_year_28 = Cal.new("February", 1811)
    leap_year = Cal.new("February", 2072)
    assert_equal(31, common_year_31.get_month_days("January", 2779))
    assert_equal(30, common_year_30.get_month_days("September", 2483))
    assert_equal(28, common_year_28.get_month_days("February", 1811))
    assert_equal(29, leap_year.get_month_days("February", 2072))
  end

  def test_27_format_week_returns_formatted_week
    cal = Cal.new("April", 2003)
    assert_equal("       1  2  3  4  5", cal.format_week(0, "April", 2003))
    assert_equal(" 6  7  8  9 10 11 12", cal.format_week(1, "April", 2003))
    assert_equal("13 14 15 16 17 18 19", cal.format_week(2, "April", 2003))
    assert_equal("20 21 22 23 24 25 26", cal.format_week(3, "April", 2003))
    assert_equal("27 28 29 30         ", cal.format_week(4, "April", 2003))
  end

end