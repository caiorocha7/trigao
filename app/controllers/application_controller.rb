class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  protect_from_forgery with: :exception

  # Skip CSRF for JSON API requests
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  # Ensure `@recent_orders` is available in the admin layout
  before_action :set_recent_orders, if: :using_admin_layout?

  private

  def set_recent_orders
    # Load recent orders or set to an empty array if none are found
    @recent_orders = Encomenda.order(created_at: :desc).limit(5) || []
  end

  def using_admin_layout?
    self.class < ActionController::Base && params[:controller].include?("admin")
  end
end
