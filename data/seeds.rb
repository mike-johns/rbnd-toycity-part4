require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  @data_path = File.dirname(__FILE__) + "/../data/data.csv"
  CSV.open(@data_path, "a+") do |csv|
    x = 0
    100.times do
      csv << [x, Faker::Company.name, Faker::Commerce.product_name, Faker::Commerce.price]
      x += 1
    end
  end
end
