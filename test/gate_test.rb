require 'minitest/autorun'
require './lib/gate'
require './lib/ticket'
# 例題
# シナリオ1（1区間）
# 150円の切符を購入する
# 梅田で入場し、十三で出場する
# 期待する結果：出場できる
# シナリオ2（2区間・運賃不足）
# 150円の切符を購入する
# 梅田で入場し、三国で出場する
# 期待する結果：出場できない
# シナリオ3（2区間・運賃ちょうど）
# 190円の切符を購入する
# 梅田で入場し、三国で出場する
# 期待する結果：出場できる
# シナリオ4（梅田以外の駅から乗車する）
# 150円の切符を購入する
# 十三で入場し、三国で出場する
# 期待する結果：出場できる

class GateTest < Minitest::Test
    # Minitestではsetupメソッドを定義すると、テストメソッドの実行前に毎回setupメソッドが呼び出される
    def setup
        @umeda = Gate.new(:umeda)
        @juso = Gate.new(:juso)
        @mikuni = Gate.new(:mikuni)
    end
    # シナリオ1（1区間）
    # 150円の切符を購入する
    # 梅田で入場し、十三で出場する
    # 期待する結果：出場できる
    def test_umeda_to_juso
        ticket = Ticket.new(150)
        @umeda.enter(ticket)
        # assert(boolean, message=nil)で、booleanがtrueと評価されればテスト成功
        assert @juso.exit(ticket)
    end

    # シナリオ2（2区間・運賃不足）
    # 150円の切符を購入する
    # 梅田で入場し、三国で出場する
    # 期待する結果：出場できない
    def test_umeda_to_mikuni_when_fare_is_not_enough
        ticket = Ticket.new(150)
        @umeda.enter(ticket)
        refute @mikuni.exit(ticket)
    end

    def test_umeda_to_mikuni_when_fare_is_enough
        ticket = Ticket.new(190)
        @umeda.enter(ticket)
        assert @mikuni.exit(ticket)
    end

    def test_juso_to_mikuni
        ticket = Ticket.new(150)
        @juso.enter(ticket)
        assert @mikuni.exit(ticket)
    end
end
