require "./lib/cell.rb"

class Life
  attr_reader :grid
  
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
    dead_neighbours_hash = Hash.new # to contain hash of dead cells (key) with
                                    # live neighbours (value)
    row_num = 0
    @grid.each do |r|
      new_row = []
      col_num = 0
      r.each do |c|
        if c.alive?
          # check live neighbours to see if cell should die of overcrowding or
          # isolation
          num_alive = check_live_neighbours(row_num, col_num)
          
          # get list of dead neighbours to check later on for cell reproduction
          dead_neighbours = get_dead_neighbours(row_num, col_num)
          dead_neighbours_hash = add_dead_neighbours_to_hash(dead_neighbours, dead_neighbours_hash, row_num, col_num)
          
          # kills off cell if too many or too few neighbours
          if((num_alive < 2) || (num_alive >= 4))
            new_cell = c.dup
            new_row << new_cell.toggle_state
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
    
    # dead cell with 3 live neighbours reproduces
    new_grid = set_reproduced_cells(dead_neighbours_hash, new_grid)
    
    # overwrite old grid state
    @grid = new_grid
  end
  
  def get_grid
    ret_grid = []
    @grid.each do |r|
      row = []
      r.each do |c|
        row << c.state
      end
      ret_grid << row
    end
    return ret_grid
  end
  
  private
  
  def add_dead_neighbours_to_hash(dead_neighbours, dead_neighbours_hash, cur_row, cur_col)
    dead_neighbours.each do |coord|
      if dead_neighbours_hash.key? coord
        cells = dead_neighbours_hash[coord]
        cells << [cur_row, cur_col]
      else
        dead_neighbours_hash[coord] = [[cur_row, cur_col]]
      end
    end
    return dead_neighbours_hash
  end
  
  def set_reproduced_cells(dead_neighbours_hash, grid)
    dead_neighbours_hash.each do |k, v|
      if v.length == 3
        row = k[0]
        col = k[1]
        c = grid[row][col]
        c.toggle_state
      end
    end
    return grid
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
  
end
