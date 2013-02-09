module Outbanker
  module MoneyStringParser
    def to_cents(string)
      matches = string.match(/\.([0-9]{1,2})\Z/)
      if !matches
        string.to_i * 100
      elsif matches[1].length == 1
        string.gsub('.', '').to_i * 10
      elsif matches[1].length == 2
        string.gsub('.', '').to_i
      end
    end
  end
end