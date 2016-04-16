# ActiveRecord module for working with database arrays
module Hurray
  extend ActiveSupport::Concern

  module ClassMethods
    # Get records ordered according to the ids order
    #
    # Example:
    #   >> User.ordered_with([4,2,6])
    #   => User::ActiveRecord_Relation [#<User id: 4 ...>, #<User id: 2 ...>, #<User id: 6 ...>]
    #
    # Arguments:
    #   ids: (Array)
    def ordered_with(pair = {})
      column, array = pair.first
      order_clause = "CASE #{column} "
      array.each_with_index do |el, index|
        order_clause << sanitize_sql_array(['WHEN ? THEN ? ', el, index])
      end
      order_clause << sanitize_sql_array(['ELSE ? END', array.length])
      where(id: array).order(order_clause)
    end
  end
end

ActiveRecord::Base.send(:include, Hurray)
