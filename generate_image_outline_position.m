clear
clf
% 画像をインポート
I = imread('image/THE NOM FACE.jpg');
I = flipud(I);

% 画像をグレースケールに変換
I = rgb2gray(I);

% 画像を二値化
BW = imbinarize(I);

figure(1)
imshow(BW)

% 黒いピクセルの外形の座標を取得
[B,L,N] = bwboundaries(BW);

B_idx = 1:length(B);

% 始点の座標が一番左上から始まるB{n}を検索
minDistance = inf;
minIndex = 0;
for n = 1:N
    boundary = B{n};
    distance = boundary(1,1)^2 + boundary(1,2)^2;
    if distance < minDistance
        minDistance = distance;
        minIndex = n;
    end
end
figure(1)
plot(B{minIndex}(:,2), B{minIndex}(:,1), 'r','LineWidth',2);

B_idx(B_idx == minIndex) = []; % すでに使ったidxは消す

boundary_linking = B{minIndex}; % 連結用の変数に格納

for i = 1 : length(B) - 1 % B-1の数だけ繰り返す
    min_distance = inf; %初期化
    start_position = B{minIndex}(end, :); % 一個前のBの最後の位置
    for n = B_idx % まだ使ってないidxを対象にする      
        end_position = B{n}(1, :); % 検索するBの最初の位置
        diff_distance = abs(norm(end_position - start_position)); % 距離を計算

        if(diff_distance < min_distance)
            min_distance = diff_distance;
            minIndex = n;
        end
    end

    boundary_linking = [boundary_linking; B{minIndex}]; % 連結
    B_idx(B_idx == minIndex) = []; % すでに使ったidxは消す

end

figure(2)
plot(boundary_linking(:,2), boundary_linking(:,1), 'r','LineWidth',2);

position(2, :) = boundary_linking(:, 1)';
position(1, :) = boundary_linking(:, 2)';


% xy座標の最小値と最大値を取得
xmin = min(position(1, :));
xmax = max(position(1, :));
ymin = min(position(2, :));
ymax = max(position(2, :));

% xy座標の範囲を-1~1に正規化
if (xmax - xmin) > (ymax - ymin)
    position(1, :) = 2 * (position(1, :) - xmin) / (xmax - xmin) - 1;
    position(2, :) = 2 * (position(2, :) - ymin) / (xmax - xmin) - 1;
else
    position(1, :) = 2 * (position(1, :) - xmin) / (ymax - ymin) - 1;
    position(2, :) = 2 * (position(2, :) - ymin) / (ymax - ymin) - 1;
end

% 中心の持ってくる
cx = (min(position(1, :)) + max(position(1, :)))/2;
cy = (min(position(2, :)) + max(position(2, :)))/2;

position(1, :) = position(1, :) - cx;
position(2, :) = position(2, :) - cy;

% position(:, end+1) = [0; 0]; % あとで消す

figure(3)
scatter(position(1, :), position(2, :))

save('nom_data', "position")