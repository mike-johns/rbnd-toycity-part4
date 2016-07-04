class Module
  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      instance_eval %Q(
        def self.find_by_#{attribute}(options = {})
          database = read_database.drop(1)
          search_object = Product.create(#{attribute} => options[#{attribute}])
          matching_record = database.find do |record|
            test_object = Product.create ({ :brand => record[1], :name => record[2] })
            print test_object
            print search_object
            test_object.#{attribute} == search_object.#{attribute}
          end
          new_object(matching_record)
        end
        )
    end
    # instance_eval %Q(
    #   def self.find_by_brand(brand_name)
    #     database = read_database.drop(1)
    #     matching_record = database.find {|record| record[1] == brand_name}
    #     new_object(matching_record)
    #   end
    # )
  end
end
