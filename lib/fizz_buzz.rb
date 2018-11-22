# fizz_buzzメソッド
# 3で割り切れる数値を引数に渡すと、"Fizz"を返す
# 5で割り切れる数値を引数に渡すと、"Buzz"を返す
# 15で割り切れる数値を引数に渡すと、"Fizz Buzz"を返す
# それ以外の数値はその数値を文字列に変えて返す

def fizz_buzz(atai)
    if atai % 3 == 0 && atai % 5 == 0
        'Fizz Buzz'
    elsif atai % 3 == 0
        'Fizz'
    elsif atai % 5 == 0
        'Buzz'
    else atai.to_s
    end
end

require 'minitest/autorun'

class FizzBuzzTest < Minitest::Test
    def test_fizz_buzz
        assert_equal '1',fizz_buzz(1)
        assert_equal '2',fizz_buzz(2)
        assert_equal 'Fizz',fizz_buzz(3)
        assert_equal '4',fizz_buzz(4)
        assert_equal 'Buzz',fizz_buzz(5)
        assert_equal 'Fizz',fizz_buzz(6)
        assert_equal 'Fizz Buzz',fizz_buzz(15)
    end
end

