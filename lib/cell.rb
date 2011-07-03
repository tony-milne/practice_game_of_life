puts "Cell included"

class Cell
  ALIVE_CELL = "x"
  DEAD_CELL = "."
  attr_reader :state
  
  def initialize(state)
    @state = verify_state(state)
  end
  
  def state=(state)
    @state = verify_state(state)
  end
  
  def toggle_state
    if @state == ALIVE_CELL
      @state = DEAD_CELL
    else
      @state = ALIVE_CELL
    end
  end
  
  def alive?
    if @state == ALIVE_CELL
      return true
    else
      return false
    end
  end
  
  private
  
  def verify_state(state)
    case state
    when ALIVE_CELL || DEAD_CELL
      return state
    else
      raise "Unknown state"
    end    
  end
end
