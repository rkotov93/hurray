# ActiveRecord module for working with database arrays
module Hurray
  extend ActiveSupport::Concern

  module ClassMethods
    # Get records ordered according to the specified with array column order
    #
    # Examples:
    #   >> User.ordered_with(id: [4,2,6])
    #   => User::ActiveRecord_Relation [#<User id: 4 ...>, #<User id: 2 ...>, #<User id: 6 ...>, #<User id: 1 ...>, ...]
    #
    #   >> User.joins(:friends).ordered_with(friends: { id: [4, 2, 6] })
    #
    # Arguments:
    #   hash: (Hash)

    def ordered_with(hash)
      params = []
      parse_ordered_with_params(hash, params)

      order_clause = ''
      params.each_with_index do |param, index|
        order_clause << ', ' if index != 0
        order_clause << "CASE #{param[:table]}.#{param[:column]} "
        array = param[:array]
        array.each_with_index do |el, pos|
          order_clause << sanitize_sql_array(['WHEN ? THEN ? ', el, pos])
        end
        order_clause << sanitize_sql_array(['ELSE ? END', array.length])
      end

      order(Arel.sql(order_clause))
    end

    private

    def parse_ordered_with_params(table = table_name, hash, params)
      hash.each do |k, v|
        if v.is_a? Hash
          parse_ordered_with_params(k.to_s, v, params)
        else
          params << { table: table, column: k.to_s, array: v } unless v.empty? || v.nil?
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, Hurray)
