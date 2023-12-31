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
% clf
% clear
% numpoints = 500; 
% x = linspace(0, 4*pi, numpoints); 
% y = sin(x); 
% pc = [-.1, -.1, .2, .2] ; % position of circle
% f = figure(1);
% % h = animatedline;
% hc = gobjects(500, 1);
% M(numpoints) = struct('cdata',[],'colormap',[]);
% for i = 1 : length(hc)
%     hc(i) = rectangle('Position', [x(1)+i*0.01 y(1) 0 0] + pc,'Curvature',[1 1]) ; % draw circle
% end
% axis([-pi, 5*pi, -1.5, 1.5]) 
% for k = 1 : numpoints 
%     % addpoints(h, x(k), y(k)) 
%     for i = 1 : length(hc)
%         set(hc(i), 'Position', [x(k)+i*0.01 y(k) 0 0] + pc) ; % adjust position of circle
%     end
%     if rem(i, 2) == 0
%         drawnow limitrate 
%     end
% 
%     M(k) = getframe;
% end 

N = 1000; % 円の数


% % 円を描画
% figure(1)
% for i = 1 : 10
%     clf
%     % centers = rand(N,2)*10; % 円の中心の座標
%     % radii = rand(N,1)*2; % 円の半径
%     % viscircles(centers, radii);
% 
%     drawnow
% 
% end
% % 画像を保存
% saveas(gcf, 'circles.png')

figure(1)
N = 1000; % 線の数

for j = 1:10
x1 = rand(N,1)*10; % 線の始点のx座標
y1 = rand(N,1)*10; % 線の始点のy座標
x2 = rand(N,1)*10; % 線の終点のx座標
y2 = rand(N,1)*10; % 線の終点のy座標

% 線を描画

clf
hold on
for i = 1:N
    
    plot([x1(i) x2(i)], [y1(i) y2(i)])
    
end
drawnow
hold off
end
