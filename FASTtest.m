clear all;
% close all;
%%
% img = imread('pittsburgh.png');
img = imread('videoShort_1_10_0.jpg');
% img = imread('cameraman.tif');
[x,y] = FAST(img,100,false);
title('no selection');