clear
clf
% 時刻tで変化する任意のデータ
% data = load('cat_data.mat');
% data.size = length(data.position);

% リサージュ
% tt = 0 : 0.001 : 2*pi;
% data.position(1, :) = sin(tt);
% data.position(2, :) = 2*sin(2*tt + pi/6);
% data.size = length(data.position);

% tt = 0 : 0.01 : 2*pi;
% data.position(1, :) = sin(tt)+cos(tt)+sin(2*tt)+cos(3*tt)+sin(4*tt);
% data.position(2, :) = 2*sin(2*tt + pi/6)+3*sin(5*tt + pi/2);
% data.size = length(data.position);

tt = 0 : 0.01 : 2*pi;
data.position(1, :) = tt;
data.position(2, :) = 2*sin(2*tt + pi/6)+3*sin(5*tt + pi/2);
data.size = length(data.position);

picture.position.x = data.position(1, :); 
picture.position.y = data.position(2, :); 

picture.max.x = max(picture.position.x);
picture.min.x = min(picture.position.x);
picture.max.y = max(picture.position.y);
picture.min.y = min(picture.position.y);

% フーリエ変換
equation.F.x = fft(picture.position.x) / length(picture.position.x);
equation.F.y = fft(picture.position.y) / length(picture.position.y);

N = length(picture.position.x);
t = 0:N-1;
equation.position.x = zeros(1,N);
equation.position.y = zeros(1,N);
for k = 1:N
    % use exp
    equation.position.x = equation.position.x + equation.F.x(k) * exp(2*pi*1i*(k-1)*t/N);
    equation.position.y = equation.position.y + equation.F.y(k) * exp(2*pi*1i*(k-1)*t/N);
    
    %use sin cos
    % equation.position.x = equation.position.x + real(equation.F.x(k))*cos(2*pi*(k-1)*t/N) - imag(equation.F.x(k))*sin(2*pi*(k-1)*t/N);
    % equation.position.y = equation.position.y + real(equation.F.y(k))*cos(2*pi*(k-1)*t/N) - imag(equation.F.y(k))*sin(2*pi*(k-1)*t/N);

end
equation.position.x = real(equation.position.x/N);
equation.position.y = real(equation.position.y/N);

figure(2)
scatter(picture.position.x, picture.position.y, "o")
hold on
% scatter(equation.position.x, equation.position.y, "*")
axis equal
hold off
legend("Picture position", "Equation position")
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
% circle_num = 3;

frames = length(equation.F.x);
frame_interval = 1; % odd
xs = zeros(1, frames/frame_interval);
ys = zeros(1, frames/frame_interval);

M(frames) = struct('cdata',[],'colormap',[]);

animation.center_offset.x = [5, 5];
animation.center_offset.y = [-5, -5];

for f = 0 :frame_interval : frames
    %x
    animation.center.x = animation.center_offset.x;
    animation.centers.x = zeros(circle_num, 2);
    animation.next_centers.x = zeros(circle_num, 2);
    animation.radiuses.x = zeros(1, circle_num);

    animation.theta.x = 0;
    %y
    animation.center.y = animation.center_offset.y;
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
        animation.theta.y = 2*pi*animation.freq.y(n)*f/frames + animation.phase.y(n) + pi/2;
        
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

    if rem(f, frame_interval) == 0
        xs((f/frame_interval)+1) = animation.centers.x(end, 1);
        ys((f/frame_interval)+1) = animation.centers.y(end, 2);
    end

    hold on
    plotCircle(animation.centers.x, animation.radiuses.x, 'r');
    plotCircle(animation.centers.y, animation.radiuses.y, 'g');
    plotLine(animation.centers.x(end, :)', [animation.centers.x(end, 1); animation.centers.y(end, 2)], 'm', 5)
    plotLine(animation.centers.y(end, :)', [animation.centers.x(end, 1); animation.centers.y(end, 2)], 'm', 5)
    scatter(xs(1:(f/frame_interval)+1), ys(1:(f/frame_interval)+1));

    % plotLine(animation.centers.x', animation.next_centers.x', 'black', 2);
    % plotLine(animation.centers.y', animation.next_centers.y', 'black', 2);

    axis equal
    xlim([picture.min.x, picture.max.x] + [animation.center_offset.y(1), animation.center_offset.x(1)] + [-1, 1])
    ylim([picture.min.y, picture.max.y] + [animation.center_offset.y(2), animation.center_offset.x(2)] + [-1, 1])
 
    % if rem(f, 10) == 0
        drawnow limitrate
    % end
    hold off
    
    M(f+1) = getframe;
end

% hold on 
% scatter(xs, ys);
% hold off
M(end+1) = getframe;


function plotCircle(centers, radiuses, color)
    viscircles(centers, radiuses, 'Color', color);
    % rectangle('Position',[center - radius, radius * 2, radius * 2], 'Curvature', [1, 1]);
end

function plotLine(start, stop, color, line_width)
    line([start(1, :); stop(1, :)], [start(2, :); stop(2, :)], 'LineWidth', line_width, 'Color', color);

    % plot([start(1), stop(1)], [start(2), stop(2)]);
end