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

  def self.read_database
    data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.read(data_path)
  end

  def self.write_to_database(item)
    data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(data_path, "a+") do |csv|
      csv << [item.id, item.brand, item.name, item.price]
    end
  end

  def self.all
    read_database.drop(1).map! { |item| self.new :id => item[0], :brand => item[1], :name => item[2], :price => item[3] }
  end

  def self.first(int = 1)
    results = read_database.drop(1).first(int)
    if int == 1
      results.flatten!
      self.new :id => results[0], :brand => results[1], :name => results[2], :price => results[3]
    else
      results.map! { |item| self.new :id => item[0], :brand => item[1], :name => item[2], :price => item[3] }
    end
  end

  def self.last(int = 1)
    results = read_database.drop(1).last(int)
    if int == 1
      results.flatten!
      self.new :id => results[0], :brand => results[1], :name => results[2], :price => results[3]
    else
      results.map! { |item| self.new :id => item[0], :brand => item[1], :name => item[2], :price => item[3] }
    end
  end

  def find(index)

  end
end
