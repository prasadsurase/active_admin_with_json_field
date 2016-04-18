ActiveAdmin.register Box do
  filter :user_email, as: :string, label: 'Tester Email'
  #filter :length, as: :numeric, label: 'Length'
  #filter :breadth, as: :numeric, label: 'Breadth'
  #filter :height, as: :numeric, label: 'Height'

  controller do
    def scoped_collection
      Box.includes(:user).select("*, dimensions ->> 'length' as length, dimensions ->> 'breadth' as breadth, dimensions ->> 'height' as height")
    end

    def apply_sorting(chain)
      params[:order] ||= active_admin_config.sort_order

      orders = []
      params[:order].split('_and_').each do |fragment|
        order_clause = ActiveAdmin::OrderClause.new fragment
        if order_clause.valid?
          orders << order_clause.to_sql(active_admin_config)
        end
      end

      if orders.empty?
        chain
      else
        chain.reorder(orders.shift).order(orders)
      end
    end
  end

  index do
    column :email, sortable: 'users.email' do |stats| link_to(stats.user.email, admin_user_path(id: stats.user_id)) end
    #column :email do |user| link_to(user.email, admin_customer_path(user.id)) end
    column :length, label: 'Length', sortable: "dimensions->>'length'"
    column :breadth, label: 'Breadth', sortable: "dimensions->>'breadth'"
    column :height, label: 'Height', sortable: "dimensions->>'height'"
    column :dimensions, label: 'Dimensions', sortable: false
  end
end
