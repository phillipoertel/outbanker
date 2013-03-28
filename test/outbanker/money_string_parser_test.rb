require 'test_helper'

class Outbanker::MoneyStringParserTest < MiniTest::Unit::TestCase
  
  class Tester
    include ::Outbanker::MoneyStringParser
  end
  
  def setup
    @tester = Tester.new
  end

  def test_full_value
    assert_equal 1200, @tester.to_cents("12")
  end
  
  def test_full_value_negative
    assert_equal -1200, @tester.to_cents("-12")
  end
  
  #
  # COMMAS
  #
  def test_comma_full_euros
    assert_equal 1200, @tester.to_cents("12,00")
  end
  
  def test_comma_euros_and_cents
    assert_equal 1212, @tester.to_cents("12,12")
  end
  
  def test_comma_euros_and_cents_one_digit
    assert_equal 1210, @tester.to_cents("12,1")
  end
  
  def test_comma_zero
    assert_equal 0, @tester.to_cents("0,00")
  end
  
  def test_comma_negative_full_euros
    assert_equal -1200, @tester.to_cents("-12,00")
  end
  
  def test_comma_negative_euros_and_cents
    assert_equal -1212, @tester.to_cents("-12,12")
  end

  #
  # DOT
  #
  def test_dot_full_euros
    assert_equal 1200, @tester.to_cents("12.00")
  end
  
  def test_dot_euros_and_cents
    assert_equal 1212, @tester.to_cents("12.12")
  end
  
  def test_dot_euros_and_cents_one_digit
    assert_equal 1210, @tester.to_cents("12.1")
  end
  
  def test_dot_zero
    assert_equal 0, @tester.to_cents("0.00")
  end
  
  def test_dot_negative_full_euros
    assert_equal -1200, @tester.to_cents("-12.00")
  end
  
  def test_dot_negative_euros_and_cents
    assert_equal -1212, @tester.to_cents("-12.12")
  end
  
end