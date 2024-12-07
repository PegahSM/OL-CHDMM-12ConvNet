
function [c0,c1] = chck(h0,h1,h2)

N = length(h0);

r0 = conv(h0,h0(end:-1:1));
r1 = conv(h1,h1(end:-1:1));
r2 = conv(h2,h2(end:-1:1));

t0 = conv(h0,modflip(h0));
t1 = conv(h1,modflip(h1));
t2 = conv(h2,modflip(h2));

c0 = r0 + r1 + r2;

c1 = t0 + t1 + t2;

subplot(2,1,1), stem(1-N:N-1,c0,'.')
subplot(2,1,2), stem(1-N:N-1,c1,'.')

% -----------------------------------------------
%    subroutine
% -----------------------------------------------

function y = modflip(x)
%
% y = modflip(x)
% x must be column or a row vector.
%
%  X(z) = x(0) + x(1)/z + x(2)/z^2 + x(N-1)/z^N
%  Y(z) = X(-1/z) z^(-N) where N = deg{X}

N = length(x);

y = x(N:-1:1) .* ( (-1).^(N-1:-1:0) );

