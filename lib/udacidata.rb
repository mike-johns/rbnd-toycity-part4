require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  create_finder_methods :brand, :name
  def self.create(options = {})
    new_item = new(options)
    # new_record = [new_item.id.to_s, new_item.brand, new_item.name, new_item.price.to_s]
    # if !read_database.drop(1).find { |record| record[1..3] == new_record[1..3] }
    write_to_database(new_item)
    # end
    new_item
  end

  def self.new_object(args)
    new :id => args[0].to_i, :brand => args[1], :name => args[2], :price => args[3].to_f
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

  def self.find(id)
    result = read_database.drop(1).find { |i| i[0] == id.to_s}
    new_object(result)
  end

  def self.destroy(id)
    database = read_database
    target = find(id)
    target_as_array = [target.id.to_s, target.brand, target.name, target.price.to_s]
    database.delete(target_as_array)
    data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(data_path, "w") do |csv|
      database.each { |record| csv << record }
    end
    target
  end

  # def self.find_by_brand(brand_name)
  #   database = read_database.drop(1)
  #   matching_record = database.find {|record| record[1] == brand_name}
  #   new_object(matching_record)
  # end

  # def self.find_by_name(item_name)
  #   database = read_database.drop(1)
  #   matching_record = database.find {|record| record[2] == item_name}
  #   new_object(matching_record)
  # end

  def self.where(options = {})
    database = read_database.drop(1)
    matching_records = database.find_all {|record| record[1] == options[:brand]}
    return matching_records.map! { |record| new_object(record) }
  end
end

# Udacidata.class_eval {
#   def self.find_by_brand(brand_name)
#     database = read_database.drop(1)
#     matching_record = database.find {|record| record[1] == brand_name}
#     new_object(matching_record)
#   end
# }
