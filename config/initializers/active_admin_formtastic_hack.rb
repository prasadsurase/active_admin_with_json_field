module ActiveAdmin
  module Filters
    module FormtasticAddons
      def seems_searchable?
        has_predicate? || scope?
      end
    end
  end
end

