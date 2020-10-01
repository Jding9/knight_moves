class Knight

    attr_accessor :position, :adjacent_nodes, :add_edge

    # position is an [x, y] array
    # adjacent_nodes is an array of all potential nodes

    def initialize(position)
        @position = position
        @adjacent_nodes = []
    end

    def add_edge(adjacent_node)
        @adjacent_nodes << adjacent_node
    end

end
