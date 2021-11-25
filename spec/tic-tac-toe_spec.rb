# frozen_string_literal: true

require_relative '../lib/board_class.rb'

describe CREATE_BOARD do
  describe '#check_square' do
    subject {described_class.new}
    context 'player chooses a valid square' do
      it 'returns true' do
        square_num = 7
        expect(subject.check_square(square_num)).to be true
      end
    end
    context 'player chooses an incorrect square' do
      it 'returns false' do
        square_num = 10
        expect(subject.check_square(square_num)).to be false
      end
    end
  end
  describe '#commit_move' do
    subject {described_class.new}
    context 'player chooses a wrong square once and then a correct square' do
      before do
        allow(subject).to receive(:get_player_input).and_return(5)
      end
      it 'prompts the user to input again' do
        player_input = 1343
        expect(subject).to receive(:bad_input).once
        subject.commit_move('X', player_input)
      end
    end
  end
  describe '#check_for_win' do
    let(:no_win_board) {Array.new(3){|index| Array.new(3){index+=1}}}
    let(:horizontal_win){[Array.new(3), Array.new(3){'x'}, Array.new(3)]}
    let(:vertical_win){[['x',2,3],['x',5,6],['x',8,9]]}
    let(:cross_win){[['x',2,3],[4,'x',6],[7,8,'x']]}
    subject{described_class.new}
    context 'no win condition' do
      it 'returns false' do
      subject.instance_variable_set(:@board, no_win_board)
      expect(subject.check_for_win).to be false
      end
    end
    context 'there is a win condition' do
      context 'there is a horizontally alligned array of symbols' do
        it 'returns true' do
          subject.instance_variable_set(:@board, horizontal_win)
          expect(subject.check_for_win).to be true
        end
      end
      context 'there is a vertically alligned array of symbols' do
        it 'returns true' do
          subject.instance_variable_set(:@board, vertical_win)
          expect(subject.check_for_win).to be true
        end
      end
      context 'there is a diagonally alligned array of symbols' do
        it 'returns true' do
          subject.instance_variable_set(:@board, cross_win)
          expect(subject.check_for_win).to be true
        end
      end
    end
  end 
end
