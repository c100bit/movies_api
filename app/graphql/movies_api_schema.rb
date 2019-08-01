class MoviesApiSchema < GraphQL::Schema
  mutation(Root::MutationType)
  query(Root::QueryType)
end
