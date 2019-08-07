class ApplicationController < ActionController::API

  def render(options={})
    includes = params[:include].split(',') if params[:include]
    method_name = options[:json].respond_to?(:model) ? :model : :class
    class_name = options[:json].send(method_name)
    begin
      serializer = "#{class_name}Serializer".constantize
      options[:json] = serializer.new(options[:json], include: includes)
    rescue ArgumentError
      options[:json] = serializer.new(options[:json])
    rescue
    end
    super(options)
  end
  
end
