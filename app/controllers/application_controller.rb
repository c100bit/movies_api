class ApplicationController < ActionController::API

  def render(options={})
    includes = params[:include].split(',') if params[:include]
    method_name = options[:json].respond_to?(:model) ? :model : :class
    serializer = "#{options[:json].send(method_name)}Serializer".constantize
    begin
      options[:json] = serializer.new(options[:json], include: includes)
    rescue ArgumentError
      options[:json] = serializer.new(options[:json])
    rescue
      options[:json] = nil
    end
    super(options)
  end
  
end
