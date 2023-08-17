clear
% 時刻tで変化する任意のデータ
data = load('cat_data.mat');
data.size = length(data.position);

% tt = 0 : 0.1 : 2*pi;
% data.position(1, :) = sin(tt);
% data.position(2, :) = 2*sin(2*tt + pi/6);
% data.size = length(data.position);

picture.position.x = data.position(1, 1:data.size); 
picture.position.y = data.position(2, 1:data.size); 

% フーリエ変換
equation.F.x = fft(picture.position.x);
equation.F.y = fft(picture.position.y);


% 三角関数の重ね合わせで近似
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

% figure(1)
% subplot(2, 1, 1)
% plot(t, picture.position.x, 'LineWidth', 10)
% hold on
% plot(t, equation.position.x, 'LineWidth', 3)
% hold off
% legend("Picture position", "Equation position")
% title("X position")
% 
% subplot(2, 1, 2)
% plot(t, picture.position.y, 'LineWidth', 10)
% hold on
% plot(t, equation.position.y, 'LineWidth', 3)
% hold off
% legend("Picture position", "Equation position")
% title("Y position")

figure(2)
scatter(picture.position.x, picture.position.y, "*")
hold on
scatter(equation.position.x, equation.position.y, "o")
axis equal
hold off
legend("Picture position", "Equation position")

% TeX形式の数式を出力
% equation.tex_string.x = '';
% for k = 1:N
%     if k == 1
%         equation.tex_string.x = [equation.tex_string.x, num2str(real(equation.F.x(k))/N)];
%     else
%         equation.tex_string.x = [equation.tex_string.x, ' + ', num2str(real(equation.F.x(k))/N), 'e^{', num2str(2*pi*1i*(k-1)), 't}'];
%     end
% end
% disp(equation.tex_string.x)
