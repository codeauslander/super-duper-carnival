class CategoryTree
  def initialize(category = nil)
    @root = category
  end
  def add_category(category,parent)

  end
  def get_children(category)
    return []
  end
end

c = CategoryTree.new

c.add_category('A',nil)
c.add_category('B','A')
c.add_category('C','B')
c.add_category('D','A')

p c.get_children('A')