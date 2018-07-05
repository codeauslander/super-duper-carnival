class CategoryTree
  attr_accessor :category, :parent, :children
  def initialize(category,parent)
    @category = category
    @parent = nil
    @children = []
  end

  def add_category(category,parent)
    node = search(parent)
    node.children << CategoryTree.new(category,parent)
  end

  def search(category)
    node = self
    children = node.children
    index = children.index(category)
    while (index == nil)
      
    end
  end

  def get_children(category)
    node = search(category)
    return node.children
  end
end

c = CategoryTree.new

c.add_category('A',nil)
c.add_category('B','A')
c.add_category('C','B')
c.add_category('D','A')

p c.get_children('A')

