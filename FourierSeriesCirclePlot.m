clear
clf
% 時刻tで変化する任意のデータ
data = load('cat_data.mat');
data.size = length(data.position);

picture.position.x = data.position(1, :); 
picture.position.y = data.position(2, :); 

% フーリエ変換
equation.F.x = fft(picture.position.x);
equation.F.y = fft(picture.position.y);

% パラメータ
N = length(equation.F.x);
frequencies = [0:N/2-1, -N/2:-1];
time = linspace(0, 2*pi, N+1);

% 直径，周波数，初期位相を計算
animation.amp.x = abs(equation.F.x);
animation.amp.y = abs(equation.F.y);

animation.freq = 1:N;

animation.phase.x = atan2(imag(equation.F.x), real(equation.F.x));
animation.phase.y = atan2(imag(equation.F.y), real(equation.F.y));

[animation.amp.x, idx] = sort(animation.amp.x, "descend");
animation.phase.x = animation.phase.x(idx);

% アニメーション
figure(1)

resolution = 0.5;
qc = [];
ql = [];
circle_num = 1000;
for r = 0 : 0.1 : 1
    center = [0, 0];
    centers = zeros(circle_num, 2);
    next_centers = zeros(circle_num, 2);
    radiuses = zeros(1, circle_num);
    clf
    h = animatedline;
    for n = 1:circle_num
        centers(n, :) = center;
        radiuses(n) = animation.amp.x(n);
        % plotCircle(center, animation.amp.x(n));
        % hold on

        next_x = center(1) + animation.amp.x(n) * cos(r + animation.phase.x(n));
        next_y = center(2) + animation.amp.x(n) * sin(r + animation.phase.x(n));
        next_center = [next_x, next_y];
        % plotLine(center, next_center);
    
        center = next_center;
        next_centers(n, :) = next_center;

        
        
    end

    hold on
    for i = 1:size(centers, 2)
        addpoints(h, [centers(n, 1), next_centers(n, 1)], [centers(n, 2), next_centers(n, 2)]);
        drawnow
    end
    % plotCircle(centers, radiuses);
    % plotLine(centers', next_centers');

    axis equal

    % drawnow

    hold off

end



function plotCircle(centers, radiuses)
    viscircles(centers, radiuses);
    % rectangle('Position',[center - radius, radius * 2, radius * 2], 'Curvature', [1, 1]);
end

function plotLine(start, stop)
    line([start(1, :); stop(1, :)], [start(2, :); stop(2, :)]);

    % plot([start(1), stop(1)], [start(2), stop(2)]);
end