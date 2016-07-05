module Analyzable
  def self.included(some_class)
    [:brand, :name].each do |attribute|
      instance_eval %Q(
        def count_by_#{attribute}(product_array)
          #{attribute}_array = []
          product_array.each { |item| #{attribute}_array << item.#{attribute} }
          #{attribute}_array.uniq!
          #{attribute}_hash = {}
          #{attribute}_array.each do |#{attribute}|
            #{attribute}_members = product_array.find_all { |i| i.#{attribute} == #{attribute} }
            #{attribute}_hash[#{attribute}] = #{attribute}_members.size
          end
          #{attribute}_hash
        end
        )
    end
  end

  def average_price(product_array)
    total_cost = 0
    product_array.each { |item| total_cost += item.price }
    (total_cost / product_array.size).round(2)
  end

  def print_report(product_array)
    final_report = "\nAverage Price: $#{average_price(product_array)}\n"
    final_report << "Inventory by Brand:\n"
    count_by_brand(product_array).each do |key, value|
      final_report << "  - #{key}: #{value}\n"
    end
    final_report << "Inventory by Name:\n"
    count_by_name(product_array).each do |key, value|
      final_report << "  - #{key}: #{value}\n"
    end
    final_report
  end
end
