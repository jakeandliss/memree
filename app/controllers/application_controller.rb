class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success
  
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_error
  
  private


  def render_error
    render file: 'public/500.html', status: :internal_server_error, layout: false
  end

  def after_sign_out_path_for(resource_or_scope)
    titles_path
  end

  def not_found
    respond_to do |format|
      format.html { render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, layout: false }
      format.json { render :json => {:errors => [{status: "Not found", category_code: "not-found", status_code: "404"}]}.to_json, :status => 404 }
    end
  end


end
