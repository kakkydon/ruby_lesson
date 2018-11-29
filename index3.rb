# 5章　ハッシュやシンボルを理解する
# ハッシュはキーと値の組み合わせ。いわゆる連想配列
# 空のハッシュを作る
{}
# 国ごとに通貨の単位を格納したハッシュの例
a = { 'japan' => 'yen','us' => 'dollar','india' => 'rupee'}
p a
# 新しくキーと値を追加する場合は、ハッシュ[キー] = 値　※[]であることに注意！。すでにキーが存在した場合は上書きされる
currencies = { 'japan' => 'yen','us' => 'dollar','india' => 'rupee'}
# イタリアの通貨を追加
currencies['italy']='euro'
p currencies

# ハッシュから値を取り出す場合は、ハッシュ[キー]
p currencies['japan']
# 存在しないキーを指定するとnilが返る
p currencies['china']

# ハッシュを使った繰り返し処理
# ブロック引数がキーと値で2個になっている点に注意。引数が1個だと配列に入れないといけない
currencies = { 'japan' => 'yen','us' => 'dollar','india' => 'rupee'}
currencies.each do |key,value|
    puts "#{key} : #{value}"
end

# ハッシュの同値比較 == で比較。すべてのキーと値が同じであればtrue。
a={'x'=>1,'y'=>2,'z'=>3}
# 並び順が異なっていても、すべてのキーと値が同じであればtrue。
b={'y'=>2,'z'=>3,'x'=>1}

p a==b

# sizeメソッドで個数調べる
p b.size

# deleteメソッドで指定したキーの要素を削除。戻り値は削除された要素の値
currencies = { 'japan' => 'yen','us' => 'dollar','india' => 'rupee'}
p currencies.delete('japan')
p currencies

# 指定したキーがなければnilだが、ブロックを渡すと、キーが見つからないときの戻り値をdeleteメソッドの戻り値にできる
currencies = { 'japan' => 'yen','us' => 'dollar','india' => 'rupee'}
p currencies.delete('italy')
# ブロックを渡すと戻り値を作成できる
p currencies.delete('italy'){|key| "not found:#{key}"}

# シンボルとは、文字列と似たようで違う。
# :シンボルの名前
p :apple
p :japan

# シンボルと文字列の違い
# シンボルはSymbolクラスのオブジェクト、文字列はStringクラスのオブジェクト
p :apple.class
p 'apple'.class
# シンボルはRubyの内部で整数として管理されるため、文字列よりも高速に処理できる
# シンボルは同じシンボルであればまったく同じオブジェクト
# またシンボルはイミュータブルなオブジェクトなので、破壊的な変更は不可。static的なやつ
p :apple.object_id
p :apple.object_id
p :apple.object_id
p 'apple'.object_id
p 'apple'.object_id
p 'apple'.object_id

# オブジェクトが持っているメソッド名がシンボルで管理されている
# メソッドの逆引きに便利！
# p 'apple'.methods

# ハッシュのキーにシンボルを使うのが一般的。
currencies = { :japan => 'yen',:us => 'dollar',:india => 'rupee'}
puts currencies
# シンボルがキーになる場合、=>を使わず「シンボル: 値」という記法でハッシュを作成できる。※シンボルと:はくっつけること！
currencies = { japan: 'yen', us: 'dollar', india: 'rupee'}
puts currencies[:us]
# キーも値もシンボルの場合は、次のようになる
{japan: :yen,us: :doller,india: :rupee}

# ハッシュのキーは同じデータ型にそろえる。
# ただ、ハッシュに格納する値に関しては、異なるデータ型が存在する場合がよくある。
person = {
    # 値が文字列
    name: 'Alice',
    # 値が数字
    age:20,
    # 値が配列
    friends: ['Bob','Carol'],
    # 値がハッシュ
    phones: { home: '1234-0000',mobile: '5678-0000'}
}

p person[:age]
p person[:friends]
p person[:phones][:mobile]

# メソッドのキーワード引数とハッシュ
# def メソッド名(キーワード引数1: デフォルト値1,キーワード引数2: デフォルト値2)
def buy_burger(menu,drink: true,potato: true)
    # 省略
end

# 呼び出し側は
buy_burger('cheese',drink:true,potato:true)
# デフォルト値が設定されているので、省略可能
buy_burger('cheese')

# キーワード引数を使うメソッドを呼び出す場合、キーワード引数に一致するハッシュを引数として渡すことができる
params={drink: true,potato: false}
buy_burger('cheese',params)

# ハッシュでよく使うメソッド。keys,values,has_key?
# keysメソッドはハッシュのキーを配列として返す
currencies = {japan: 'yen',us: 'dollar',india: 'rupee'}
p currencies.keys

# valuesメソッドはハッシュの値を配列として返す
p currencies.values

# has_key?/key?/include?/member?
p currencies.has_key?(:japan)
p currencies.has_key?(:italy)

# Enumerable,Hashクラスを確認

# **でハッシュを展開させる。mergeメソッドでも同じ
h={us: 'dollar',india: 'rupee'}
# 変数hのキーと値を**で展開させる
a={japan: 'yen',**h}
p a

# 疑似キーワード引数について、詳細は5.6.3参照

# 任意のキーワードを受け付ける**引数
def buy_burger(menu,drink: true,potato: true,**others)
    # othersはハッシュとして渡される
    puts others
end

p buy_burger('fish',drink: true,potato: false,salad: true,chicken: false)

# メソッド呼び出し時の{}省略
# 最後の引数がハッシュであれば、ハッシュリテラルの{}を省略できる。詳細は5.6.5参照

# ハッシュから配列へ(to_a)、配列からハッシュへ(to_h)
currencies = {japan: 'yen',us: 'dollar',india: 'rupee'}
p currencies.to_a

array=[[:japan, "yen"], [:us, "dollar"], [:india, "rupee"]]
p array.to_h

# ハッシュの初期値について。Hash.newでハッシュを作成し、引数に初期値となる値を指定
# キーがなければ'hello'を返す
h=Hash.new('hello')
p h[:foo]

# newの引数として初期値を指定した場合は、初期値として毎回同じオブジェクトが入る
# そのため、初期値に対して破壊的な変更を適用すると、ほかの変数も一緒にかわってしまう
# 上記問題を避けるためには、Hash.newにブロックを与えると、ブロック引数としてハッシュ自身と見つからなかった
# キーが渡される。下記例
# 初期値を返すだけでなく、ハッシュに指定されたキーと初期値を同時に設定する
h = Hash.new{|hash,key| hash[key] = 'hello'}
p h[:foo]
p h[:bar]
p h

# シンボルの詳細について　5.7参照
# %記法でシンボルやシンボルの配列を作成する。!や()を区切り文字で使う
# シンボルの配列を作成する場合は%i この場合、空白が要素の区切りになる。また改行コード加えたり、式展開したい場合は%I
p %s!ruby is fun!
p %s(ruby is fun)
p %i(ruby is fun)

# 条件分岐や定番の書き方（イディオム）その１
# 条件分岐で変数に代入 / &.演算子。　変数への代入と条件分岐を同時に実現するイディオム

# 国名に応じて通貨を返す（該当する通貨がなければnil）
def find_currency(country)
    currencies={japan: 'yen',us: 'dollar',india: 'rupee'}
    currencies[country]
end

# 指定された国の通貨を大文字にして返す
def show_currency(country)
    currency=find_currency(country)
    # nilでないことをチェック（nilだとupcaseが呼び出せないため）
    if currency
        currency.upcase
    end
end

# 通貨が見つかる場合と見つからない場合の結果を確認
p show_currency(:japan)
p show_currency(:brazil)

# 上をリファクタリング。Rubyでは変数への代入自体が戻り値を持つため、次のようにif文の中で直接変数に代入することも可能
def show_currency(country)
    # 値が取得できれば真、できなければ偽
    if currency = find_currency(currency)
        currency.upcase
    end
end

# &.演算子を使ってメソッドを呼び出すと、メソッドを呼び出されたオブジェクトがnilでない場合はその結果を、nilだった場合はnilを返す
# nil以外のオブジェクトであれば、a.upcaseと書いた場合と同じ
a='foo'
p a&.upcase
a=nil
p a&.upcase

# &.演算子を使ってさらにリファクタリング
def show_currency2(country)
    country = find_currency(country)
    country&.upcase
end

# 通貨が見つかる場合と見つからない場合の結果を確認
p show_currency2(:japan)
p show_currency2(:brazil)

# 条件分岐や定番の書き方（イディオム）その２
# ||=を使った自己代入
# 変数limitがnilまたはfalseであれば、10を代入する（それ以外はlimitの値をそのまま使う）
limit ||= 10

limit = nil
limit ||= 10
p limit

limit = 20
limit ||= 10
p limit

# limit ||= 10は　limit = limit || 10
# 論理演算子の||は式全体の真偽値が確定した時点で式の評価を終了して、その時の戻り値を返す
# つまり、limitが真の場合(falseでもnilでもない)、limitまでで式の評価が終了するのでlimit=limitとなり、
# 代入を実行してもとくに変わりません
# limitが偽（falseまたはnil）であれば、Rubyは||の右辺である10を評価する
# X ||= A　というコードを見たら「変数Xがnilまたfalseなら、AをXに代入」

# 条件分岐や定番の書き方（イディオム）その3
# !!を使った真偽値の型変換
def user_exists?
    # データベースなどからユーザを探す
    user=find_user
    if user
        true
    else
        false
    end
end

# 上記を!!でリファクタリング
def user_exists?
    !!find_user
end
# !は否定の演算子。!Aと書いた場合、Aが真であればfalseを、そうでなければtrueを返す。ここで
# 値がtrueまたはfalseのどちらかに変換。それをもう一度!で反転されると、元のAに対応する真偽値がtrueまたはfalseとして得られる。
p !!true
p !!1
p !!false
p !!nil
# !!がついたら、trueまたはfalseに変換するためだと解釈する