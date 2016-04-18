module ActiveAdmin
  class OrderClause
    attr_reader :field, :order

    def initialize(clause)
      clause =~ /^([\w\_\.]+)(->'\w+')?_(desc|asc)$|^([\w\_\.]+->>'[\w\_]+')(->'\w+')?_(desc|asc)$/
      @column = $1 || $4
      @op = $2 || $5
      @order = $3 || $6

      @field = [@column, @op].compact.join
    end

    def valid?
      @field.present? && @order.present?
    end

    def to_sql(active_admin_config)
      table = column_in_table?(active_admin_config.resource_column_names, @column) ? active_admin_config.resource_table_name : nil
      table_column = (@column =~ /\./) ? @column : [ table, json_column?(@column) ? @column : active_admin_config.resource_quoted_column_name(@column) ].compact.join(".")
      [table_column, @op, ' ', @order].compact.join
    end

    private

    def json_column?(column)
      column.include?('->>')
    end

    def column_in_table?(names, column)
      column = json_column?(column) ? column.split('->>')[0].strip : column
      names.include?(column)
    end
  end
end
