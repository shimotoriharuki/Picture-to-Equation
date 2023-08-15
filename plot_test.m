% clear
% 
% % step 1
% t = 0:0.1:10; % 時間軸
% c = 3 * t / 10 - 1.5; % 中心点X軸
% x = c + cos(2 * pi * ([0; 0.25; 0.5; 0.75] + t / 5)) / 2; % 頂点X軸
% y = sin(2 * pi * ([0; 0.25; 0.5; 0.75] + t / 5)) / 2; % 頂点Y軸
% 
% % step 2
% fig = figure(1); % Figure オブジェクトの生成
% plt = patch(x(:, 1), y(:, 1), 'red'); % Patch オブジェクトの生成
% xlim([-1 1]); ylim([-1 1]); % 描画範囲の固定
% frames(100) = struct('cdata', [], 'colormap', []); % 各フレームの画像データを格納する配列
% for i = 1:100 % 動画の長さは100フレームとする
%     plt.XData = x(:, i); % X軸データをセット
%     plt.YData = y(:, i); % Y軸データをセット
%     drawnow; % 描画を確実に実行させる
%     frames(i) = getframe(fig); % 図を画像データとして得る
% end

clear

% 四角の個数
N = 2000;

% step 1
t = 0:0.1:10; % 時間軸
c = 3 * t / 10 - 1.5; % 中心点X軸
x = c + cos(2 * pi * ([0; 0.25; 0.5; 0.75] + t / 5)) / 2; % 頂点X軸
y = sin(2 * pi * ([0; 0.25; 0.5; 0.75] + t / 5)) / 2; % 頂点Y軸

% step 2
fig = figure(1); % Figure オブジェクトの生成
plt(N) = patch(x(:, 1), y(:, 1), 'red'); % Patch オブジェクトの生成
for i = 1:N
    plt(i) = patch(x(:, 1) + randn, y(:, 1) + randn, 'red');
end
xlim([-3 3]); ylim([-3 3]); % 描画範囲の固定
frames(100) = struct('cdata', [], 'colormap', []); % 各フレームの画像データを格納する配列
for i = 1:100 % 動画の長さは100フレームとする
    for j = 1:N
        plt(j).XData = x(:, i) + randn; % X軸データをセット
        plt(j).YData = y(:, i) + randn; % Y軸データをセット
    end
    if rem(i, 50) == 0
        drawnow limitrate; % 描画を確実に実行させる
    end

    % frames(i) = getframe(fig); % 図を画像データとして得る
end
