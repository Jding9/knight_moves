# This program will take a game board and a knight that has 8 potential moves
# All possible moves the knight could make are children in a tree
# Uses chosen search algo to find shortest path between starting square and ending square
# This algorithm compared to the old one is different because the last one was effectively a directional tree rather than a real graph

require "pry"
require_relative "knight.rb"
require_relative "graph.rb"

def generate_chess_board

    board = Graph.new()
    
    new_board = []
    x = 1
    until x == 9
        y = 1
        until y == 9
            new_board << [x, y]
            y += 1
        end
        x += 1 
    end
    
    new_board.each {|e| board.add_node(Knight.new(e))}

    board.nodes.each {|key, node|
        # key will print out the position i.e. [1, 1]
        x = key[0]
        y = key[1]

        # here we add edges to our graph by taking in the first key
        # board[key] will return the actual node
        node.add_edge(board.nodes[[x + 1, y + 2]]) if new_board.include?([x + 1, y + 2])
        node.add_edge(board.nodes[[x + 2, y + 1]]) if new_board.include?([x + 2, y + 1])
        node.add_edge(board.nodes[[x + 2, y - 1]]) if new_board.include?([x + 2, y - 1])
        node.add_edge(board.nodes[[x + 1, y - 2]]) if new_board.include?([x + 1, y - 2])

        node.add_edge(board.nodes[[x - 1, y - 2]]) if new_board.include?([x - 1, y - 2])
        node.add_edge(board.nodes[[x - 2, y - 1]]) if new_board.include?([x - 2, y - 1])
        node.add_edge(board.nodes[[x - 2, y + 1]]) if new_board.include?([x - 2, y + 1])
        node.add_edge(board.nodes[[x - 1, y + 2]]) if new_board.include?([x - 1, y + 2])
    }

    board

end


def knight_moves(start_pos, end_pos)

    def solve(start_pos, end_pos)
        game = generate_chess_board

        q = []
        q.push(game.nodes[start_pos])
    
        visited = []
        visited.push(start_pos)
        prev = {} # node and parent as a hash 
    
        while !q.empty? && !visited.include?(end_pos)

            node = q.shift

            moves = node.adjacent_nodes
    
            moves.each {|e|
                if !visited.include?(e.position) && !visited.include?(end_pos)
                    q.push(e)
                    visited.push(e.position)
                    prev[e.position] = node.position
                end
            }
    
        end

        prev

    end

    solution = solve(start_pos, end_pos)

    # reconstructs the path going backwards from the ending position
    def backtrace(start_pos, end_pos, solution)

        path = []
        path.push(end_pos)

        parent = solution[end_pos] # returns the position of the parent

        until path.include?(start_pos)
            path.push(parent)
            parent = solution[parent]
        end
        
        path = path.reverse()
        
        return path if path[0] == start_pos

    end

    final_path = backtrace(start_pos, end_pos, solution)

    p "You made it in #{final_path.size()} moves! Here's your path: #{final_path}" 
    
end

knight_moves([3,3], [4, 3])