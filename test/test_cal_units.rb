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
    assert_equal("      May 1966      ", even_spaces.month_header)
    assert_equal("   November 1938    ", odd_spaces.month_header)
  end

  def test_22_day_header_returns_days_of_week
    cal = Cal.new("June", 1844)
    assert_equal("Su Mo Tu We Th Fr Sa", cal.day_header)
  end

  def test_23_get_first_day_returns_first_day_of_month
    common_year = Cal.new("May", 2501)
    leap_year = Cal.new("February", 1984)
    assert_equal("Sunday", common_year.get_first_day)
    assert_equal("Wednesday", leap_year.get_first_day)
  end

  # def test_24_format_weeks_returns_first_day_index
  #   cal = Cal.new("August", 2819)
  #   assert_equal(4, cal.format_weeks)
  # end

end