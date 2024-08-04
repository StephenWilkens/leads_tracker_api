class Customer < ApplicationRecord
  validates :name, :address, :city, :county, :state, :zip_code, presence: true
end
