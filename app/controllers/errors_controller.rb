class ErrorsController < ApplicationController
  def not_found
  	#render(status: 404)
    render "not_found.html.erb"
  end

  def internal_server_error
  	#render(status: 500)
    render "internal_server_error.html.erb"
  end
end
