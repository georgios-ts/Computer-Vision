function [Bx, By, sg] = MultiScaleBlobDetection(I, sg0, s, N)
% Multi Scale Blob Detection with Hessian - Laplace method.
% Input: - RGB or Grayscale Image I
%        - Initial Scales sg0
%        - Scale Parameter s
%        - Number of different scales N
%
% Output: corners (Bx, By) - coordinates and the scales sg that were detected.

% If image I is RGB convert to grayscale
if size(I, 3) == 3
    I = rgb2gray(I);
end

LoG = zeros([size(I) N+2]); % 2 extra dummy 'layers' for (islocalmax) to work as desired
B = zeros([size(I) N]); 

for i = 0:N-1
    sigma = s^i * sg0;
    
    h = fspecial('log', 2*ceil(3*sigma) + 1, sigma);
    L = conv2(I, h, 'same');
    LoG(:,:,i+2) = sigma*abs(L);
    
    B(:,:,i+1) = BlobDetection(I, sigma);
end

localmax = islocalmax(LoG, 3);
poi = B & localmax(:,:,2:N+1); 
[By, Bx, k] = ind2sub(size(LoG), find(poi));
sg = (s.^(k-1))*sg0;

end

