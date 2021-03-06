require "test/unit"
require "./cal.rb"

class CalIntegrationTest < Test::Unit::TestCase

  def test_1_returns_single_month_with_28_days
    assert_equal(`cal 2 2010`, `ruby cal.rb 2 2010`)
  end

  def test_2_returns_single_month_with_30_days
    assert_equal(`cal 11 2010`, `ruby cal.rb 11 2010`)
  end

  def test_3_returns_single_month_with_31_days
    assert_equal(`cal 7 2010`, `ruby cal.rb 7 2010`)
  end

  def test_4_accepts_month_names_as_arguments
    assert_equal(`cal August 1970`, `ruby cal.rb August 1970`)
  end

  def test_5_accepts_months_with_leading_zeros
    assert_equal(`cal 09 2192`, `ruby cal.rb 09 2192`)
  end

  def test_6_accepts_years_with_leading_zeros
    assert_equal(`cal 5 01808`, `ruby cal.rb 5 01808`)
  end

  def test_7_returns_current_month_if_given_no_arguments
    assert_equal(`cal`, `ruby cal.rb`)
  end

  def test_8_returns_full_year_if_given_year_but_no_month
    assert_equal(`cal 1999`, `ruby cal.rb 1999`)
  end

  def test_9_raises_error_if_given_month_but_no_year
    assert_equal(`cal June`, `ruby cal.rb June`)
  end

  def test_10_every_fourth_year_is_a_leap_year
    assert_equal(`cal 2 2012`, `ruby cal.rb 2 2012`)
  end

  def test_11_most_multiples_of_100_are_common_years
    assert_equal(`cal 2 1900`, `ruby cal.rb 2 1900`)
  end

  def test_12_every_multiple_of_400_is_a_leap_year
    assert_equal(`cal 2 2000`, `ruby cal.rb 2 2000`)
  end

end