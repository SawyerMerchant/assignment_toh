def render
  puts "Current Board:"
  p @towers[0]
  p @towers[1]
  p @towers[2]
  5.times {print "-"}
  p " "

  heights = []
  @towers.each do |tower|
    heights << tower.length
  end
  rows = heights.max

  @display_towers = [[],[],[]]
  3.times do |i|
    if @towers[i].length == rows
      @display_towers[i] = @towers[i].dup.reverse
    else
      to_add = rows - @towers[i].length
      @display_towers[i] = @towers[i].dup
      to_add.times do
        @display_towers[i] << 0
      end
      @display_towers[i].reverse!
    end
  end

  rows.times do |row|
    3.times do |column|
      @display_towers[column][row].times {print "o"} unless @display_towers[column].nil? || @display_towers[column][row].nil?
      print "".ljust(@number_of_disks + 1)
    end
    puts ""
  end


  # tower labels
  3.times do |i|
    print i + 1
    (@number_of_disks+1).times {print " "}
  end
end


def TowerOfHanoi(number_of_disks)
  @win, @quit = false, false
  @number_of_disks = number_of_disks
  @towers = [[],[],[]]
  @towers[0] = Array (1..number_of_disks)
  @towers[0].reverse!
  @tower_2, @tower_3 = [], []
  @tower_1 = Array (1..number_of_disks)
  @tower_1.reverse!
  puts "Welcome to Tower of Hanoi!"
  puts "Instructions:"
  puts "Enter where you'd like to move from and to"
  puts "in the format '1,3'. Enter 'q' to quit."
  render

  def bad_input?(moves_array)
    if moves_array[0].nil? || moves_array[1].nil? || !(1..3).include?(moves_array[0].to_i) || !(1..3).include?(moves_array[1].to_i)
      puts "That is an illegal move. Recall: two numbers seperated by a comma, both between 1 and 3"
      play
    end
  end

  def legal_move?
    if @towers[@start_move - 1].empty?
      puts "Careful, tower number #{@start_move} is empty"
      play
    end
    if @towers[@end_move-1].empty? || @towers[@start_move-1][-1] < @towers[@end_move-1][-1]
      puts "Interesting move..."
      true
    else
      puts "Remember, large disks may not top smaller ones"
      false
    end
  end

  def allow_move?()
    moves_array = @move.split(",")
    bad_input?(moves_array)
    @start_move = moves_array[0].to_i
    @end_move = moves_array[1].to_i
    legal_move?
  end

  def get_move
    puts "Enter Move, my friend"
    @move = gets.chomp
    if @move == "quit"
      @quit == true
      puts "Thx for playing"
      exit
    end
  end

  def execute_move()
    @towers[@end_move-1] << @towers[@start_move-1].pop
  end


  def check_for_end
    if @towers[0].empty? && @towers[1].empty?
      puts "Well done, you win"
      @win == true
      exit
    end
    if @quit == true
      puts "Thanks for playing"
      exit
    end
  end

  def play
    until @win == true || @quit == true
      get_move
      if allow_move?
        execute_move
      else
        play
      end
      render
      check_for_end
    end
  end

  play
end