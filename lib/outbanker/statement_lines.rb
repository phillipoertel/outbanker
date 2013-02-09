require 'csv'

module Outbanker
  class StatementLines
  
    attr_reader :earliest_booking, :latest_booking

    # required for testing only
    attr_reader :csv
  
    def self.read(file = 'data/outbank.csv')
      instance = new
      instance.read(file)
      instance
    end  
  
    def read(file)
      @csv = read_csv(file)
      get_csv_metadata
      @lines = @csv.map { |row| Outbanker::StatementLine.new(row) }
    end
    
    # delegate stuff to the @lines array
    def method_missing(method, *args, &block)
      delegated_methods = [:size, :each, :map, :[]]
      return super unless delegated_methods.include?(method)
      @lines.send(method, *args, &block)
    end
    
    def num_statements
      @lines.size
    end

    private
    
      def read_csv(file)
        options = { 
          :col_sep => ';', 
          :headers => true,
          :converters => [:all]
        }
        CSV.new(File.read(file), options)
      end
      
      def get_csv_metadata
        rows = @csv.read
        @earliest_booking = Date.parse(rows[rows.size - 1]['Buchungstag'])
        @latest_booking   = Date.parse(rows[0]['Buchungstag'])
        @num_statements   = rows.size
        @csv.rewind
      end
    
  end
end