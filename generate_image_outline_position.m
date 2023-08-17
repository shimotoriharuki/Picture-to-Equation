clear
clf
% 画像をインポート
I = imread('image/THE NOM FACE.jpg');

% 画像をグレースケールに変換
I = rgb2gray(I);

% 画像を二値化
BW = imbinarize(I);

figure(1)
imshow(BW)

% 黒いピクセルの外形の座標を取得
[B,L,N] = bwboundaries(BW);
hold on;
for k=1:length(B)
   boundary = B{k};
   if(k > N)
     plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
   else
     plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
   end
end
hold off