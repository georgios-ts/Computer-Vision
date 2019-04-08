function [Bx, By, sg] = BlobDetection(I, sigma)
% Blob Detection with Hessian.
% Input: - RGB or Grayscale Image I
%        - Scale: sigma
%
% Output: Blobs (x, y) - coordinates and scale sg.


% If image I is RGB convert to grayscale
if size(I, 3) == 3
    I = rgb2gray(I);
end

% Compute Hessian of 2-D Gaussian
ns = ceil(3*sigma)*2 + 1;
G = fspecial('gaussian', ns, sigma);
[Gx, Gy] = gradient(G);
[Gxx, Gxy] = gradient(Gx);
[~, Gyy] = gradient(Gy);

% Hessian of Image I 
Lxx = imfilter(double(I), Gxx, 'replicate');
Lyy = imfilter(double(I), Gyy, 'replicate');
Lxy = imfilter(double(I), Gxy, 'replicate');

% Blob criterion
R = Lxx .* Lyy - Lxy .* Lxy;


B = strel('disk', ns);
Rmax = max(R(:));
theta = 0.1;
C = (R == imdilate(R, B)) & (R > theta * Rmax);
[By, Bx] = find(C);
sg = sigma*ones(size(Bx));


% Optional output image B,
%  where B(i,j) = 1 if there is a blob in pixel (i,j)
if nargout < 3
    Bx = C;
end

end

