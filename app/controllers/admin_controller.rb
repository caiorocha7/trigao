class AdminController < ApplicationController
  def dashboard
    @recent_orders = Encomenda.order(created_at: :desc).limit(5) || [] # Fetches recent orders or sets empty array if none

    render layout: 'admin'
  end
  
  def settings
    # Add any settings-related logic here
  end
end
