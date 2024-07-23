require "rails_helper"

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customers, 3)

    get '/api/v1/customers'

    except(response).to be_successfull
  end
end