class CategoryTree
  attr_accessor :category, :parent, :children
  def initialize
    @children = []
  end

  def add_category(category,parent)

    if parent == nil
      @category = category
      @parent = parent
    end

    node = self
    parent = parent
    child = CategoryTree.new()
    child.category = category
    child.parent = parent
    node.children << child
  end



  def get_children(category)
    node = self
    while node.category != category && node.parent != nil
      node = node.parent
    end
    node.children.map { |child|  puts "#{child.category} "}
  end
end

c = CategoryTree.new()

c.add_category('A',nil)
c.add_category('B','A')
c.add_category('C','A')
c.add_category('D','A')

p c.get_children('A')

