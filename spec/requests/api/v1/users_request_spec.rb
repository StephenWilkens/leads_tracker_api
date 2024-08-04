require 'rails_helper'
require 'pry'

RSpec.describe "Users API" do
  it "can create a new user" do
    user_params = ({
      email: "lead@gmail.com",
      password: "abc123"
    })

    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)
    user = User.last

    expect(response).to be_successful

    expect(user.email).to eq(user_params[:email])
  end

  it "will not allow two users with the same email" do
    user_params = ({
      email: "lead@gmail.com",
      password: "abc123"
    })

    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)
    user = User.last

    expect(response).to be_successful

    user2_params = ({
      email: "lead@gmail.com",
      password: "cba123"
    })

    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/users", headers: headers, params: JSON.generate(user: user2_params)
    user = User.last

    expect(response).to have_http_status(400)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data][:error]).to eq("Invalid Email or Password")
  end

  it "can log a user in" do
    user_params = ({
      email: "lead@gmail.com",
      password: "abc123",
    })

    User.create(user_params)

    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/users/login", headers: headers, params: JSON.generate(user: user_params)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(user).to have_key(:id)
  end

  it "will not log a user in with the incorrect password" do
    user_params = ({
      email: "lead@gmail.com",
      password: "abc123",
    })

    bad_user_params = ({
      email: "lead@gmail.com",
      password: "cba123",
    })

    User.create(user_params)

    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/users/login", headers: headers, params: JSON.generate(user: bad_user_params)

    expect(response).to have_http_status(400)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data][:error]).to eq('Incorrect Email or Password')
  end
end
