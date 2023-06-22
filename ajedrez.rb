class Board
  attr_reader :board

  def initialize(size)
    @size = size
    @board = Array.new(size) { Array.new(size) }
  end

  def valid_moves(position)
    x, y = position
    moves = [[-2, -1], [-1, -2], [-2, 1], [-1, 2], [1, -2], [2, -1], [1, 2], [2, 1]]
    moves.map { |dx, dy| [x + dx, y + dy] }.select { |x, y| x.between?(0, @size - 1) && y.between?(0, @size - 1) }
  end
end

class BFS
  def initialize(board)
    @board = board
  end

  def shortest_path(start, goal)
    visited = {}
    queue = [[start, [start]]]

    until queue.empty?
      current, path = queue.shift
      return path if current == goal

      @board.valid_moves(current).each do |move|
        next if visited[move]

        visited[move] = true
        queue << [move, path + [move]]
      end
    end
  end
end

def knight_moves(start, goal)
  board = Board.new(8)
  bfs = BFS.new(board)
  path = bfs.shortest_path(start, goal)

  puts "Lo hiciste en #{path.length - 1} movimientos! Aqui esta tu camino:"
  path.each { |p| puts p.inspect }
end

puts "Ingrese la posición de inicio como 'x, y':"
start = gets.chomp.split(',').map(&:to_i)
puts "Ingrese la posición de inicio como 'x, y':"
goal = gets.chomp.split(',').map(&:to_i)

knight_moves(start, goal)
