function S = boxFilt(I, h, w, padSize)
% Input: - I integral image padded with padSize
%        - h, w height and width of Box Filter

% 'displacements' 
dw = (w - 1)/2;
dh = (h - 1)/2;


A = shift2(I, dw+1,  dh+1);
B = shift2(I,  -dw,  dh+1);
C = shift2(I,  -dw,   -dh);
D = shift2(I, dw+1,   -dh);
 
S = A + C - B - D;
% Remove padding
S = S(1+padSize(1):end - padSize(1), 1+padSize(2):end - padSize(2));

%{
A = I(1:end-dh-1, 1:end-dw-1);
A = padarray(A, [dh+1 dw+1],'replicate','pre');

B = I(1:end-dh-1, 1+dw:end);
B = padarray(B, [dh+1 0], 'replicate', 'pre');
B = padarray(B, [0 dw], 'replicate', 'post');

C = I(1+dh:end, 1+dw:end);
C = padarray(C, [dh dw],'replicate','post');

D = I(1+dh:end, 1:end-dw-1);
D = padarray(D, [0 dw+1], 'replicate', 'pre');
D = padarray(D, [dh 0], 'replicate', 'post');

S = A + C - B - D;
% Remove padding
S = S(1+padSize(1):end - padSize(1), 1+padSize(2):end - padSize(2)); 
%}

end

