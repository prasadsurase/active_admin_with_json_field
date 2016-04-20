class Box < ActiveRecord::Base
  belongs_to :user

  before_save :update_volumn

  private

  def update_volumn
    self.volume = self.dimensions['length'] * self.dimensions['breadth'] * self.dimensions['height']
  end
=begin
  ransacker :length_equals, formatter: -> (value){
    binding.pry
    data = where("dimensions ->> 'length' = '#{value}'").pluck :id
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :length_less_than, formatter: -> (value){
    binding.pry
    data = where("dimensions ->> 'length' < '#{value}'").pluck :id
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :length_greater_than, formatter: -> (value){
    binding.pry
    data = where("dimensions ->> 'length' > '#{value}'").pluck :id
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :breadth_equals, formatter: -> (value){
    binding.pry
    data = where("dimensions ->> 'breadth' = '#{value}'").pluck :id
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :breadth_less_than, formatter: -> (value){
    binding.pry
    data = where("dimensions ->> 'breadth' < '#{value}'").pluck :id
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :breadth_greater_than, formatter: -> (value){
    binding.pry
    data = where("dimensions ->> 'breadth' > '#{value}'").pluck :id
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :height_equals, formatter: -> (value){
    binding.pry
    data = where("dimensions ->> 'height' = '#{value}'").pluck :id
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :height_less_than, formatter: -> (value){
    binding.pry
    data = where("dimensions ->> 'height' < '#{value}'").pluck :id
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :height_greater_than, formatter: -> (value){
    binding.pry
    data = where("dimensions ->> 'height' > '#{value}'").pluck :id
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end
=end

  ransacker :length do |parent|
    Arel::Nodes::InfixOperation.new('->>', parent.table[:dimensions], Arel::Nodes.build_quoted('length'))
  end

  ransacker :breadth do |parent|
    Arel::Nodes::InfixOperation.new('->>', parent.table[:dimensions], Arel::Nodes.build_quoted('breadth'))
  end

  ransacker :height do |parent|
    Arel::Nodes::InfixOperation.new('->>', parent.table[:dimensions], Arel::Nodes.build_quoted('height'))
  end
end
