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
# select/find_all
# reject
# find/detect
# inject/reduce
# map/collectメソッドについて。各要素に対してブロックを評価した結果を新しい配列にして返す。
numbers=[1,2,3,4,5]
new_numbers=numbers.map{|n| n*10}
print new_numbers