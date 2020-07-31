class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found!

  protected

  def orchestrate_query(scope, actions = :all)
    QueryOrchestrator.new(
      scope: scope,
      params: params,
      request: request,
      response: response,
      actions: actions
    )
      .run
  end

  def unprocessable_entity!(resource)
    render status: :unprocessable_entity, json: {
      error: {
        message: "Invalid parameters for resource #{resource.class}.",
        invalid_params: resource.errors
      }
    }
  end

  def not_found!
    render status: :not_found, json: {
      error: {
        message: 'Item not found.'
      }
    }
  end
end
