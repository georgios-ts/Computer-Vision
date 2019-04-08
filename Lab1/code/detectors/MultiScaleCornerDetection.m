function [cx, cy, sg] = MultiScaleCornerDetection(I, sg0, r0, s, N)
% Multi Scale Corner Detection with Harris -  Laplacian method.
% Input: - RGB or Grayscale Image I
%        - Initial Scales sg0, r0
%        - Scale Parameter s
%        - Number of different scales N
%
% Output: corners (cx, cy) - coordinates and the scale sg that were detected.


% If image I is RGB convert to grayscale
if size(I, 3) == 3
    I = rgb2gray(I);
end

LoG = zeros([size(I) N+2]); % 2 extra dummy 'layers' for (islocalmax) to work as desired
C = zeros([size(I) N]); 

for i = 0:N-1
    sigma = s^i * sg0;
    r = s^i * r0;
    
    h = fspecial('log', 2*ceil(3*sigma) + 1, sigma);
    L = conv2(I, h, 'same');
    LoG(:,:,i+2) = sigma*abs(L);
    
    C(:,:,i+1) = CornerDetection(I, sigma, r);
end

localmax = islocalmax(LoG, 3);
poi = C & localmax(:,:,2:N+1); 
[cy, cx, k] = ind2sub(size(LoG), find(poi));
sg = (s.^(k-1))*sg0;

end

