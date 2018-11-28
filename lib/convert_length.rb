# 定数を外だし
UNITS={m: 1.0,ft: 3.28,in: 39.37}
# 例題：長さの単位変換プログラム
def convert_length(length,from: :m,to: :m)
    (length / UNITS[from] * UNITS[to]).round(2)
end

# 単位を表すハッシュを定義
units={m: 1.0,ft: 3.28,in: 39.37}
# 変換後の長さを求める式は変換前の単位の長さ/変換前の単位の比率×変換後の単位の比率
# 割り切れない場合は小数点第2位まで