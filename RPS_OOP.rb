ROCK_TYPE = 1;
PAPER_TYPE = 2;
SCISSORS_TYPE = 3;

# 宣告一個戰鬥類別，此類別人用控制戰鬥流程
class Battle
	# 類別變數，產生三個基本拳種物件
    @@Elements = Array.new(3) #{Element.new(ROCK_TYPE, SCISSORS_TYPE, PAPER_TYPE), Element,new(PAPER_TYPE, ROCK_TYPE, SCISSORS_TYPE), Element.new(SCISSORS_TYPE, PAPER_TYPE, ROCK_TYPE)}

    def initialize
    	@@Elements[0] = Element.new(ROCK_TYPE, SCISSORS_TYPE, PAPER_TYPE)
    	@@Elements[1] = Element.new(PAPER_TYPE, ROCK_TYPE, SCISSORS_TYPE)
    	@@Elements[2] = Element.new(SCISSORS_TYPE, PAPER_TYPE, ROCK_TYPE)
    	# 玩家
        @mPlayer = Human.new
        # 電腦
        @mComputer = Computer.new
    end

    def Play
    	begin
    	    _PlayerElement = @mPlayer.Play
    	    _ComputerElement = @mComputer.Play

    	    Result(_PlayerElement, _ComputerElement)
    	    
    	    puts "按任意鍵繼續，按下Ｑ離開"		
    	    _input = gets.chomp;
        end while _input != "Q" && _input != "q"
    end

    def Result(iPlayer1, iPlayer2)
    	_result = iPlayer1.Compare(iPlayer2)
    	if _result == 0
    		puts "平手"
        elsif _result == 1
   	    	puts "你贏了"
   	    elsif _result == -1
   	    	puts "你輸了"
   	    end
    end

    # 取得拳種物件
    def self.getElement(iElement)
    	# 判斷範圍，避免陣列溢位
        if (iElement < ROCK_TYPE) || (iElement > SCISSORS_TYPE)
            return null
        end

        return @@Elements[iElement - 1]
    end 
end

# 玩家基本類別
class Player
    def initialize
    end

    def Play
    end
end

# 人類玩家類別，繼承於Player
class Human < Player
    def Play
        _input = 0
        # 讀取玩家輸入的選項
        begin
            puts "請選擇你要出的拳，1. 剪刀，2. 石頭，3. 布"
            _input = gets.chomp.to_i
        end until (_input == ROCK_TYPE) || (_input == PAPER_TYPE) || (_input == SCISSORS_TYPE)
        return Battle.getElement(_input)
    end
end

# 電腦玩家類別，繼承於Player
class Computer < Player
    def Play
    	# 隨機一個1~3的整數，用來表示電腦出的拳
        _r = rand(1..3)
        return Battle.getElement(_r)
    end
end

# 宣告猜拳的元素，也就是剪刀，石頭，布
class Element
    attr_accessor :mType

    def initialize(iType, iWin, iLose)
    	# 猜拳型態
        @mType = iType
        # 贏哪一個拳
        @mWin = iWin
        # 書哪一個拳
        @mLose = iLose
    end

    # 比較猜拳結果
    def Compare(iElement)
        if iElement.mType == self.mType
            return 0
        elsif iElement.mType == @mWin
            return 1
        elsif iElement.mType == @mLose
            return -1
        end     
    end
end

_RPS = Battle.new
_RPS.Play