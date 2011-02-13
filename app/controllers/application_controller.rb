

class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  
  
  def xhr_no_layout
    if request.xhr?
      render :layout => false
    end
  end  
end
