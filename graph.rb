require_relative "knight.rb"

class Graph

    attr_accessor :nodes, :add_node, :add_edge

    def initialize
        @nodes = {}
    end

    def add_node(node)
        @nodes[node.position] = node
    end

end