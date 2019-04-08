function B = shift2(A, x, y)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
B = shift(shift(A, x, 2), y, 1);
end

