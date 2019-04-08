% script to check results
addpath(genpath('detectors'))

%%%%%%%%%%  ------- Test Image ------    %%%%%%%%%%%


Io = imread('material/edgetest_19.png');

% add noise to the original image
PSNR = 20;
mean = 0;
sigma = 1 / (10^(PSNR/20));
I = imnoise(Io, 'gaussian', mean, sigma^2); 



% 'Real' edges
threshold = 50;
B = strel('disk', 1);
T = (imdilate(Io, B) - imerode(Io, B)) > threshold;


% Linear %
sigma = 1.5;
theta = 0.2;
D1 = EdgeDetect(I, sigma, theta, 0); 

precision = sum(T(:) & D1(:)) / sum(T(:));
recall = sum(T(:) & D1(:)) / sum(D1(:));
C = (precision + recall) / 2;
disp('Quality with Laplacian of Gaussian Method');
disp(C);

% Non - Linear %
sigma = 1.9;
theta = 0.2;
D2 = EdgeDetect(I, sigma, theta, 1); 


precision = sum(T(:) & D2(:)) / sum(T(:));
recall = sum(T(:) & D2(:)) / sum(D2(:));
C = (precision + recall) / 2;
disp('Quality with Morphological Filtering');
disp(C);




% figures %
figure()
imshow(Io);
title('Original Image');
%print -dpng  ./report/images/original.png


figure()
imshow(I);
title('Noisy Image');
print -dpng  ./report/images/noisy.png


figure()
imshow(T == 0)
title('Real Edges');
%print -dpng  ./report/images/realEdges.png

figure()
imshow(D1 == 0)
title('Laplacian of Gaussian Method');
%print -dpng  ./report/images/LoG.png

figure()
imshow(D2 == 0)
title('Morphological Filtering');
%print -dpng  ./report/images/Morph.png




%%%%%%%%%%  ------- Real Image ------    %%%%%%%%%%%

I = imread('material/venice_edges.png');

sigma = 2.3;
theta = 0.2;
D1 = EdgeDetect(I, sigma, theta, 0);

sigma = 3;
theta = 0.2;
D2 = EdgeDetect(I, sigma, theta, 1);

figure()
imshow(I);
title('Original Image');
%print -dpng  ./report/images/venice.png

figure()
imshow(D1 == 0)
title('Laplacian of Gaussian Method');
%print -dpng  ./report/images/LoG3b.png

figure()
imshow(D2 == 0)
title('Morphological Filtering');
%print -dpng  ./report/images/Morph3b.png






