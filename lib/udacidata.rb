require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  def self.create(options = {})
    # If the item exists in the database
    # self.new(options)
    # If the item doesn not already exist in the database
    new_item = new(options)
    write_to_database(new_item)
    new_item
  end

  def self.new_object(args)
    new :id => args[0], :brand => args[1], :name => args[2], :price => args[3]
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
    read_database.drop(1).map! { |item| new_object(item) }
  end

  def self.return_object_or_array(nested_array, count)
    if count == 1
      self.new_object(nested_array.flatten!)
    else
      nested_array.map! { |item| new_object(item) }
    end
  end

  def self.first(int = 1)
    results = read_database.drop(1).first(int)
    return_object_or_array(results, int)
  end

  def self.last(int = 1)
    results = read_database.drop(1).last(int)
    return_object_or_array(results, int)
  end

  def self.find(index)

  end
end
