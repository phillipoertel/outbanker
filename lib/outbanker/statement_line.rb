require 'digest/md5'

module Outbanker
  
  # 
  # this is a representation of one line in an outbank csv statement
  # with translated, parsed attributes (cents, date, etc.).
  #
  class StatementLine

    include MoneyStringParser
    
    ATTRIBUTE_MAPPING = {
      :description2 => "Buchungstext",
      :currency => "Währung",
      :amount => "Betrag",
      :booked_on => "Buchungstag",
      :valuta_on => "Valuta-Datum",
      :recipient => "Empfänger/Auftraggeber",
      :bank_code => "Bankleitzahl",
      :account_number => "Kontonummer",
      :description => "Verwendungszweck",
      :category => "Kategorie"
    }

    def initialize(csv_row)
      @row = csv_row
    end
    
    def amount
      to_cents(@row['Betrag'])
    end
    
    def booked_on
      Date.parse(@row['Buchungstag'])
    end
    
    def valuta_on
      Date.parse(@row['Valuta-Datum'])
    end
    
    def description
      @row['Verwendungszweck'].gsub(/\s+/, ' ')
    end
    
    def method_missing(arg)
      super unless ATTRIBUTE_MAPPING.keys.include?(arg)
      @row.send(:[], ATTRIBUTE_MAPPING[arg])
    end
    
    def unique_id
      unique_string = [amount, booked_on, description].join('-')
      Digest::MD5.hexdigest(unique_string)
    end
    
    def to_s
      "Buchung vom: #{booked_on}, Betrag: #{amount}, Beschreibung: #{description}"
    end
    
  end
end