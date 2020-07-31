class Paginator
  def initialize(scope, query_params, url)
    @query_params = query_params
    @page = validate_param!("page", 1)
    @per = validate_param!("per", 100)
    @scope = scope.page(@page).per(@per)
    @url = url
  end

  def paginate
    @scope
  end

  def links
    @links ||= pages.each_with_object([]) do |(k, v), links|
      query_params = @query_params.merge({ "page" => v, "per" => @per }).to_param
      links << "<#{@url}>?#{query_params}>; rel = \"#{k}\""
    end.join(", ")
  end

  private

  def validate_param!(name, default)
    return default unless @query_params[name]
    unless (@query_params[name] =~ /\A\d+\z/)
      raise QueryBuilderError.new("#{name}=#{@query_params[name]}"),
            "Invalid Pagination params, only numbers are supported for page and per"
    end

    @query_params[name]
  end

  def pages
    @pages ||= {}.tap do |page|
      page[:next] = @scope.current_page + 1 if show_next_link?
    end
  end

  def show_next_link?
    @scope.total_pages > 1 && !@scope.last_page?
  end
end
