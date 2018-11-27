# 例題RGB変換プログラムを作成する
# 10進数を16進数に変換するto_hexメソッドと、16進数を10進数に変換するto_intsメソッドの2つを定義する
# to_hexメソッドは3つの整数を受け取り、それぞれを16進数に変換した文字列を返す。文字列の先頭には"#"を付ける
# to_intsメソッドはRGBカラーを表す16進数文字列を受け取り、R,G,Bのそれぞれを10進数の整数に変換した値を配列として返す。

def to_hex(r,g,b)
    # '#'+
    # r.to_s(16).rjust(2,'0') +
    # g.to_s(16).rjust(2,'0') +
    # b.to_s(16).rjust(2,'0')
#     hex = '#'
#     [r,g,b].each do |n|
#         hex += n.to_s(16).rjust(2,'0')
#     end
# hex

    [r,g,b].inject('#') do |hex,n|
        hex + n.to_s(16).rjust(2,'0')
    end
end


puts 0.to_s(16)
puts 255.to_s(16)
# rjustメソッドを使って、右寄せ。第1引数で桁数、第2引数指定で埋める文字を指定
puts 0.to_s(16).rjust(2,'0')
puts 255.to_s(16).rjust(2,'0')
puts to_hex(255,255,255)

def to_ints(hex)
    # r=hex[1..2]
    # g=hex[3..4]
    # b=hex[5..6]
    # ints = []
    # [r,g,b].each do |s|
    #     ints << s.hex
    # end
    # ints

    # r=hex[1..2]
    # g=hex[3..4]
    # b=hex[5..6]
    # ints = [r,g,b].map do|s|
    #     s.hex
    # end
    # ints

    r,g,b=hex[1..2],hex[3..4],hex[5..6]
    ints = [r,g,b].map do|s|
        s.hex
    end
    ints

end

# 16進数を10進数の整数に変換するメソッドはStringクラスのhexメソッド
hex='#12abcd'
r=hex[1..2]
g=hex[3..4]
b=hex[5..6]

puts 'ff'.hex