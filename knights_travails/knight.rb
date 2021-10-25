require_relative "./tree_node.rb"

#find moves from a location

#check valid position (store past moves)
class Knight

    attr_reader :move_tree, :considered_positions, :root_node
    def initialize(pos) #accepts array
        @root_node = PolyTreeNode.new(pos) 
        @considered_positions = [pos] 
        self.build_move_tree
        
    end

    def val_pos?(pos)
        x, y = pos
        if (x >= 0 && x <= 7) && (y >= 0 && y <= 7)
            if !@considered_positions.include?(pos)
                return true
            else
                false
            end
        else
            false
        end
    end

    def get_moves(pos)
        moves = []
        x, y = pos
        big_move = [-2, 2]
        small_move = [-1, 1]
        big_move.each do |big|
            small_move.each do |small|
                moves << [x + big, y + small]
                moves << [x + small, y + big]
            end
        end
        moves
    end

    def build_move_tree
        queue = []
        queue << @root_node
        until queue.empty?
            node = queue.shift
            moves = get_moves(node.value)
            moves.select! {|pos| val_pos?(pos)}
            moves.each do |move| 
                @considered_positions << move
                move_node = PolyTreeNode.new(move)
                move_node.parent = node
                queue << move_node
            end
        end
    end

    def find_path(end_pos)
        @root_node.bfs(end_pos)
    end

    def trace_path_back(pos)
        node = find_path(pos)
        arr = [node.value]
        until node.parent == nil
            arr.unshift(node.parent.value)
            node = node.parent
        end
        arr
    end
            
end


knight = Knight.new([0,0])

p knight.trace_path_back([7, 6])
p knight.trace_path_back([6,2])