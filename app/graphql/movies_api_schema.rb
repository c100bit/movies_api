class MoviesApiSchema < GraphQL::Schema
  mutation(Root::MutationType)
  query(Root::QueryType)

  # enable batch loading
  use BatchLoader::GraphQL
end
