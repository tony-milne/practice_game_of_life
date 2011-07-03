require "./lib/cell.rb"
require "./lib/grid.rb"

class Life
  attr_accessor :grid
  
  def initialize(data)
    @grid = Grid.new(nil, nil, data)
  end
  
  def tick
    # iterate through each cell
    #   if less than 2 neighbours, cell dies
    #   if more than 3 neighbours, cell dies
    #   if 3 neighbours, empty cell comes to life
    #   if 3 neighbours, live cell stays alive
    
    row_num = 0
    @grid.each_row do |r|
      col_num = 0
      r.each do |c|
        if c.alive?
          #check neighbours
          arr = check_num_of_alive_neighbours(col_num, row_num)
          num_alive_neighbours = arr[0]
          dead_neighbours = arr[1]
          
          if num_alive_neighbours < 2 || num_alive_neighbours >= 4
            c.toggle #alive toggles to dead
          end
        end
        check_empty_cells_for_reproduction
      end
    end
  end
  
  def load_grid(data)
    @grid = Grid.convert(data)
  end
  
  def check_num_of_alive_neighbours(x,y)
    num_alive = 0
    dead_cells = []
    if (x-1) >= 0
      c = @grid.cell_at(x-1, y) 
      if c.alive?
        num_alive += 1
      else
        dead_cells << c
      end
      if (y-1) >= 0
        c = @grid.cell_at(x-1, y-1) 
        if c.alive?
          num_alive += 1
        else
          dead_cells << c
        end
      end
      if (y+1) < @grid.num_row
        c = @grid.cell_at(x-1, y+1) 
        if c.alive?
          num_alive += 1
        else
          dead_cells << c
        end
      end
    end
    
    if (y-1) >= 0
      c = @grid.cell_at(x, y-1)
      if c.alive?
        num_alive += 1
      else
        dead_cells << c
      end
    end
    
    if (y+1) < @grid.num_row
      c = @grid.cell_at(x, y+1) 
      if c.alive?
        num_alive += 1
      else
        dead_cells << c
      end
    end
    
    if (x+1) < @grid.num_col
      c = @grid.cell_at(x+1, y)
      if c.alive?
        num_alive += 1
      else
        dead_cells << c
      end
      if (y-1) >= 0
        c = @grid.cell_at(x+1, y-1)
        if c.alive?
          num_alive += 1
        else
          dead_cells << c
        end
      end
      if (y+1) < @grid.num_row
        c = @grid.cell_at(x+1, y+1)
        if c.alive?
          num_alive += 1
        else
          dead_cells << c
        end
      end
    end
    return num_alive, dead_cells
  end
end
