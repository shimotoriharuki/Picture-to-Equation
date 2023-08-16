clear

% Define a picture
% data = load('cat_data.mat');
% data.size = length(data.position);

tt = 0 : 0.1 : 2*pi;
data.position(1, :) = sin(tt);
data.position(2, :) = 2*sin(2*tt + pi/6);
data.size = length(data.position);


t = linspace(0, 1, data.size);
picture.position.x = data.position(1, :);
picture.position.y = data.position(2, :);


N = 10; % number of terms to expand
T = t(end)-t(1);
w0 = 2*pi/T;

equation.x = [];
equation.y = [];
[equation.a0.x, equation.an.x, equation.bn.x] = getFourierSeriesExpansionConstants(picture.position.x, t, N, w0 ,T);
[equation.a0.y, equation.an.y, equation.bn.y] = getFourierSeriesExpansionConstants(picture.position.y, t, N, w0 ,T);

% plot the result of the Fourier series expansion
equation.position.x = equation.a0.x/2;
for n=1:N
    equation.position.x = equation.position.x + equation.an.x(n)*cos(n*w0*t) + equation.bn.x(n)*sin(n*w0*t);
end
equation.position.y = equation.a0.y/2;
for n=1:N
    equation.position.y = equation.position.y + equation.an.y(n)*cos(n*w0*t) + equation.bn.y(n)*sin(n*w0*t);
end

figure(1)
subplot(2, 1, 1);
plot(t, picture.position.x, t, equation.position.x)
legend('Original picture','Fourier series approximation')

subplot(2, 1, 2);
plot(t, picture.position.y, t, equation.position.y)
legend('Original picture','Fourier series approximation')

figure(2)
scatter(picture.position.x, picture.position.y, '*');
hold on
scatter(equation.position.x, equation.position.y, 'o');
hold off
legend("Picture", "Equation")

equation.string.x = getFourierSeriesExpansionText(equation.a0.x, equation.an.x, equation.bn.x, w0, "out.x", "in");
equation.string.y = getFourierSeriesExpansionText(equation.a0.y, equation.an.y, equation.bn.y, w0, "out.y", "in");

string_save_x = equation.string.x;
string_save_y = equation.string.y;

save("equation_string_x", "string_save_x")
save("equation_string_y", "string_save_y")

% Plot using approximate fomula
in = 0:0.0001:1;
eval(string_save_x); % Run a script with a string of variable.
eval(string_save_y); % Run a script with a string of variable.

% hold on
% scatter(out.x, out.y, "x");
% hold off


% Calculate the coefficients when expanding the Fourier series
function [a0, an, bn] = getFourierSeriesExpansionConstants(x, t, N, w0, T)
    a0 = (2/T)*trapz(t,x);
    an = zeros(N,1);
    bn = zeros(N,1);
    for n=1:N
        an(n) = (2/T)*trapz(t,x.*cos(n*w0*t));
        bn(n) = (2/T)*trapz(t,x.*sin(n*w0*t));
    end
end

function str = getFourierSeriesExpansionText(a0, an, bn, w0, output_variable_str, input_variable_str)
    N = length(an);
    str = sprintf('%s = %g/2', output_variable_str, a0);
    for n=1:N
        str = sprintf('%s + %g*cos(%d*%g*%s) + %g*sin(%d*%g*%s)', str, an(n), n, w0, input_variable_str, ...
            bn(n), n, w0, input_variable_str);
    end
end


