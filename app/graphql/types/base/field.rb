module Types
  module Base  
    class Field < GraphQL::Schema::Field
      argument_class Types::BaseArgument

      def resolve_field(obj, args, ctx)
        resolve(obj, args, ctx)
      end
    end
  end
end
