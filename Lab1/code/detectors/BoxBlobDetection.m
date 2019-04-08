function [Bx, By, sg] = BoxBlobDetection(Image, sigma)
% Blob Detection by approximating Hessian with Box Filters.
% Input: - RGB or Grayscale Image I
%        - Scale: sigma
%
% Output: Blobs (x, y) - coordinates and scale sg.


% If image I is RGB convert to grayscale
if size(Image, 3) == 3
    Image = rgb2gray(Image);
end

ns = ceil(3*sigma)*2 + 1;
h = 4*floor(ns/6) + 1;
w = 2*floor(ns/6) + 1;

% 'displacements' 
dw = (w - 1)/2;
dh = (h - 1)/2;

% Some padding first to avoid 'artifacts' on the image border.
padSize = [dh dh] + 1;
paddedImage = padarray(Image, padSize, 'replicate','both');

% Integral Image
I = cumsum(cumsum(double(paddedImage),1),2);

Sx  = boxFilt(I, h, w, padSize); 
Sy  = boxFilt(I, w, h, padSize);  
Sxy = boxFilt(I, w, w, padSize); 

Dxx = shift(Sx, -w, 2) + shift(Sx, w, 2) - 2*Sx;
Dyy = shift(Sy, -w, 1) + shift(Sy, w, 1) - 2*Sy;

a = dw + 1;
Dxy = shift2(Sxy, a, a) + shift2(Sxy, -a, -a) - shift2(Sxy, a, -a) - shift2(Sxy, -a, a);


R = Dxx .* Dyy - (0.9)^2 * Dxy .* Dxy;


B = strel('disk', ns);
Rmax = max(R(:));
theta = 0.05;
C = (R == imdilate(R, B)) & (R > theta * Rmax);
[By, Bx] = find(C);

sg = sigma*ones(size(Bx));


% Optional output image B,
%  where B(i,j) = 1 if there is a blob in pixel (i,j)
if nargout < 3
    Bx = C;
end


end

