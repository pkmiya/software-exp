import math

# リスト x を定義
x = [7, 5, 3, 2, 6, 4, 5, 1, 5, 1, 6, 7]

# 合計を初期化
total_permutations = 0

# リスト x の各要素に対して順列を計算して合計に加える
for k in range(12):
    permutations = math.perm(7, x[k])  # 7P(x[k]) の計算
    total_permutations += permutations

# 結果を出力
print("合計順列:", total_permutations)
