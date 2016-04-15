module Hurray
  extend ActiveSupport::Concern

  module ClassMethods
    # Get records ordered according to the ids order
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
