function [Cx, Cy, sg] = CornerDetection(I, sigma, r, display)
% Corner Detection with Harris - Stephen method.
% Input: - RGB or Grayscale Image I
%        - Scales: sigma and r
%        - 'display' flag if you want a picture of l+ and l- 
%          (default value 0)
%
% Output: Corners (x, y) - coordinates and scale sg.

if nargin > 3
    displayFlag = display;
else
    displayFlag = 0;
end


% If image I is RGB convert to grayscale
if size(I, 3) == 3
    I = rgb2gray(I);
end

% Smooth input image.
Is = imgaussfilt(double(I), sigma);

% Compute gradient and the elements of tensor J.
[Gx, Gy] = imgradientxy(Is);

J1 = imgaussfilt(double(Gx.^2), r);
J2 = imgaussfilt(double(Gx.*Gy), r);
J3 = imgaussfilt(double(Gy.^2), r);

% Find eigenvalues.
l_plus = 0.5 * (J1 + J3 + sqrt((J1 - J3).^2 + 4*(J2.^2)));
l_minus = 0.5 * (J1 + J3 - sqrt((J1 - J3).^2 + 4*(J2.^2)));

% Cornerness Criterion R - Choose local maxima above a threshold value
k = 0.05;
R = l_plus .* l_minus - k * (l_plus + l_minus).^2;

ns = ceil(3*sigma)*2 + 1;
B = strel('disk', ns);
Rmax = max(R(:));
theta = 0.005;
C = (R == imdilate(R, B)) & (R > theta * Rmax);
[Cy, Cx] = find(C);
sg = sigma*ones(size(Cx));


% Optional output image C,
%  where C(i,j) = 1 if there is a corner in pixel (i,j)
if nargout < 3
    Cx = C;
end

if displayFlag
    figure
    imshow(l_plus, [])
    figure;
    imshow(l_minus, [])
end



end

