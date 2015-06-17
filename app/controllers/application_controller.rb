class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success
  
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_error

  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  private

  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
    prepare_for_mobile if mobile_device?
  end

  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile'
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
      (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
    end
  end
  helper_method :mobile_device?

  def render_error
    render file: 'public/500.html', status: :internal_server_error, layout: false
  end

  def after_sign_out_path_for(resource_or_scope)
    entries_path
  end

  def not_found
    respond_to do |format|
      format.html { render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, layout: false }
      format.json { render :json => {:errors => [{status: "Not found", category_code: "not-found", status_code: "404"}]}.to_json, :status => 404 }
    end
  end

  protected

  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name]
  end

end
