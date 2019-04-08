function edges = EdgeDetect(I, sigma, theta, LaplacType)
% Edge Detection. Choose method:
%  - 'Laplacian of Gaussian'    (LaplacType = 0)
%  - 'Morphological filtering' 


B = strel('disk', 1);
G = fspecial('gaussian', 2*ceil(3*sigma) + 1, sigma);
%Is = conv2(I, G, 'same');
Is = imfilter(double(I), G, 'replicate');

if LaplacType == 0
    h = fspecial('log', 2*ceil(3*sigma) + 1, sigma);
    L = conv2(I, h, 'same');
else
    L = imdilate(Is, B) + imerode(Is, B) - 2*Is;
end
    
X = (L >= 0);
Y = imdilate(X, B) - imerode(X, B);

[g_norm, ~] = imgradient(Is);

M = max(g_norm(:));
edges = Y & (g_norm > theta * M);

end

