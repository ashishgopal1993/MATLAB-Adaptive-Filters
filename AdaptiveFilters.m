% Title: Understand and analyze adaptive signal processing.
% Aim: Use LMS algorith to estimate unknown filter transfer function
% Programmer name: Ashish Ashok Gopal, 1702005, FY MTech
% Department: Department of Electronics Engineering
% Mentor: Dr. Nirmal, HOD
% Department: Department of Electronics Engineering
% Date: 28/09/2017

% ***************Program starts here*************************

% w(n) digital filter transfer function (adaptive configuration)
% u(n) transfer function
% x(n) input
% e(n) error 
% d(n) output
% y(n) output of w(n)

order = 10;             % Order of the filter

% Reading .wav file
[x, Fs]=audioread('Lion.wav');
x = x(1:100000);        % Consider only 100000 samples

noise = randn(size(x));
nx = x + noise;
nx = nx/max(nx);         % Normalizing x
nx = nx';

b = fir1(order, 0.3, 'low');    % filter coeficients of u(n)
d = filter(b, 1, nx);           % y(n)

mu = 0.8; % Step size; If mu is very large, it will converge very fast but error may be large. If mu is small, convergence will be slow but, error will be small

lms = dsp.LMSFilter(order+1, 'StepSize', mu, 'WeightsOutputPort', true);
[y, e, w] = step(lms, nx, d);
stem([b.' w]);
title('System Identification by LMS algorithm');

fvtool(b);      % Filter visualizatioin of filter coeficients of u(n)
fvtool(w);      % Filter visualizatioin of adaptive filter coeficients
% You can observe that adaptive filter will model unknown system almost
% equivalently.

% ****************Program ends here**************************