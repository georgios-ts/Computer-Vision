function B = shift(A, x, dim)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

if dim == 2
    if x > 0
        B = [A(:, 1:x) A(:, 1:end-x)];
    else 
        B = [A(:, -x+1:end) A(:, end+x+1:end)];
    end
else
    if x > 0
        B = [A(1:x, :); A(1:end-x, :)];
    else 
        B = [A(-x+1:end, :); A(end+x+1:end, :)];
    end
    
end

