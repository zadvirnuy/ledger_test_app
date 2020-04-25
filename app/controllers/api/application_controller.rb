class Api::ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token, if: :json_request?
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  protected

  def json_request?
    request.format.json?
  end

	def response_success(success_message = nil, attributes = {})
    { success: true, alert: success_message }.merge(attributes)
  end

  def response_fail(error_message = nil, attributes = {})
    { success: false, alert: error_message }.merge(attributes)
  end

  def render_not_found
    render json: response_fail('Not found.'), status: 404
  end
end
