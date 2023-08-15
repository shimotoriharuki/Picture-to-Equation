% 猫の形をした一筆書きのデータを生成する関数
% 猫の頭部分
head_theta = linspace(0, 2*pi, 100);
head_x = 0.3 * cos(head_theta);
head_y = 0.3 * sin(head_theta);

% 猫の耳部分
left_ear_x = [-0.3, -0.5, -0.4];
left_ear_y = [0.3, 0.6, 0.3];
right_ear_x = [0.3, 0.5, 0.4];
right_ear_y = [0.3, 0.6, 0.3];

% 猫の目部分
left_eye_x = [-0.15, -0.1];
left_eye_y = [0.1, 0.15];
right_eye_x = [0.15, 0.1];
right_eye_y = [0.1, 0.15];

% 猫の鼻部分
nose_x = [0, 0];
nose_y = [0, -0.05];

% 猫の口部分
mouth_x = [-0.05, -0.1, 0, 0.1, 0.05];
mouth_y = [-0.1, -0.15, -0.2, -0.15, -0.1];

% データを結合する
x = [head_x, left_ear_x, head_x(1), right_ear_x,left_eye_x,nose_x,right_eye_x,nose_x(2),mouth_x];
y = [head_y,left_ear_y,head_y(1),right_ear_y,left_eye_y,nose_y,right_eye_y,nose_y(2),mouth_y];

% スプライン補間で滑らかな曲線にする
t = linspace(1,length(x),length(x));
tt = linspace(1,length(x),10*length(x));
xx = spline(t,x,tt);
yy = spline(t,y,tt);

% プロットする
plot(xx,yy)
axis equal

position = [xx; yy];
save('cat_data', 'position')
