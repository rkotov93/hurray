# ActiveRecord module for working with database arrays
module Hurray
  extend ActiveSupport::Concern

  module ClassMethods
    # Get records ordered according to the specified with array column order
    #
    # Examples:
    #   >> User.ordered_with(:id, [4,2,6])
    #   => User::ActiveRecord_Relation [#<User id: 4 ...>, #<User id: 2 ...>, #<User id: 6 ...>, #<User id: 1 ...>, ...]
    #
    #   >> User.ordered_with(:id, [4,2,6], provided_only: true)
    #   => User::ActiveRecord_Relation [#<User id: 4 ...>, #<User id: 2 ...>, #<User id: 6 ...>]
    #
    #   >> User.ordered_with(:name, %w(Nick Malvin John), provided_only: true)
    #   => User::ActiveRecord_Relation [#<User name: Nick ...>, #<User name: Malvin ...>, #<User name: John ...>]
    #
    # Arguments:
    #   column:  (Key or String) # DB column
    #   array:   (Array)         # Custom order
    #   options: (Hash)
    #     povided:   (Boolean)       # Get records satisfying array values
    #     direction: (Key or String) # :asc or :desc

    def ordered_with(column, array, options = {})
      direction = options[:direction].to_s.upcase
      direction = %w(ASC DESC).include?(direction) ? direction : 'ASC'
      provided_only = options[:provided_only].nil? ? false : options[:provided_only]

      order_clause = "CASE #{column} "
      array.each_with_index do |el, index|
        order_clause << sanitize_sql_array(['WHEN ? THEN ? ', el, index])
      end
      order_clause << sanitize_sql_array(['ELSE ? END ', array.length]) << direction

      return where(column => array).order(order_clause) if provided_only
      order(order_clause)
    end
  end
end

ActiveRecord::Base.send(:include, Hurray)
