class ApplicationController < ActionController::API

  protected

  def orchestrate_query(scope, actions = :all)
    QueryOrchestrator.new(
      scope: scope, 
      params: params, 
      request: request, 
      response: response, 
      actions: actions).run
  end

end
