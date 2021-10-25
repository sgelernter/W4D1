require "byebug"
class PolyTreeNode

    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        if node == nil
            @parent = nil 
        else
            if @parent != nil
                @parent.children.delete(self)
            end
            @parent = node 
            node.children << self if !node.children.include?(self)
        end
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        raise unless children.include?(child)
        child.parent = nil
    end

    def dfs(target)
        return self if self.value == target
        children.each do |child|
            search = child.dfs(target)
            return search if search != nil
        end
        nil
    end

    def bfs(target)
        queue = []
        queue << self
        until queue.empty?
            val = queue.shift
            if val.value == target
                return val
            else
                val.children.each {|child| queue << child } 
            end
        end
        nil
    end

    def inspect
        { 'value' => @value, 'parent_value' => @parent ? parent.value : nil , 'children' => @children }.inspect
    end

end