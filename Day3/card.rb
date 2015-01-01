class Card
  @@priority = Array.new
  @@winners = Array.new
  @@won = false
  def initialize(cards)
    @cards = cards
  end
  def playCard
    @cards.each do
    |index,items|
      raisedRunCards = Array.new
      rawDividedCards = (items.map{|card| card%13})
      dividedCards = Array.new
      rawDividedCards.size.times.select do
      |i|
        if rawDividedCards[i] != 0
          dividedCards << rawDividedCards[i]
        else
          dividedCards << 13
        end
      end
      runCards = dividedCards.sort
      if(dividedCards[0] == dividedCards[1] && dividedCards[1] == dividedCards[2])
        @@priority << [19,dividedCards[0]]
      elsif((items[0]<14 && items[1]<14 && items[2]<14) || ((items[0]>=14 && items[0]<27) && (items[1]>=14 && items[1]<27) && (items[2]>=14 && items[2]<27)) || (items[0]>=27 && items[0]<40) && (items[1]>=27 && items[1]<40) && (items[2]>=27 && items[2]<40) || (items[0]>=40 && items[1]>=40 && items[2]>=40))
        if((runCards[2] - runCards[0]) == 2 && (runCards[1] - runCards[0]) == 1)
          raisedRunCards = raiseAce(runCards)
          @@priority << [18,raisedRunCards[2]]
        else
          raisedRunCards = raiseAce(runCards)
          @@priority << [16,raisedRunCards[2]]
        end
      elsif((runCards[2] - runCards[0]) == 2 && (runCards[1] - runCards[0]) == 1)
        raisedRunCards = raiseAce(runCards)
        @@priority << [17,raisedRunCards[2]]
      elsif((runCards[0] == runCards[1]) || (runCards[0] == runCards[2]) || (runCards[1] == runCards[2]))
        raisedRunCards = raiseAce(runCards)
        if runCards[2] == runCards[1]
          @@priority << [15,raisedRunCards[1]]
        else
          @@priority << [15,raisedRunCards[0]]
        end
      else
        raisedRunCards = raiseAce(runCards)
        @@priority << [raisedRunCards[2],raisedRunCards[1],raisedRunCards[0]]
      end
      print "#{index} gets"
      items.each_with_index do
      |card,i|
        value = card%13
        case value
          when 1
            print " Ace"
          when 2..10
            print " #{value}"
          when 11
            print " Jack"
          when 12
            print " Queen"
          when 0
            print " King"
        end
        if card < 14
          print " of Clubes"
        elsif card < 27
          print " of Hearts"
        elsif card < 40
          print " of Diamonds"
        else
          print " of Spades"
        end
        if i != 2
          print ","
        end
      end
      puts ""
    end
    3.times do
    |i|
      if @@won == false
        announceWinner(@@priority,i)
      else
        break
      end
    end
  end

  def announceWinner(priorityArray,pos)
    p priorityArray
    arr = Array.new
    priorityArray.size.times.select {|i| arr << priorityArray[i][pos]}
    winnerCardType = arr.max
    drawPlayer = priorityArray.size.times.select {|i| priorityArray[i][pos] == winnerCardType}
    p drawPlayer.size
    if pos == 0
      @@winners = drawPlayer
      p @@winners
    else
      winners = Array.new
      drawPlayer.each_with_index do
      |val,i|
        winners << @@winners[val]
      end
      @@winners = winners
    end
    if drawPlayer.length == 1
      puts "Player " << (@@winners.max + 1).to_s << " is winner"
      @@won = true
    else
      priority = Array.new
      drawPlayer.each_with_index do
      |val,i|
        priority << @@priority[val]
      end
      @@priority = priority
    end
  end

  def raiseAce(runsCards)
    if runsCards[0] == 1
      runsCards = runsCards.slice(1..2)
      runsCards << 14
    end
    runsCards
  end
end

class Player
  def initialize
    @game = Game.new
  end

  def assignPlayer
    puts "Enter the Numbers of Player"
    rawNumberOfPlayer = gets
    #begin
    numberOfPlayer = Integer(rawNumberOfPlayer)
    if(numberOfPlayer > 1 && numberOfPlayer < 18)
      @game.assignCard(numberOfPlayer)
    else
      puts "Please enter valid number of player"
    end
    #rescue
    #puts "Please enter valid number of player"
    #end
  end
end

class Game
  def initialize
  end

  def assignCard(numberOfPlayer)
    cardArray = Hash.new
    cardOccured = Array.new

    while (cardOccured.length != (numberOfPlayer*3)) do
      if cardOccured.length != 0
        card = (1..52).to_a.sample
        isPresent = false
        cardOccured.inject(0) do
        |index,item|
          if card == item
            isPresent = true
            break
          end
        end
        if isPresent == false
          cardOccured << card
        end
      else
        cardOccured << (1..52).to_a.sample
      end
    end
    p cardOccured.to_s
    numberOfPlayer.times do
      playerName = "Player " << (cardArray.length + 1).to_s
      cardArray[:"#{playerName}"] = []
      3.times do
      |i|
        cardArray[:"#{playerName}"] << cardOccured[0]
        cardOccured.delete_at(0)
      end
    end
    puts cardArray.to_s
    card = Card.new cardArray
    card.playCard
  end
end

player = Player.new
player.assignPlayer