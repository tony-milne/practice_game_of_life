require "./lib/cell.rb"
#require "./lib/grid.rb"

class Life
  attr_accessor :grid
  
  def initialize(data)
    @grid = convert_to_grid_with_cells(data)
  end
  
  def tick
    # iterate through each cell
    #   if less than 2 neighbours, cell dies
    #   if more than 3 neighbours, cell dies
    #   if 3 neighbours, empty cell comes to life
    #   if 3 neighbours, live cell stays alive
    
    new_grid = []
    h = Hash.new
    row_num = 0 # y
    @grid.each do |r|
      new_row = []
      col_num = 0 # x
      r.each do |c|
        if c.alive?
          # check live neighbours to see if cell should die of overcrowding or
          # isolation
          num_alive = check_live_neighbours(row_num, col_num)
          
          # check dead neighbours to see if cell should reproduce
          dead_neighbours = get_dead_neighbours(row_num, col_num)
          
          dead_neighbours.each do |c|
            if h.key? c
              cells = h[c]
              cells << [row_num, col_num]
            else
              h[c] = [[row_num, col_num]]
            end
          end
          
          if((num_alive < 2) || (num_alive >= 4))
            #c.toggle_state #alive toggles to dead
            #puts c.state
            new_row << Cell.new(".")
          else
            new_row << c
          end
        else
          new_row << c
        end
        col_num += 1
      end
      new_grid << new_row
      row_num += 1
    end
    
    h.each do |k, v|
      if v.length == 3
        row = k[0]
        col = k[1]
        new_grid[row][col] = Cell.new("x")
      end
    end
    
    @grid = new_grid
  end
  
  def check_live_neighbours(row, col)
    num_alive = 0
    check_neighbours(row, col) do |c|
      if c.alive?
        num_alive += 1
      end
    end
    return num_alive
  end
  
  def get_dead_neighbours(row, col)
    dead_cells = []
    check_neighbours(row, col) do |c, coord|
      if !c.alive?
        dead_cells << coord
      end
    end
    return dead_cells
  end
  
  def check_neighbours(row, col)
    if (row-1) >= 0
      c = @grid[row-1][col]
      yield c, [(row-1), col]
      if (col-1) >= 0
        c = @grid[row-1][col-1]
        yield c, [(row-1),(col-1)]
      end
      if (col+1) < @grid[0].length
        c = @grid[row-1][col+1]
        yield c, [(row-1),(col+1)]
      end
    end
    
    if (col-1) >= 0
      c = @grid[row][col-1]
      yield c, [row, (col-1)]
    end
    
    if (col+1) < @grid[0].length
      c = @grid[row][col+1]
      yield c, [row, (col+1)]
    end
    
    if (row+1) < @grid.length
      c = @grid[row+1][col]
      yield c, [(row+1), col]
      if (col-1) >= 0
        c = @grid[row+1][col-1]
        yield c, [(row+1), (col-1)]
      end
      if (col+1) < @grid[0].length
        c = @grid[row+1][col+1]
        yield c, [(row+1), (col+1)]
      end
    end
  end
  
  def convert_to_grid_with_cells(data)
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
  
  # if grid array of cells cannot be compared, return grid
  # containing array of charaters (strings)
  def get_grid
    #TODO
  end
  
end
