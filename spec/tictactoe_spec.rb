require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  game = Game.new
  describe '#Valid input' do
    it 'Check if a1 is valid input' do
      expect(game.input_valid?('a1')).to eql(true)
    end
    it 'Check if 2c is valid input' do
      expect(game.input_valid?('2c')).to eql(true)
    end
    it 'Check if a22 is valid input' do
      expect(game.input_valid?('a22')).to eql(false)
    end
  end
  describe '#Winning possibilities set' do
    it 'Check if all set are empty' do
      expect(game.winning_possibilities).to eql([[' ', ' ', ' '],
                                                 [' ', ' ', ' '],
                                                 [' ', ' ', ' '],
                                                 [' ', ' ', ' '],
                                                 [' ', ' ', ' '],
                                                 [' ', ' ', ' '],
                                                 [' ', ' ', ' '],
                                                 [' ', ' ', ' ']])
    end
    it 'Check if the sets contain b1' do
      game.current_player = Player.new('1', 'o')
      game.first_d = nil
      game.second_d = nil
      game.update_d('b1')
      game.play_move
      expect(game.winning_possibilities).to eql([[' ', ' ', ' '],
                                                 ['o', ' ', ' '],
                                                 [' ', ' ', ' '],
                                                 [' ', 'o', ' '],
                                                 [' ', ' ', ' '],
                                                 [' ', ' ', ' '],
                                                 [' ', ' ', ' '],
                                                 [' ', ' ', ' ']])
    end
  end
  describe '#Update array first and second dimensions' do
    it 'Update b2' do
      game.current_player = Player.new('1', 'o')
      game.first_d = nil
      game.second_d = nil
      game.update_d('b2')
      game.play_move
      expect(game.play[1][1]).to eql('o')
    end
  end
  describe '#Valid move' do
    it 'Check if a1 is a valid move' do
      game.first_d = nil
      game.second_d = nil
      game.update_d('a1')
      expect(game.move_valid?).to eql(true)
    end
    it 'Check if ab is a valid move' do
      game.first_d = nil
      game.second_d = nil
      game.update_d('ab')
      expect(game.move_valid?).to eql(false)
    end
    it 'Check if d3 is a valid move' do
      game.first_d = nil
      game.second_d = nil
      game.update_d('d3')
      expect(game.move_valid?).to eql(false)
    end
  end
  describe '#Play move' do
    it 'Play move c2' do
      game.current_player = Player.new('1', 'o')
      game.first_d = nil
      game.second_d = nil
      game.update_d('c2')
      game.play_move
      expect(game.play[2][1]).to eql('o')
      expect(game.move_num).to eql(4)
    end
  end
  describe '#Filled square' do
    it 'Check if a1 is filled upon having it present' do
      game.current_player = Player.new('1', 'x')
      game.update_d('a1')
      game.play_move
      expect(game.square_empty?).to eql(false)
    end
    it 'Check if a1 is filled upon not having it present' do
      game.current_player = Player.new('1', 'x')
      game.update_d('a2')
      game.play_move
      game.update_d('a3')
      expect(game.square_empty?).to eql(true)
    end
  end
  describe '#Game won' do
    it 'Check if Game is won without a3 filled' do
      game.current_player = Player.new('1', 'x')
      expect(game.game_won?).to eql(false)
    end
    it 'Check if Game is won with a3 filled' do
      game.current_player = Player.new('1', 'x')
      game.update_d('a3')
      game.play_move
      expect(game.game_won?).to eql(true)
    end
  end
end

describe Player do
  player = Player.new('John', 'x')
  describe '#Player' do
    it 'Creates Player John with symbol x' do
      expect(player.name).to eql('John')
    end
    it 'Creates Player John with symbol x' do
      expect(player.symbol).to eql('x')
    end
  end
end
