require "test/unit"
require "./cal.rb"

class CalIntegrationTest < Test::Unit::TestCase

  # def test_1_returns_single_month_with_28_days
  #   assert_equal(`cal 2 2010`, `ruby cal.rb 2 2010`)
  # end

  # def test_2_returns_single_month_with_30_days
  #   assert_equal(`cal 11 2010`, `ruby cal.rb 11 2010`)
  # end

  # def test_3_returns_single_month_with_31_days
  #   assert_equal(`cal 7 2010`, `ruby cal.rb 7 2010`)
  # end

  # def test_4_returns_current_month_if_given_no_arguments
  #   assert_equal(`cal`, `ruby cal.rb`)
  # end

  # def test_5_returns_full_year_if_given_year_but_no_month
  #   assert_equal(`cal 1999`, `ruby cal.rb 1999`)
  # end

  # def test_6_raises_error_if_given_month_but_no_year
  #   assert_equal(`cal June`, `ruby cal.rb June`)
  # end

  # def test_7_accepts_numbers_and_names_as_month_arguments
  #   assert_equal(`cal August 1970`, `ruby cal.rb August 1970`)
  #   assert_equal(`cal 8 1970`, `ruby cal.rb 8 1970`)
  # end

  # def test_8_every_fourth_year_is_a_leap_year
  #   assert_equal(`cal 10 2012`, `ruby cal.rb 10 2012`)
  # end

  # def test_9_most_multiples_of_100_are_common_years
  #   assert_equal(`cal 1 1900`, `ruby cal.rb 1 1900`)
  # end

  # def test_10_every_multiple_of_400_is_a_leap_year
  #   assert_equal(`cal 12 2000`, `ruby cal.rb 12 2000`)
  # end

end