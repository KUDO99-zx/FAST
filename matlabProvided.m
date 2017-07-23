pic = imread('videoShort_1_10_0.jpg');
% I = imread('cameraman.tif');
I=rgb2gray(pic);
corners = detectFASTFeatures(I);
figure(4)
imshow(I); hold on;
% plot(corners.selectStrongest(100));
plot(corners);