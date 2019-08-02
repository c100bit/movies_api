module Resolvers
  class GetAllCountries < BaseResolver
    type [Types::CountryType], null: false

    def resolve
      Country.all
    end
    
  end
end