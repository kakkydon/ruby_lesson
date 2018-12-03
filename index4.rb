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

