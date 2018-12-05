# 7章クラスの作成を理解する

# Userクラスを定義する
class User
    attr_reader :first_name, :last_name, :age

    def initialize(first_name,last_name,age)
        @first_name = first_name
        @last_name = last_name
        @age = age
    end

    # 氏名を作成するメソッド
    def full_name
        "#{@first_name} #{@last_name}"
    end

end

# ユーザのデータを作成する
users=[]
users << User.new('Alice','Ruby',20)
users << User.new('Bob','Python',30)

# ユーザのデータを表示する
users.each do |user|
    puts "氏名：#{user.full_name}、年齢：#{user.age}"
end

# クラス名は必ず大文字から始めて。キャメルケース
class OrderItem
end
# クラスからオブジェクトを作成する場合は new
# この時に呼ばれるのがinitializeメソッド。=コンストラクタ
# User.new

# クラス構文の内部でメソッドを定義すると、そのメソッドはインスタンスメソッドになる
class User2
    # インスタンスメソッドの定義
    def hello
        "Hello!"
    end
end

user=User2.new
# インスタンスメソッドの呼び出し
p user.hello

# クラス内部ではインスタンス変数を使うことができる。
# インスタンス変数とは同じインスタンスの内部で共有される変数。インスタンス変数の変数名は必ず@で始める
class User3
    def initialize(name)
        # インスタンス作成時に渡された名前をインスタンス変数に保存する
        @name = name
    end

    def hello
        # インスタンス変数に保存されている名前を表示する
        "Hello,I am #{@name}."
    end
end

user=User3.new('Alice')
p user.hello

# メソッドやブロックの内部で作成される変数のことをローカル変数と呼ぶ
# メソッドやブロックが呼び出されるたびに毎回作り直される
# ローカル変数は参照する前に必ず=で値を代入する
class User4
    def initialize(name)
        @name = name
    end

    def hello
        # shuffled_nameはローカル変数
        shuffled_name=@name.chars.shuffle.join
        "Hello,I am #{shuffled_name}."
    end
end

user=User4.new('Alice')
p user.hello

# インスタンス変数はクラスの外部から参照することができない。もし参照したい場合は参照用のメソッドを
# 作る必要がある
class User5
    def initialize(name)
        @name = name
    end

    # @nameを外部から参照するためのメソッド
    def name
        @name
    end
    # @nameを外部から変更するためのメソッド
    def name=(value)
        @name=value
    end
end
user=User5.new('Alice')
# 変数に代入しているように見えるが、実際はname=メソッドを呼び出している
user.name = 'Bob'
p user.name

# 上記のようにインスタンス変数の値を読み書きするメソッドのことを「アクセサメソッド」と呼ぶ
# Rubyでは、attr_accessorというメソッドで定義を省略できる
# 読み取り専用にしたい場合は、attr_accessorの代わりにattr_readerを呼ぶ
class User6
    # @nameを読み書きするメソッドが自動的に定義される
    attr_accessor :name
    def initialize(name)
        @name = name
    end
end

user=User6.new('Alice')
# @nameを変更する
user.name = 'Bob'
# @nameを参照する
p user.name

# カンマで複数の引数を渡すと、複数のインスタンス変数に対するアクセサメソッドを作成することもできる
class User7
    # @nameと@ageへのアクセサメソッドを定義する
    attr_accessor :name, :age
    def initialize(name,age)
        @name = name
        @age = age
    end
end

user=User7.new('Alice',20)
p user.name
p user.age

# クラスメソッドの定義
# クラスに関連は深いが、インスタンスに含まれるデータは使わない場合に定義する
# class クラス名
#  def self.クラスメソッド
#   # クラスメソッドの処理
#  end
# end
class User8
    def initialize(name)
        @name = name
    end

    # self.を付けるとクラスメソッドになる
    def self.create_users(names)
        names.map do |name|
            User8.new(name)
        end
    end

    # これはインスタンスメソッド
    def hello
        "Hello,I am #{@name}"
    end
end

names=['Alice','Bob','Carol']
# クラスメソッドの呼び出し
users = User8.create_users(names)
users.each do |user|
    # インスタンスメソッドの呼び出し
    puts user.hello
end

# メソッド名の表記法について
# インスタンスメソッドを表す場合は「クラス名#メソッド名」と表記する
# クラスメソッド（特異メソッド）を表す場合は「クラス名.メソッド名(またはクラス名::メソッド名)」と表記する

# 定数の定義について
# 大文字表記で、大文字と数字、それにアンダースコアで構成されるのが一般的
class Product
    # デフォルトの価格を定数として定義する
    DEFAULT_PRICE = 0

    attr_reader :name, :price

    def initialize(name,price=DEFAULT_PRICE)
        @name=name
        @price=price
    end
end

p product=Product.new('A free movie')

# Rubyにはインスタンス自身を表すselfキーワードがある。thisキーワードと同じ
class User9
    attr_accessor :name

    def initialize(name)
        @name=name
    end

    def hello
        # selfなしでnameメソッドを呼ぶ
        "Hello,I am #{name}."
    end

    def hi
        # self付きでnameメソッドを呼ぶ
        "Hi,I am #{self.name}."
    end

    def my_name
        # 直接インスタンス変数の@nameにアクセスする
        "My name is #{@name}"
    end
end

user = User9.new('Alice')
p user.hello
p user.hi
p user.my_name

# 注意点　name= のようなセッターメソッドを呼び出したい場合は、必ずselfを付ける必要がある。
# クラス定義内に登場するselfは場所によって「そのクラスのインスタンス自身」を表したり、
# 「クラス自身」を表したりする。
class Foo
    # このputsはクラス定義の読み込み時に呼び出される
    puts "クラス構文の直下のself: #{self}"

    def self.bar
        puts "クラスメソッド内のself: #{self}"
    end

    def baz
        puts "インスタンスメソッド内のself: #{self}"
    end
end

puts Foo.bar
foo = Foo.new
puts foo.baz

# クラス構文の直下で直接クラスメソッドが呼び出される例
class Foo
    # この時点ではクラスメソッドbarが定義されていないので、呼び出せない
    # NoMethodErrorが発生する
    # self.bar

    def self.bar
        puts 'hello'
    end

    # クラス構文の直下でクラスメソッドを呼び出す
    # クラスメソッドbarが定義された後なので、呼び出せる
    puts self.bar
end

# クラスメソッドをインスタンスメソッドで呼び出す
# クラス名.メソッド
class Product2
    attr_reader :name,:price

    def initialize(name,price)
        @name=name
        @price=price
    end

    # 金額を整形するクラスメソッド
    def self.format_price(price)
        "#{price}円"
    end

    def to_s
        # インスタンスメソッドからクラスメソッドを呼び出す
        formatted_price=Product2.format_price(price)
        "name:#{name},price#{formatted_price}"
    end
end

product = Product2.new('A great movie',1000)
puts  product.to_s
# self.class.メソッドと書く場合もある。

# 7.6クラスの継承
# 親クラスをスーパークラス、子クラスをサブクラスと呼ぶ
# クラスの継承が適切かどうかの判断は「サブクラス is a スーパークラス」と呼んで違和感がないか。
# Rubyの継承は単一継承。Objectクラスが頂点で、継承している。
# Objectは何も書かなくてもデフォルトで継承される
# クラスを調べるには、classメソッド、継承関係かどうかを調べるにはis_a?メソッドを使う

# 独自のクラスを継承する
# class サブクラス < スーパークラス
# end

# superでスーパークラスのメソッドを呼び出す
class Product3
    attr_reader :name,:price

    def initialize(name,price)
        @name=name
        @price=price
    end
end

# メソッドのオーバーライド
# サブクラスではスーパークラスと同名のメソッドを定義することで、
# スーパークラスの処理を上書きすることができる。
class Product4
    attr_reader :name,:price

    def initialize(name,price)
        @name=name
        @price=price
    end

    def to_s
        "name:#{name},price: #{price}"
    end
end

# DVDクラスはこれらに加えて再生時間を持つことにする
class DVD < Product4
    # nameとpriceはスーパークラスでattr_readerが設定されているので定義不要
    attr_reader :running_time

    def initialize(name,price,running_time)
        # スーパークラスのinitializeメソッドを呼びだす
        super(name,price)
        # DVDクラス独自の属性
        @running_time = running_time
    end

    def to_s
#        "name:#{name},price: #{price},running_time:#{running_time}"
        "#{super},running_time:#{running_time}"
    end
end

dvd=DVD.new('A great movie',1000,120)
p dvd.name
p dvd.price
p dvd.running_time

product = Product4.new('A great movie',1000)
dvd=DVD.new('An awesome film',3000,120)
p product.to_s
p dvd.to_s

# クラスメソッドの継承
# クラスを継承すると、クラスメソッドも継承される
class Foo
    def self.hello
        'hello'
    end
end
class Bar < Foo
end
p Foo.hello
p Bar.hello

# メソッドの公開レベル
# public protected privateの３つ
# privateはレシーバーをつけて呼び出すことができないメソッド
# privateはサブクラスでも呼び出せる
# privateになるのはインスタンスメソッドだけで、クラスメソッドはprivateにならない。
# privateメソッド、paublicメソッドは好きな順番で定義
# 通常はprivateキーワードを使うのは1回にして、クラスの最後のほうにprivateメソッドの定義をまとめることが多い
class User10
    # ここからはprivateメソッド
    private
    def foo
    end

    # ここからはpublicメソッド
    public

    def bar
    end
end

# protectedはあまり使わない。7.7.7参照
# 継承した同名のインスタンス変数に注意。予期せぬ挙動をする。
# Rubyのprivateメソッドはサブクラスでも呼び出せるため、スーパークラスの実装を理解しておかないといけない。

# 定数を外部から参照する場合は　クラス名 :: 定数名
# private_constantで定数名を指定して、外部から参照できなくできるが、ほぼ使わない
# 定数はメソッドの内部で定義することはできない。クラス構文の直下で作成するのが必須
# 定数は上書きできるが、クラスをfreezeすればできなくなる。ただ、ほぼ使わない
class User11
    DEFAULT_PRICE = 0
end

p User11::DEFAULT_PRICE

# 定数はミュータブルなオブジェクト（ハッシュ、配列、文字列など）であれば定数の値を変えることができる
# 対策は7.8.2参照

# 変数はローカル変数とインスタンス変数以外にもある
# クラスインスタンス変数、クラス変数、グローバル変数、Ruby標準の組み込み変数（特殊変数）詳細は7.9.1参照
# 7.10は高度な内容なので、割愛。エイリアス、メソッドの定義を後から削除、クラスのネスト、演算子の挙動を独自定義、equal?,==,eql?,===等価演算子の意味
# オープンクラスとモンキーパッチ。railsではオープンクラスを積極的に活用し、便利メソッドを独自に定義している。
# クラスメソッド=特異メソッド