# ActiveRecord module for working with database arrays
module Hurray
  extend ActiveSupport::Concern

  module ClassMethods
    # Get records ordered according to the ids order
    #
    # Example:
    #   >> User.ordered_with([4,2,6])
    #   => User::ActiveRecord_Relation
    #   => [#<User id: 4 ...>, #<User id: 2 ...>, #<User id: 6 ...>]
    #
    # Arguments:
    #   ids: (Array)
    def ordered_with(ids)
      order_clause = 'CASE id '
      ids.each_with_index do |id, index|
        order_clause << sanitize_sql_array(['WHEN ? THEN ? ', id, index])
      end
      order_clause << sanitize_sql_array(['ELSE ? END', ids.length])
      where(id: ids).order(order_clause)
    end
  end
end

ActiveRecord::Base.send(:include, Hurray)
