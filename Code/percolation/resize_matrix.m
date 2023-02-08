function [csq] = resize_matrix(c)

width = max(size(c));    % largest size of the box
p = log(width)/log(2);   % nbre of generations

% remap the array if the sizes are not all equal,
% or if they are not power of two
% (this slows down the computation!)
%if p~=round(p) || any(size(c)~=width)
    p = floor(p);
    width = 2^p
    mz = zeros(width, width);
    mz(1:width,1:width) = c(1:width,1:width);
    csq = mz; 
%end