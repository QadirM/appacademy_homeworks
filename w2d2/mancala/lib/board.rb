class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1, @name2 = name1,  name2
    @cups = Array.new(14)
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_index do |idx|
      unless idx == 6 || idx == 13
        @cups[idx] = [:stone, :stone, :stone, :stone]
      else
        @cups[idx] = []
      end
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" unless start_pos.between?(0,12)
    raise "Invalid starting cup" if cups[start_pos].empty?
    true
  end

  def make_move(start_pos, current_player_name)
    @current_player = current_player_name
    num_of_stones = cups[start_pos].length
    cups[start_pos] = []
    until num_of_stones == 0
      start_pos += 1
      next if current_player_name == @name1 && start_pos == 13
      next if current_player_name == @name2 && start_pos == 6
      start_pos -= 14 if start_pos == 14
      cups[start_pos] << :stone
      num_of_stones -= 1
    end
    render
    next_turn(start_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
    if (@current_player == @name1 && ending_cup_idx == 6) || (@current_player == @name2 && ending_cup_idx == 13)
      return :prompt
    elsif @cups[ending_cup_idx].length == 1
      return :switch
    elsif !@cups[ending_cup_idx].empty?
      ending_cup_idx -= 1 if ending_cup_idx < 7
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    (0..5).all? { |idx| @cups[idx] == [] } || (7..12).all? { |idx| @cups[idx] == [] }
  end

  def winner
    case @cups[6].length <=> @cups[13].length
    when 0
      :draw
    when -1
      @name2
    when 1
      @name1
    end
  end
end
