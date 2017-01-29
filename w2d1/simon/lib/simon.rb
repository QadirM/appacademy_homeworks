class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    sleep (2)
    system("clear")
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless @game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    system("clear")
    @seq.each do |color|
      puts color
      sleep(1)
    end
    system("clear")
  end

  def require_sequence
    puts "Ok, now its your turn. Enter the color(s) in the " +
    "same sequence:"

    seq_idx = 0
    while seq_idx < @sequence_length
      usr_inpt = gets.chomp
      if usr_inpt == @seq[seq_idx]
        seq_idx += 1
      else
        @game_over = true
        break
      end
    end

  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "You got it!"
  end

  def game_over_message
    puts "Ops! Game Over!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Simon.new
  game.play

  loop do
    puts "Want to play another round (y/n)?"
    play_again = gets.chomp
    play_again == "y" ? game.play : break
  end
end
