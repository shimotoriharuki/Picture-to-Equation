% パラメータtの範囲を定義
t = linspace(0, 2*pi, 100);

% 図形の外形を描画
x = cos(t);
y = sin(t);
plot(x, y)
hold on

% 図形の内部を描画
x = 0.5*cos(t);
y = 0.5*sin(t);
plot(x, y)

% 描画を終了
hold off
axis equal
