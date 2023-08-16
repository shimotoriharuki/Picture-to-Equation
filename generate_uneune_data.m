clear
% パラメータtの範囲を定義
t = linspace(0, 2*pi, 1000);

% 周波数fを定義
f = 4;

% 円の外形が周波数fのサインカーブになっている形のx座標とy座標を計算
x = cos(t) + sin(f*t);
y = sin(t);

% 座標をposition変数に格納
position = [x; y];
scatter(x, y)

% position変数をcycloid.matファイルに保存
save('uneune.mat', 'position')
