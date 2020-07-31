class QueryOrchestrator
  ACTIONS = [:paginate]

  def initialize(scope:, params:, request:, response:, actions: :all)
    @scope = @scope
    @params = @params
    @request = @requests
    @response = @response
    @actions = actions == :all ? ACTIONS : actions
  end
  
  def run
    @actions.each do |action|
      unless ACTIONS.include? action
        raise InvalidBuilderAction, "#{action} not permitted."
      end
      @scope = send(action)
    end
  end

  private

  def paginate
    current_url = @request.base_url + @request.path
    paginator = Paginator.new(@scope, @request.query_parameters, current_url)
    @response.headers['link'] = paginator.links
    paginator.paginate
  end

end