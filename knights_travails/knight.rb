require_relative "./tree_node.rb"

#find moves from a location

#check valid position (store past moves)
class Knight

    attr_reader :move_tree, :considered_positions, :root_node
    def initialize(pos) #accepts array
        @root_node = PolyTreeNode.new(pos) 
        @considered_positions = [pos] 
        @move_tree = self.build_move_tree
        
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

        ###start with root###
        #check all valid positions
        #add those as new nodes, update parents (def)/children (for parent)
        #add those to considered positions
    def build_move_tree
        queue = []
        tree = []
        queue << @root_node
        until queue.empty?
            node = queue.shift
            tree << node
            moves = get_moves(node.value)
            moves.select! {|pos| val_pos?(pos)}
            moves.each do |move| 
                @considered_positions << move
                move_node = PolyTreeNode.new(move)
                move_node.parent = node
                queue << move_node
            end
        end
        tree
    end
end


knight = Knight.new([0,0])
p knight.root_node
p knight.move_tree.count