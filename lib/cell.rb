puts "Cell included"

class Cell
  STATES = ["x", "."]
  attr_reader :state
  
  def initialize(state)
    @state = verify_state(state)
  end
  
  def state=(state)
    @state = verify_state(state)
  end
  
  def toggle_state
    if @state == STATES[0]
      @state = STATES[1]
    else
      @state = STATES[0]
    end
  end
  
  def alive?
    if @state == "x"
      return true
    else
      return false
    end
  end
  
  private
  
  def verify_state(state)
    case state
    when STATES.include?(state)
      return state
    else
      raise "Unknown state"
    end    
  end
end
