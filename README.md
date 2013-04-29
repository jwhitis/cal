Cal
===============

This is a Ruby implementation of the standard Unix program cal. My goal is to match the output of the original program.

Specifications:
---------------

  1. Return a calendar for any month between years 1800 and 3000.
  2. Program should account for leap years and other irregularities.
  3. Outputted text should be justified like the original program.
  4. Program should accept command line arguments.

Methods to implement:
---------------------

  * initialize
  * get_month_header
  * get_day_header
  * get_first_day
  * get_first_day_index
  * get_month_days
  * format_week
  * format_month
  * format_year
  * render
