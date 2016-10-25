def TowerOfHanoi(number_of_disks)
  def render(towers)
    puts "Current Board:"
    15.times {print "-"}
    print "\n"

    heights = []
    towers.each do |tower|
      heights << tower.length
    end
    rows = heights.max

    @display_towers = [[],[],[]]
    3.times do |i|
      if towers[i].length == rows
        @display_towers[i] = towers[i].dup.reverse
      else
        to_add = rows - towers[i].length
        @display_towers[i] = towers[i].dup
        to_add.times do
          @display_towers[i] << 0
        end
        @display_towers[i].reverse!
      end
    end

    rows.times do |row|
      3.times do |column|
        to_print = ""
        @display_towers[column][row].times {to_print += "o"} unless @display_towers[column].nil? || @display_towers[column][row].nil?
        print to_print.ljust(@number_of_disks + 2)
      end
      puts ""
    end


    # tower labels
    3.times do |i|
      print i + 1
      (@number_of_disks+1).times {print " "}
    end
  end

  def bad_input?(moves_array, towers)
    if moves_array[0].nil? || moves_array[1].nil? || !(1..3).include?(moves_array[0].to_i) || !(1..3).include?(moves_array[1].to_i)
      puts "That is an illegal move. Recall: two numbers seperated by a comma, both between 1 and 3"
      play(towers)
    end
  end

  def legal_move?(towers)
    if towers[@start_move - 1].empty?
      puts "Careful, tower number #{@start_move} is empty"
      play(towers)
    end
    if towers[@end_move-1].empty? || towers[@start_move-1][-1] < towers[@end_move-1][-1]
      puts "Interesting move..."
      true
    else
      puts "Remember, large disks may not top smaller ones"
      false
    end
  end

  def allow_move?(towers)
    moves_array = @move.split(",")
    bad_input?(moves_array, towers)
    @start_move = moves_array[0].to_i
    @end_move = moves_array[1].to_i
    legal_move?(towers)
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

  def execute_move(towers)
    towers[@end_move-1] << towers[@start_move-1].pop
  end


  def check_for_end(towers)
    if towers[0].empty? && towers[1].empty?
      puts "Well done, you win"
      @win == true
      exit
    end
    if @quit == true
      puts "Thanks for playing"
      exit
    end
  end

  def play(towers)
    until @win == true || @quit == true
      get_move
      if allow_move?(towers)
        execute_move(towers)
      else
        play(towers)
      end
      render(towers)
      check_for_end(towers)
    end
  end

  @win, @quit = false, false
  @number_of_disks = number_of_disks
  towers = [[],[],[]]
  towers[0] = Array (1..number_of_disks)
  towers[0].reverse!
  tower_2, tower_3 = [], []
  tower_1 = Array (1..number_of_disks)
  tower_1.reverse!
  puts "Welcome to Tower of Hanoi!"
  puts "Instructions:"
  puts "Enter where you'd like to move from and to"
  puts "in the format '1,3'. Enter 'q' to quit."
  render(towers)

  play(towers)
end