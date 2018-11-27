# 4章　配列や繰り返し処理を理解する
# 配列はArrayクラスのオブジェクト
puts [].class
# 配列への代入
a=[1,2,3]
# 配列の中に配列
a=[[1,2,3],[4,5,6],[7,8,9]]
# 配列の取得 0始まり。存在しない要素を指定してもエラーではなく、nilが返る
a=[1,2,3]
puts a[0]
puts a[1]
puts a[100]
# 配列の長さはsize
puts a.size

# 配列の値上書き
a=[1,2,3]
a[1]=20
puts a

# 元の大きさよりも大きい添え字を指定する場合、間の値がnilで埋められる
a[10] = 5
print a
# <<を使うと配列の最後に要素を追加することも可能
a=[]
a << 1
a << 2
a << 3
p a
# 配列の特定の位置にある要素を削除したい場合。delete_at
a=[1,2,3]
a.delete_at(1)
p a
# 存在しない添え字を指定すると、nilが返るエラーにはならない。

# 配列を使った多重代入
# 通常
a,b=1,2
# 配列
a,b=[1,2]
# 配列で受け取るようりも多重代入を使って最初から別々の変数に入力
# divmodは省都余りを配列で返す
14.divmod(3)
# 戻り値を配列のまま受け取る
quo_rem = 14.divmod(3)
puts "商=#{quo_rem[0]},余り=#{quo_rem[1]}"
# 多重代入で別々の変数として受け取る
quotient,remainder = 14.divmod(3)
puts "商=#{quotient},余り=#{remainder}"

# ブロック。Rubyの繰り返し処理について
# 配列の繰り返し処理を実行して、ループ処理を実現している。
# 配列の要素を順番に取り出す作業はezchメソッド
# その要素をどう扱うかはブロックに記述
# 下の例だと、do～endまでがブロック
# nはブロック変数と呼ばれ、eachメソッドから渡された配列の要素が入る
# ブロック変数は何でもよい
numbers=[1,2,3,4]
sum=0
numbers.each do |n|
    sum += n
end
puts sum

# delete_ifメソッドを使った例。deleteメソッドだと完全に位置する要素しか削除できない。
# delete_ifメソッドもezchメソッドと同じように、配列の要素を順番に取り出します。
# delete_ifメソッドはブロックの戻り値が真であれば、その要素を配列から削除する。
a=[1,2,3,1,2,3]
# 配列から値が奇数の要素を削除する
a.delete_if do |n|
    n.odd?
end
print a

# Rubyでは「要件を問わず共通する処理」はメソッド自身に、「要件によって異なる処理」はブロックのそれぞれ分担
# させて、1つの処理を完了させるメソッドが多く用意
numbers = [1,2,3,4]
sum=0
numbers.each do |n|
    # sum_valueはブロック内で初めて登場した変数なので、ブロック内でのみ有効
    sum_value = n.even? ? n * 10 : n
    sum += sum_value
end
puts sum

# do...endの代わりに{}を使うことも可能。長いブロックはdo...end、1行は{}でかく場合は多い
numbers = [1,2,3,4]
sum=0
numbers.each {|n| sum += n}
puts sum

# ブロックを使う配列のメソッド(よく使われる)
# each
# map/collect
# select/find_all/reject
# find/detect
# inject/reduce
# map/collectメソッドについて。各要素に対してブロックを評価した結果を新しい配列にして返す。
numbers=[1,2,3,4,5]
new_numbers=numbers.map{|n| n*10}
print new_numbers

# select/find_all
numbers=[1,2,3,4,5]
# ブロックの戻り値が真の要素を集めた配列を返すメソッド
new_numbers=numbers.select{|n| n.even?}
print new_numbers

# rejectはselectの反対。戻り値が偽である要素を集めるメソッド
numbers=[1,2,3,4,5]
# ブロックの戻り値が真の要素を集めた配列を返すメソッド
new_numbers=numbers.reject{|n| n.even?}
print new_numbers

# find/detectはブロックの戻り値が真になった最初の要素を返す
numbers=[1,2,3,4,5]
new_numbers=numbers.find{|n| n==2}
print new_numbers

# inject/reduceはたたみ込み演算を行うメソッド
numbers=[1,2,3,4]
sum=0
numbers.each{|n| sum+=n}
puts sum
# 上記と同じ内容
numbers=[1,2,3,4]
sum=numbers.inject(0){|result,n| result + n}
puts sum
# ↑で起こっていること
# 1回目：result=0,n=1で、0+1=1。これが次のresultに入る
# 2回目：result=1,n=2で、1+2=3。これが次のresultに入る。以下続く・・・

# 範囲オブジェクトについて。
# 最初の値..最後の値（最後の値を含む）
# 最初の値...最後の値（最後の値を含まない）
1..5
1...5
'a'..'e'
'a'...'e'
puts (1..5).class

# ..を使うと5が範囲に含まれる
range=1..5
puts range.include?(5)
# ...を使うと5が範囲に含まれない
range=1...5
puts range.include?(5)

# 範囲オブジェクトの使い方
a=[1,2,3,4,5]
# 2番目から4番目の要素を取得
print a[1..3]
# 文字列に対しても同じ使い方ができる
a='abcdef'
# 2番目から4番目の要素を取得
print a[1..3]

# n以上m以下の判定を行う場合、不等号の判定よりもシンプルに書ける
# 不等号を使う場合
def liquid?(temperature)
    # 0度以上100度未満であれば液体と判定したい
    0 <= temperature && temperature < 100 
end
puts liquid?(95)

# 範囲オブジェクトを使う場合
def liquid?(temperature)
    (0...100).include?(temperature)
end
puts liquid?(100)

# 範囲オブジェクトはcase文でも使える
def charge(age)
    case age
        # 0歳から5歳
    when 0..5
        0
        # 6歳から12歳
    when 6..12
        300
    else
        1000
    end
end
puts charge(99)

# 配列についてもっと詳しく
# 添え字を２つ使うと、添え字の位置と取得する長さを指定することができる。この場合、配列が返ってくる。配列[位置,取得する長さ]
a=[1,2,3,4,5]
print a[1,3]
# values_atメソッドを使うと、取得したい要素の添え字を複数指定できる
a=[1,2,3,4,5]
print a.values_at(0,2,4)
# 添え字に負の値が使える
a=[1,2,3]
# 最後の要素を取得する
puts a[-1]
# 最後から2番目の要素から2つの要素を取得する
print a[-2,2]
# lastメソッドは配列の最後の要素を取得する。引数に0以上の数値を渡すと、最後のn個の要素を取得する
a=[1,2,3]
print a.last
print a.last(2)
# firstメソッドは配列の最初の要素を取得する。引数に0以上の数値を渡すと、最初のn個の要素を取得する
a=[1,2,3]
print a.first
print a.first(2)

# 要素の変更方法
# 値を変更する場合も負の添え字が使える。ただ、正の値を使う場合と異なり、元の大きさを超えるとエラー
a=[1,2,3]
a[-3]=-10
p a

# 開始位置と長さを指定して要素を置き換える
a=[1,2,3]
a[1,3]=100
p a

# <<だけでなく、pushメソッドを使っても要素を追加できる
a=[]
a.push(2,3)
p a

# 指定した値に一致する要素を削除したい場合はdeleteメソッド
a=[1,2,3,1,2,3]
# 値が2である要素を削除する
a.delete(2)
p a
# 存在しない値を指定するとnilが返る
a.delete(5)
p a

# 配列の連結は +。concatメソッドでも連結できるか破壊的メソッドなのであまり使わない
a,b=[1],[2,3]
p a+b

# 配列は|,-,&を使って、和集合、差集合、積集合を求めることができる
# |は和集合。2つの配列の要素を集め、重複しないようにして返す
# -は差集合。左の配列から右の配列に含まれる要素を取り除く
# &は積集合。2つの配列に共通する要素を返す
# いずれも元の配列は変更しない。
# Rubyには配列よりも効率的に集合を扱えるSetクラスもある
a=[1,2,3]
b=[3,4,5]
p a|b
p a-b
p a&b

# 左辺の変数に*をつけると、はみ出した値が切り捨てられずに配列として受け取れる
e,*f=100,200,300
p e
p f

# メソッドの引数に配列を渡すとき、「1つの配列」ではなく配列を展開して「複数の引数」として渡したい場合は、配列の前に*を置く
a=[]
b=[2,3]
a.push(1)
p a.push(*b)

# 個数に制限のない引数のことを可変長引数。自分で定義するメソッドで可変長引数を使う場合は、引数名の手前に*
# 可変長引数は配列として受け取れる
# def メソッド名(引数1,引数2,*可変長引数)
#     # 処理
# end
def greeting(*names)
    "#{names.join('と')}、こんにちは！"
end
puts greeting('田中さん','鈴木さん')

# []の中に*付きで別の配列を置くと、その配列が展開されて別々の要素になる
a=[1,2,3]
p [-1,0,*a,4,5]

# ==で等しい配列かどうかを判断
p [1,2,3] == [1,2,3]
p [1,2,3] == [3,2,1]

# %記法で文字列の配列を簡潔に作る
# %Wで文字列の配列を作成する（!で囲む場合）
p %w!apple melon orange!
# %Wで文字列の配列を作成する（丸かっこで囲む場合）
p %w(apple melon orange)
# 値にスペースを含めたい場合はバックスラッシュでエスケープ
p %w(big\ apple small\ melon orange)
# 式展開や改行文字(/n)、タブ文字(/t)などを含める場合は、%Wを使う

# 文字列を分解して配列に変換する charsメソッドとsplitメソッド
p 'Ruby'.chars
p 'Ruby,Java,Perl,PHP'.split(',')

# 配列に初期値を設定する
# a=[]と同じ
a=Array.new
# 要素が5つの配列を作成する。初期値も設定できる
p a=Array.new(5)
p a=Array.new(5,1)
# Array.newではブロックを使って初期値を設定
# 要素数が10で、1,2,3,1,2,3...と繰り返す配列を作る
a=Array.new(10){|n| n % 3 + 1}
p a
# 配列に初期値を設定する場合の注意点。どれも同じオブジェクトなので、他の要素も一緒に変更されてしまう

# ブロックに関して詳しく
# 添え字付きの繰り返し処理
# ブロック引数のiには0,1,2...と要素の添え字が入る
fruits=['apple','orange','melon']
fruits.each_with_index{|fruit,i| puts "#{i}: #{fruit}"}
# mapメソッドとの組み合わせ
# mapとして処理しつつ、添え字も受け取る
fruits=['apple','orange','melon']
fruits.map.with_index{|fruit,i| puts "#{i}: #{fruit}"}
# delete_ifとの組み合わせ
# 名前に"a"を含み、なおかつ添え字が奇数である要素を削除する
fruits=['apple','orange','melon']
p fruits.delete_if.with_index{|fruit,i| fruit.include?('a') && i.odd?}
# 添え字を0以外から開始させる場合は、with_indexメソッドに引数を渡すだけ。

# 配列がブロック引数に渡される場合
# 配列の配列に対して繰り返し処理を実行すると、ブロック引数に配列が渡ってくる
dimensions=[[10,20],[30,40],[50,60]]
# 面積の計算結果を格納する配列
areas = []
# 配列の要素分だけブロック引数を用意すると、それぞれ引数に受け取れるので簡潔に書ける
dimensions.each do |length,width|
    areas << length * width
end
p areas
# each_with_indexのように、もとからブロック引数を２つ受け取る場合は
dimensions=[[10,20],[30,40],[50,60]]
# ブロック引数を()で囲んで、配列の要素を別々の引数として受け取る
dimensions.each_with_index do |(length,width),i|
p "length:#{length},width:#{width},i:#{i}"
end
# ブロックローカル変数　あんま使わないかな。4.8.5参照

# 繰り返し処理以外でも使用されるブロック。9.6.2で詳細参照

# do...end と {}の結合度の違い。 4.8.7で詳細参照
# 引数付きのメソッド呼び出しで{}をブロックとして使う場合は、メソッド引数の()を省略できない