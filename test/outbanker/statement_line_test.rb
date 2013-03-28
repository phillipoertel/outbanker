require 'test_helper'

class Outbanker::StatementLineTest < MiniTest::Unit::TestCase
  
  def setup
    fixture = File.join(File.dirname(__FILE__), '../fixtures/outbank-fixture.csv')
    @lines = Outbanker::StatementLines.read(fixture)
  end
  
  def setup_cc_fixture
    fixture = File.join(File.dirname(__FILE__), '../fixtures/outbank-cc.csv')
    @lines = Outbanker::StatementLines.read(fixture)
  end
  
  def test_attribute_mapping_works
    line = @lines[0]
    assert_equal "EUR", line.currency
    assert_equal -1542, line.amount
    assert_equal Date.parse("31.12.2012"), line.booked_on
    assert_equal Date.parse("02.01.2013"), line.valuta_on
    assert_equal nil, line.recipient
    assert_equal nil, line.bank_code
    assert_equal nil, line.account_number
    assert_equal "Saldo der Abschlussposten QM - Support 04082 Leipzig", line.description
    assert_equal "Bankgebühren", line.category
  end

  def test_empty_category_is_returned_as_nil
    line = @lines[1]
    assert_equal nil, line.category
  end
  
  #
  # Unique Ids
  #
  def test_unique_id_exists
    line = @lines[0]
    assert_equal "218d1ee8478cbb5b697fe77962424817", line.unique_id
  end

  def test_unique_id_depends_on_amount
    line = @lines[0]
    row = @lines.csv.read # get the raw first csv line
    row['Betrag'] = "1#{row['Betrag']}"
    refute_equal Outbanker::StatementLine.new(row), line.unique_id
  end
  
  def test_unique_id_depends_on_booked_on
    line = @lines[0]
    row = @lines.csv.read # get the raw first csv line
    row['Buchungstag'] = "01.01.1971"
    refute_equal Outbanker::StatementLine.new(row), line.unique_id
  end
  
  def test_unique_id_depends_on_description
    line = @lines[0]
    row = @lines.csv.read # get the raw first csv line
    row['Verwendungszweck'] = "#{row['Verwendungszweck']} Bla bla"
    refute_equal Outbanker::StatementLine.new(row), line.unique_id
  end
  
  def test_was_charged_when_empty
    line = @lines[0]
    assert_equal true, line.charged?
  end
  
  def test_was_charged_when_filled
    setup_cc_fixture
    line = @lines[1]
    assert_equal true, line.charged?
  end
  
  def test_was_not_charged
    setup_cc_fixture
    line = @lines[0]
    assert_equal false, line.charged?
  end
  
  def test_prebooking_false
    line = @lines[0]
    assert_equal false, line.prebooking?
  end
  
  def test_prebooking_true
    line = @lines[2]
    assert_equal true, line.prebooking?
  end
end