module Analyzable
  def average_price(product_array)
    total_cost = 0
    number_of_items = product_array.size
    product_array.each { |item| total_cost += item.price }
    (total_cost / number_of_items).round(2)
  end

  def print_report(product_array)
    final_report = "\nAverage Price: $#{average_price(product_array)}\n"


    brand_array = []
    name_array = []

    product_array.each do |item|
      brand_array << item.brand
      name_array << item.name
    end

    brand_array.uniq!
    name_array.uniq!

    final_report << "Inventory by Brand:\n"
    brand_array.each do |brand|
      brand_members = product_array.find_all { |i| i.brand == brand}
      result = count_by_brand(brand_members)
      final_report << "  - #{result.keys.first}: #{result.values.first}\n"
    end

    final_report << "Inventory by Name:\n"
    name_array.each do |name|
      name_members = product_array.find_all { |i| i.name == name}
      result = count_by_name(name_members)
      final_report << "  - #{result.keys.first}: #{result.values.first}\n"
    end

    final_report
  end

  def count_by_brand(product_array)
    brand_array = []
    product_array.each { |item| brand_array << item.brand }
    brand_array.uniq!
    brand_hash = {}
    brand_array.each do |brand|
      brand_members = product_array.find_all { |i| i.brand == brand }
      brand_hash[brand] = brand_members.size
    end
    brand_hash
  end



  def count_by_name(product_array)
    name_array = []
    product_array.each { |item| name_array << item.name }
    name_array.uniq!
    name_hash = {}
    name_array.each do |name|
      name_members = product_array.find_all { |i| i.name == name }
      name_hash[name] = name_members.size
    end
    name_hash
  end
end
