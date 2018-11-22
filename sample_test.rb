# Minitestを使ったテストの自動化。Railsのデフォルトテスティングフレームワーク
# １．テスティングフレームワークのルールに沿って、プログラムの実行結果を検証するRubyプログラム（テストコード）を書く
# ２．１．で作ったテストコードを実行する
# テスティングフレームワークが実行結果をチェックし、その結果が正しいか間違っているかを報告する
require 'minitest/autorun'

# テストコードのクラス名はTestで始まるかTestで終わるかで命名していることが多い。JapaneseCalenderTest
# テストコードが書かれたファイルのファイル名はjapanese_calender_test.rb　的な。
# Minitestはtest_で始まるメソッドを探して、それを全て実行する。なので、メソッド名をtest_で始めることは必須
# Minitestが提供するassert_equalメソッドを使って、実行結果の比較を行う。
# assert_equal 期待する結果,テスト対象となる値や式
# failureはテスト失敗、errorはテストそのものがエラー。
class SampleTest < Minitest::Test
    # def test_sample
    #     assert_equal 'RUBY','ruby'.upcase
    # end
     def test_sample
         assert_equal 'RUBY','ruby'.capitalize
     end

end

# Minitestで使う主な検証メソッド
# aがbと等しければパスする
# assert_equal b,a
# aが真であればパスする
# assert a
# aが偽であればパスする
# refute a