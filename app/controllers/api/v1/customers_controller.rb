class Api::V1::CustomersController < ApplicationController
  def index
    render json: Customer.all
  end

  def show
    render json: Customer.find(params[:id])
  end

  def create
    render json: Customer.create(customer_params)
  end

  def update
    render json: Customer.update(params[:id], customer_params)
  end

  def destroy
    render json: Customer.delete(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :address, :city, :county, :state, :point_of_contact,
                                     :contact_information, :zip_code, :last_check_in, :next_check_in, :notes,
                                     :interest_level, :bar, :liquor_store)
  end
end
