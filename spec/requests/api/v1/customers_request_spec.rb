require "rails_helper"
require 'pry'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers.count).to eq(3)

    customers.each do |customer|
      expect(customer).to have_key(:id)
      expect(customer[:id]).to be_an(Integer)

      expect(customer).to have_key(:name)
      expect(customer[:name]).to be_an(String)

      expect(customer).to have_key(:address)
      expect(customer[:address]).to be_an(String)

      expect(customer).to have_key(:city)
      expect(customer[:city]).to be_an(String)

      expect(customer).to have_key(:county)
      expect(customer[:county]).to be_an(String)

      expect(customer).to have_key(:state)
      expect(customer[:state]).to be_an(String)

      expect(customer).to have_key(:point_of_contact)
      expect(customer[:point_of_contact]).to be_an(String)

      expect(customer).to have_key(:contact_information)
      expect(customer[:contact_information]).to be_an(String)

      expect(customer).to have_key(:zip_code)
      expect(customer[:zip_code]).to be_an(String)

      expect(customer).to have_key(:last_check_in)
      expect(customer[:last_check_in]).to be_a(String)

      expect(customer).to have_key(:next_check_in)
      expect(customer[:next_check_in]).to be_a(String)

      expect(customer).to have_key(:notes)
      expect(customer[:notes]).to be_an(String)

      expect(customer).to have_key(:interest_level)
      expect(customer[:interest_level]).to be_an(Integer)

      expect(customer).to have_key(:liquor_store)
      expect(customer[:liquor_store]).to be_in([true, false])

      expect(customer).to have_key(:bar)
      expect(customer[:bar]).to be_in([true, false])
    end
  end

  it "can get one customer by their id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(customer).to have_key(:id)
    expect(customer[:id]).to be_an(Integer)

    expect(customer).to have_key(:name)
    expect(customer[:name]).to be_an(String)

    expect(customer).to have_key(:address)
    expect(customer[:address]).to be_an(String)

    expect(customer).to have_key(:city)
    expect(customer[:city]).to be_an(String)

    expect(customer).to have_key(:county)
    expect(customer[:county]).to be_an(String)

    expect(customer).to have_key(:state)
    expect(customer[:state]).to be_an(String)

    expect(customer).to have_key(:point_of_contact)
    expect(customer[:point_of_contact]).to be_an(String)

    expect(customer).to have_key(:contact_information)
    expect(customer[:contact_information]).to be_an(String)

    expect(customer).to have_key(:zip_code)
    expect(customer[:zip_code]).to be_an(String)

    expect(customer).to have_key(:last_check_in)
    expect(customer[:last_check_in]).to be_a(String)

    expect(customer).to have_key(:next_check_in)
    expect(customer[:next_check_in]).to be_a(String)

    expect(customer).to have_key(:notes)
    expect(customer[:notes]).to be_an(String)

    expect(customer).to have_key(:interest_level)
    expect(customer[:interest_level]).to be_an(Integer)

    expect(customer).to have_key(:liquor_store)
    expect(customer[:liquor_store]).to be_in([true, false])

    expect(customer).to have_key(:bar)
    expect(customer[:bar]).to be_in([true, false])
  end

  it "can create a new customer" do
    customer_params = ({
      name: Faker::Company.name,
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      county: Faker::Address.community,
      state: Faker::Address.state,
      point_of_contact: Faker::Name.first_name,
      contact_information: Faker::PhoneNumber.phone_number,
      zip_code: Faker::Address.zip_code,
      last_check_in: Faker::Date.between(from: '2024-03-01', to: Date.today),
      next_check_in: Faker::Date.between(from: Date.today, to: 1.month.from_now),
      notes: Faker::Lorem.paragraph,
      interest_level: Faker::Number.between(from: 0, to: 5),
      bar: Faker::Boolean.boolean,
      liquor_store: Faker::Boolean.boolean,
    })

    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/customers", headers: headers, params: JSON.generate(customer: customer_params)
    customer = Customer.last

    expect(response).to be_successful

    expect(customer.name).to eq(customer_params[:name])
    expect(customer.address).to eq(customer_params[:address])
    expect(customer.city).to eq(customer_params[:city])
    expect(customer.county).to eq(customer_params[:county])
    expect(customer.state).to eq(customer_params[:state])
    expect(customer.point_of_contact).to eq(customer_params[:point_of_contact])
    expect(customer.contact_information).to eq(customer_params[:contact_information])
    expect(customer.zip_code).to eq(customer_params[:zip_code])
    expect(customer.last_check_in).to eq(customer_params[:last_check_in])
    expect(customer.next_check_in).to eq(customer_params[:next_check_in])
    expect(customer.notes).to eq(customer_params[:notes])
    expect(customer.interest_level).to eq(customer_params[:interest_level])
    expect(customer.bar).to eq(customer_params[:bar])
    expect(customer.liquor_store).to eq(customer_params[:liquor_store])
  end

  it "can update an existing customer" do
    id = create(:customer).id
    previous_name = Customer.last.name
    customer_params = { name: "Phillip" }
    headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v1/customers/#{id}", headers: headers, params: JSON.generate({ customer: customer_params })
    customer = Customer.find_by(id: id)

    expect(response).to be_successful
    expect(customer.name).to_not eq(previous_name)
    expect(customer.name).to eq("Phillip")
  end

  it "can destroy a customer" do
    customer = create(:customer)

    expect(Customer.count).to eq(1)

    delete "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful
    expect(Customer.count).to eq(0)
    expect { Customer.find(customer.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
