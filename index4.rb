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

# インスタンス変数は