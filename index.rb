### 2章　Rubyの基礎を理解する ###

# ダブルクォートの使い方
# #{}で式展開する
# シングルクォートは式展開しない。
# どっちを使うかは好みだが、規約でシングルクォートのみと縛っているのあり。
name = 'Alice'
puts "Hello,#{name}!"

# オブジェクト.メソッド　で呼び出し。
i = 10
puts "#{i}は16進数にすると#{i.to_s(16)}です"

# ダブルクォートを使う文字列で、改行文字や式展開の機能を打ち消す場合は
name = "Alice"
puts "hello,\#{name}!"

#文字列が同じかどうかは==　違うかどうかは!=。他不等号が使える。
puts 'ruby' == 'ruby'

#数値には_を含めることが可能。_は無視されるので、区切り文字として使用可能
puts 1_000_000_000

#整数同士の割り算は整数になる。小数点以下は切り捨て
puts 1/2
# 小数点以下出すなら、どちらかの値に.0をつける
puts 1/2.0
# to_f は整数を少数に変更することが可能
n = 1
puts n.to_f
puts n.to_f/2
# 変数の値を増減させる。

n=1
# nを1増やす
n += 1
puts n
# nを1減らす
n -= 1
puts n

n=2
# nを3倍にする
n *= 3
puts n
# nを2で割る
n /= 2
puts n
# nを2乗する
n **= 2
puts n

# 数値と文字列は暗黙的に変換されない。to_i や　to_fメソッドを使って明示的に変換する必要あり
# 小数点を扱う際は、まるめ誤差に注意。2進数で内部的に処理するため発生する。詳細はP.30参照

# Rubyの真偽値について
# falseまたはnilであれば偽。それ以外は全て真

# 論理演算子は && ||。!で反転

# if～els end　また、if分は戻り値を返す
country='italy'
greeting =
if country = 'japan'
    'こんにちは'
elsif country = 'us'
    'Hello'
elsif country = 'italy'
    'ciao'
else
    '???'
end

puts greeting

# ifの後置if　上は普通の使い方、下は後置if
point = 7
day = 1
# 1日であればポイント5倍
if day = 1
    point *= 5
end
puts point

point = 7
day = 1
# 1日であればポイント5倍(if修飾子を利用)
point *= 5 if day == 1
puts point

# メソッドの定義はdef～endを使う。メソッド名も小文字のスネークケース
# 戻り値に関する情報はメソッド定義に出てこない
# rubyは最後に評価された式がメソッドの戻り値になるのが特徴
def add(a,b)
    a+b
end
puts add(1,2)

# returnも使えるが、使う場面としては途中で脱出する場合のみ
def greeting(country)
    # countryがnilならメッセージを返してメソッドを抜ける
    # (nil?はオブジェクトがnilの場合にtrueを返すメソッド
    return 'countryを入力してください' if country.nil?

    if country == 'japan'
        'こんにちは'
    else
        'Hello'
    end
end

puts greeting(nil)
puts greeting('japan')

# 引数のないメソッドは（）ごと省略して定義できる。 
def greeting
    'こんにちは'
end
puts greeting

# 文字列はStringクラスのオブジェクト
puts 'abc'.class

# ヒアドキュメント。<<識別子～識別子　識別子は自由につけれる
a = <<TEXT
これはヒアドキュメントです。
複数行にわたる長い文字列を作成するのに
便利です。
TEXT
puts a

# ヒアドキュメントの中では式展開が有効
name = 'Alice'
a = <<TEXT
これは#{name}です。
複数行にわたる長い文字列を作成するのに
便利です。
TEXT
puts a

# 開始ラベルの<<識別子は1つの式と見なされる
# ヒアドキュメントを直接引数として渡す（prependは渡された文字列を先頭に追加するメソッド）
a='Ruby'
a.prepend(<<TEXT)
Java
PHP
TEXT
puts a

# フォーマットを指定して文字列を作成する。複数渡すことも可能
# フォーマット文字列の指定方法は　公式ドキュメント参照すること
puts sprintf('%0.3f + %0.3f',1.2,0.48)

# 文字列作成いろいろ
puts [10,20,30].join
puts 'Hi'*10

# 10進数以外の整数リテラル 2進数は[0b],8進数は[0],16進数は[0x]を先頭につけると、整数値を作成できる
puts 0b11111111
puts 0377
puts 0xff 

# &&や||の戻り値と評価を終了するタイミング
puts 1 && 2 && 3
puts 1&& nil && 3
puts false && 3
puts nil || false
puts false || nil
puts nil || false || 2 || 3

# 正常なユーザであればメールを送信する
#user.valid? && send_email_to(user)

# and or not は&& ||よりも優先度低い
# orは「Aが真か？真でなければBせよ」
def greeting(country)
    # countryがnil(またはfalse)ならメッセージを返して入力
    country or return
    if country == 'japan'
        'こんにちは'
    else
        'hello'
    end
end

puts greeting(nil)
puts greeting('japan')

# if+否定条件は、unlessに置き換えれる。

# case文 when節は複数の値を指定可能。また、if文と同様結果を戻り値として返すため、変数に入れることも可能。thenも使える。
country = 'italy'
case country
when 'japan','日本'
    'こんにちは'
when 'us','アメリカ'
    'hello'
when 'italy','イタリア'
    'ciao'
else
    '???'
end

puts country

# 条件演算子（三項演算子）使える。
# 式 ? 真だった場合の処理 : 偽だった場合の処理。返り値を変数に入れることもできる
n=11
puts n>10 ? '10より大きい' : '10以下'

# メソッド定義について。引数の過不足はエラーだが、デフォルト値を付けると引数なしでも呼べる
def greeting(country='japan')
    # if country == 'japan'
    #     'こんにちは'
    # else
    #     'hello'
    # end

    country == 'japan' ? 'こんにちは' : 'hello'
end

puts greeting
puts greeting('us')

# デフォルト値は固定の値だけでなく、動的に変わる値や、ほかのメソッドの戻り値を指定したりできる
def foo(time=Time.now,message = bar)
    puts "time:#{time},message:#{message}"
end

def bar
    'BAR'
end

puts foo

# ?で終わるメソッド。Rubyのメソッドは?で終わらせることができる。?で終わるメソッドは慣習として真偽値を返すメソッド。
# 空文字列であればtrue,そうでなければfalse
puts ''.empty?
puts 'abc'.empty?

# 引数の文字列が含まれていればtrue,そうでなければfalse
puts 'watch'.include?('at')
puts 'watch'.include?('in')

# 奇数ならtrue,偶数ならfalse
puts 1.odd?
puts 2.odd?

# 偶数ならtrue,奇数ならfalse
puts 1.even?
puts 2.even?

# オブジェクトがnilであればtrue,そうでなければfalse
puts nil.nil?
puts 'abc'.nil?

# 自分で定義
def multiple_of_three?(n)
    n % 3 == 0
end

puts multiple_of_three?(4)
puts multiple_of_three?(5)
puts multiple_of_three?(6)

# !で終わるメソッドは慣習として「使用する際は注意が必要」。
a='ruby'
# upcaseだとaの値は変化しない
puts a.upcase
puts a
# upcase!だとaの値は変化する
puts a.upcase!
puts a

# upcase!のように呼び出したオブジェクトの状態を変更してしまうメソッドを破壊的メソッドと呼ぶ。C#でいう参照呼出しか。

# エイリアスメソッド。まったく同じ実装で複数の名前がついている。lengthメソッド、sizeメソッドとか

# 文のように見えるが実は式がrubyには多い。if文とか。戻り値を活用できる。

# 擬似変数 nil,false,trueの他には
# self:オブジェクト自身
# __FILE__:現在のソースファイル名
# __LINE__:現在のソースファイルの行番号
#:__ENCODING__:現在のソースファイルのスクリプトエンコーディング
puts __FILE__ 

# rubyの変数はオブジェクトそのものではなく、オブジェクトへの参照が格納されている
# どちらも同じ文字列だが、オブジェクトとしては別物
# 同じか異なるのかオブジェクトの意識は重要
a='hello'
b='hello'
puts a.object_id
puts b.object_id
# cにbを代入する。どちらも同じオブジェクト
c=b
puts c.object_id

# 標準ライブラリやgemを利用する場合は、明示的にライブラリを読み込む必要あり
require 'date'
puts Date.today

# 自分で作成したクラスを読み込む際も必要。rbは省略可。./は実行ディレクトリを示し、/はルートディレクトリを示す。相対パス or 絶対パスで記述
# requireを使うと、Rubyを実行しているディレクトリがパスの起点になる。
require　'./sample.rb'
# requireは1回のみしか読み込まない。毎回読ませるにはloadを使う。自分のクラスを呼ぶときはloadがいいかも？
load './sample.rb'
# 相対参照はrequire_relative
require_relative '../bar/bye'
# puts,print,pメソッドの違い
# putsは改行を加えて、戻り値を出力。メソッド自身の戻り値はnil
# printはputsの改行されない版。
# pは改行を加えて出力するが、文字列を出力するとダブルクォートで囲まれている。またメソッド自身の戻り値は渡されたオブジェクトそのもの
##