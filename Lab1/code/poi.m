% script to check results
addpath(genpath('detectors'))

% I = imread('material/sunflowers19.png');
  I = imread('material/balloons19.png');

sg0 = 2;
r0 = 2.5;
s = 1.5;
N = 5;

% [x, y, sg] = CornerDetection(I, sg0, r0, display = 1);
% [x, y, sg] = MultiScaleCornerDetection(I, sg0, r0, s, N);

% [x, y, sg] = BlobDetection(I, sg0);
% [x, y, sg] = MultiScaleBlobDetection(I, sg0, s, N);

  [x, y, sg] = BoxBlobDetection(I, sg0);
% [x, y, sg] = MultiScaleBoxBlobDetection(I, sg0, s, N);

figure;
interest_points_visualization(I, [x, y, sg]);