
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)

  turns = board.each do |pos|
    if(pos=="X"||pos=="O")
      count+=1
    end
  end
end

def current_player(board)
  turns=turn_count(board)
  if(turns%2==0)
    "X"
  else
    "O"
  end
end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def won?(board)

  won = WIN_COMBINATIONS.detect do |combo|
    all_full = combo.all? do |position|
      position_taken?(board,position.to_i)
    end
    if(all_full)
      if(board[combo[0]]==board[combo[1]] && board[combo[0]]==board[combo[2]])
        combo
      end
    end
  end
  if(won==[])
    false
  else
    won
  end
end


def full?(board)
  full = board.all? do |position|
    (position=="O" || position=="X")
  end
end

def draw?(board)
  draw = (!won?(board)&&full?(board))
  draw
end

def over?(board)
  over = (draw?(board)||full?(board)||won?(board))
  over
end

def winner(board)
  if(won?(board).nil?)
    nil
  else
    board[won?(board)[0]]
  end
end
