module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    argument_class Types::Base::Argument
  end
end