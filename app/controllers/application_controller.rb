class ApplicationController < ActionController::API

  def render(options={})
    method_name = options[:json].respond_to?(:model) ? :model : :class
    serializer = "#{options[:json].send(method_name)}Serializer".constantize
    options[:json] = serializer.new(options[:json])
    super(options)
  end
  
end
