puts "Grid included"

# Remove h & w later on
class Grid
  def initialize(height=nil, width=nil, data=nil)
    if((data.nil?) && (!height.nil? && !width.nil?))
      @grid = create_grid
    elsif !data.nil?
      @grid = self.convert(data)
    else
      raise "Incorrect parameters passed"
    end
  end
  
  def cell_at(x, y)
    return @grid[x][y]
  end
  
  def each_row
    @grid.each do |c|
      yield c
    end
  end
  
  def num_col
    return @grid[0].length
  end
  
  def num_row
    return @grid.length
  end
  
  def self.convert(data)
    grid = []
    data.each do |r|
      row = []
      r.each do |c|
        row << Cell.new(c)
      end
      grid << row
    end 
    return grid
  end
  
  # remove if grids can be compared via g1 == g2
  def self.compare_grids(g1, g2)
    #TODO
  end
  
  # Sort out later! remove?
  def create_grid
    grid = []
    while height > 0
      row = []
      while width > 0
        row << Cell.new(".")
        width -= 1
      end
      grid << row
      height -= 1
    end
    return grid
  end
end
