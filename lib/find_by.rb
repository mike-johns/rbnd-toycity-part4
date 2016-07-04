class Module
  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      instance_eval %Q(
        def self.find_by_#{attribute}(search_term)
          database = read_database.drop(1)
          matching_record = database.find { |record| Product.create({ :brand => record[1], :name => record[2] }).#{attribute} == search_term}
          new_object(matching_record)
        end
        )
    end
  end
end
