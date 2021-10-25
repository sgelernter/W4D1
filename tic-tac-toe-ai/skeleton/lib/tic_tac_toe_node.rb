require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos, :current_mark
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos 
    @current_mark = @next_mover_mark == :x ? :o : :x 
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    @children = [] 
    (0..2).each do |row|
      (0..2).each do |col|
        pos = row, col
        if @board.empty?(pos)
          dup = @board.dup
          dup[pos] = @current_mark 
          @children << TicTacToeNode.new(dup, @current_mark, pos)
        end
      end
    end
    @children   
  end

  def losing_node?(eval)
    #debugger
      return false if @board.over? && @board.winner == eval
      return true if @board.over? && @board.winner != eval
    
      
  
      if eval != self.current_mark
        #debugger
        if self.children.all? {|child| child.losing_node?(eval)}
          return false
        end
        return true
      else    
        if self.children.any? {|child| child.losing_node?(eval)}
          return true
        end
        #return false
      end
        
  end

  def winning_node?(eval)

  end
end
