class Snake:
    def __init__(self, start, end):
        self.start = start
        self.end = end

class Ladder:
    def __init__(self, start, end):
        self.start = start
        self.end = end

class Ladder:
    def __init__(self, start, end):
        self.start = start
        self.end = end

class Dice:
    dice_count = 1
    @staticmethod
    def roll():
        return random.randint(1 * Dice.dice_count, 6 * Dice.dice_count)

class Player:
    def __init__(self, name):
        self.name = name

class PlayerPosition:
    def __init__(self, player, position):
        self.player = player
        self.position = position

    def update_position(self, new_position):
        self.position = new_position

class Game:
    def __init__(self, board):
        self.board = board
        self.players_position = []

    def add_players(self, player, position=0):
        player_position = PlayerPosition(player, position)
        self.players_position.append(player_position)


    def check_win_condition(self, position):
        if position == self.board.size:
            return True
        return False

    def check_for_snake(self, new_position):
        for snake in self.board.snake_list:
            start, end = snake.start, snake.end
            if start == new_position:
                return end

    def check_for_ladder(self, new_position):
        for ladder in self.board.ladder_list:
            start, end = ladder.start, ladder.end
            if start == new_position:
                return end

    def find_new_position(self, new_position):
        if self.check_for_snake(new_position):
            return self.check_for_snake(new_position)
        elif self.check_for_ladder(new_position):
            return self.check_for_ladder(new_position)
        else:
            return new_position


    def start(self):
        still_playing = len(self.players_position)
        while(still_playing):
            for player_position in self.players_position:
                dice_value = Dice.roll()
                current_position = player_position.position
                new_position = current_position + dice_value

                if new_position < self.board.size:
                    new_position = self.find_new_position(new_position)
                    player_position.update_position(new_position)
                    print(player_position.player.name, 'moved from', current_position, 'to', new_position)

                if self.check_win_condition(new_position):
                    print("player", player_position.player.name, "wins!")
                    player_position.update_position(new_position + 1)
                    still_playing -= 1

class GameRunner:
    @classmethod
    def run_game(cls):
        board = Board()
        s1 = Snake(62, 5)
        s2 = Snake(33, 6)
        s3 = Snake(49, 9)
        s4 = Snake(56, 53)
        s5 = Snake(98, 64)
        s6 = Snake(88, 16)
        s7 = Snake(93, 73)
        s8 = Snake(95, 75)

        l1 = Ladder(2,37)
        l2 = Ladder(27, 46)
        l3 = Ladder(10, 32)
        l4 = Ladder(51, 68)
        l5 = Ladder(61, 79)
        l6 = Ladder(65, 84)
        l7 = Ladder(71, 91)
        l8 = Ladder(81, 100)

        board = Board()
        board.add_ladder(l1)
        board.add_ladder(l2)
        board.add_ladder(l3)
        board.add_ladder(l4)
        board.add_ladder(l5)
        board.add_ladder(l6)
        board.add_ladder(l7)
        board.add_ladder(l8)

        board.add_snake(s1)
        board.add_snake(s2)
        board.add_snake(s3)
        board.add_snake(s4)
        board.add_snake(s5)
        board.add_snake(s6)
        board.add_snake(s7)
        board.add_snake(s8)

        player1 = Player("python")
        player2 = Player("java")
        player3 = Player("go")

        game = Game(board)

        game.add_players(player1)
        game.add_players(player2)
        game.add_players(player3)

        game.start()GameRunner.run_game()
