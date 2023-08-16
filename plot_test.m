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

% clear
% 
% % 四角の個数
% N = 2000;
% 
% % step 1
% t = 0:0.1:10; % 時間軸
% c = 3 * t / 10 - 1.5; % 中心点X軸
% x = c + cos(2 * pi * ([0; 0.25; 0.5; 0.75] + t / 5)) / 2; % 頂点X軸
% y = sin(2 * pi * ([0; 0.25; 0.5; 0.75] + t / 5)) / 2; % 頂点Y軸
% 
% % step 2
% fig = figure(1); % Figure オブジェクトの生成
% plt(N) = patch(x(:, 1), y(:, 1), 'red'); % Patch オブジェクトの生成
% for i = 1:N
%     plt(i) = patch(x(:, 1) + randn, y(:, 1) + randn, 'red');
% end
% xlim([-3 3]); ylim([-3 3]); % 描画範囲の固定
% frames(100) = struct('cdata', [], 'colormap', []); % 各フレームの画像データを格納する配列
% for i = 1:100 % 動画の長さは100フレームとする
%     for j = 1:N
%         plt(j).XData = x(:, i) + randn; % X軸データをセット
%         plt(j).YData = y(:, i) + randn; % Y軸データをセット
%     end
%     if rem(i, 50) == 0
%         drawnow limitrate; % 描画を確実に実行させる
%     end
% 
%     % frames(i) = getframe(fig); % 図を画像データとして得る
% end
clf
clear
numpoints = 100; 
x = linspace(0, 4*pi, numpoints); 
y = sin(x); 
pc = [-.1, -.1, .2, .2] ; % position of circle
f = figure(1);
h = animatedline;
hc = zeros(1, 1000);
M(numpoints) = struct('cdata',[],'colormap',[]);
for i = 1 : length(hc)
    hc(i) = rectangle('Position', [x(1)+i*0.01 y(1) 0 0] + pc,'Curvature',[1 1]) ; % draw circle
end
axis([-pi, 5*pi, -1.5, 1.5]) 
for k = 1 : numpoints 
    addpoints(h, x(k), y(k)) 
    for i = 1 : length(hc)
        set(hc(i), 'Position', [x(k)+i*0.01 y(k) 0 0] + pc) ; % adjust position of circle
    end
    if rem(i, 20) == 0
        % drawnow limitrate 
    end

    M(k) = getframe;
end 
