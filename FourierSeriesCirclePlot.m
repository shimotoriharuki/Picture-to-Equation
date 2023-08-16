clear
clf
% 時刻tで変化する任意のデータ
data = load('uneune.mat');
data.size = length(data.position);

% リサージュ
% tt = 0 : 0.001 : 2*pi;
% data.position(1, :) = sin(tt);
% data.position(2, :) = 2*sin(2*tt + pi/6);
% data.size = length(data.position);

picture.position.x = data.position(1, :); 
picture.position.y = data.position(2, :); 

% フーリエ変換
equation.F.x = fft(picture.position.x) / length(picture.position.x);
equation.F.y = fft(picture.position.y) / length(picture.position.y);

% パラメータ
N = length(equation.F.x);

% 直径，周波数，初期位相を計算
animation.amp.x = abs(equation.F.x);
animation.amp.y = abs(equation.F.y);

animation.freq.x = 0:N;
animation.freq.y = 0:N;

animation.phase.x = atan2(imag(equation.F.x), real(equation.F.x));
animation.phase.y = atan2(imag(equation.F.y), real(equation.F.y));

[animation.amp.x, idx] = sort(animation.amp.x, "descend");
animation.phase.x = animation.phase.x(idx);
animation.freq.x = animation.freq.x(idx);

[animation.amp.y, idx] = sort(animation.amp.y, "descend");
animation.phase.y = animation.phase.y(idx);
animation.freq.y = animation.freq.y(idx);


% アニメーション
figure(1)

circle_num = length(equation.F.x);
frames = length(equation.F.x);
frame_interval = 1;
xs = zeros(1, frames);
ys = zeros(1, frames);
for f = 0 :frame_interval : frames
    %x
    animation.center.x = [0.5, 0.5];
    animation.centers.x = zeros(circle_num, 2);
    animation.next_centers.x = zeros(circle_num, 2);
    animation.radiuses.x = zeros(1, circle_num);

    animation.theta.x = 0;
    %y
    animation.center.y = [-0.5, -0.5];
    animation.centers.y = zeros(circle_num, 2);
    animation.next_centers.y = zeros(circle_num, 2);
    animation.radiuses.y = zeros(1, circle_num);

    animation.theta.y = 0;
    clf
    for n = 1:circle_num
        %x
        animation.centers.x(n, :) = animation.center.x;
        animation.radiuses.x(n) = animation.amp.x(n);
        animation.theta.x = 2*pi*animation.freq.x(n)*f/frames + animation.phase.x(n);
        %y
        animation.centers.y(n, :) = animation.center.y;
        animation.radiuses.y(n) = animation.amp.y(n);
        animation.theta.y = 2*pi*animation.freq.y(n)*f/frames + animation.phase.y(n) - pi/2;
        
        %x
        animation.next_center.x = [animation.center.x(1) + animation.amp.x(n) * cos(animation.theta.x), 
            animation.center.x(2) + animation.amp.x(n) * sin(animation.theta.x)];
        %y
        animation.next_center.y = [animation.center.y(1) + animation.amp.y(n) * cos(animation.theta.y), 
            animation.center.y(2) + animation.amp.y(n) * sin(animation.theta.y)];

        %x
        animation.center.x = animation.next_center.x;
        animation.next_centers.x(n, :) = animation.next_center.x;
        %y
        animation.center.y = animation.next_center.y;
        animation.next_centers.y(n, :) = animation.next_center.y;
        
    end

    hold on
    % subplot(2, 1, 1)
    plotCircle(animation.centers.x, animation.radiuses.x, 'r');
    plotCircle(animation.centers.y, animation.radiuses.y, 'b');
    plotLine(animation.centers.x(end, :)', [animation.centers.x(end, 1); animation.centers.y(end, 2)], 'm')
    plotLine(animation.centers.y(end, :)', [animation.centers.x(end, 1); animation.centers.y(end, 2)], 'm')
    axis equal
    xlim([-3 3])
    ylim([-3 3])

    drawnow
    hold off

    xs(f+1) = animation.centers.x(end, 1);
    ys(f+1) = animation.centers.y(end, 2);

end

hold on 
scatter(xs, ys);
hold off


function plotCircle(centers, radiuses, color)
    viscircles(centers, radiuses, 'Color', color);
    % rectangle('Position',[center - radius, radius * 2, radius * 2], 'Curvature', [1, 1]);
end

function plotLine(start, stop, color)
    line([start(1, :); stop(1, :)], [start(2, :); stop(2, :)], 'LineWidth', 5, 'Color', color);

    % plot([start(1), stop(1)], [start(2), stop(2)]);
end