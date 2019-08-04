class ApolloUploadServer::Upload
  def self.coerce_input(value, _ctx)
    value.is_a?(ApolloUploadServer::Wrappers::UploadedFile) ? value.__getobj__ : value
  end
end