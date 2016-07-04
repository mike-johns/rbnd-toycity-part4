require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  def self.create(options = {})
    # If the item exists in the database
    # self.new(options)
    # If the item doesn not already exist in the database
    new_item = self.new(options)
    write_to_database(new_item)
    new_item
  end

  def self.write_to_database(product)
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(@data_path, "a+") do |csv|
      csv << [product.id, product.brand, product.name, product.price]
    end
  end
end
