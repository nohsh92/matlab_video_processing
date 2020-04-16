close all; clear; clc;
%% Working out directory
% workingDir = tempname
% mkdir(workingDir)
% mkdir(workingDir, 'images')

workingDir = pwd
mkdir(workingDir, 'images')

outputDir = './output'
mkdir(outputDir);

inputVideo = VideoReader('Kakao_rotate.mp4');

%% Creating Image Sequence
ii = 1;

while hasFrame(inputVideo)
    gpu_img = gpuArray(readFrame(inputVideo));
    filename = [sprintf('%09d', ii) '.jpg'];
    fullname = fullfile(workingDir, 'images', filename);
    rotatedimg = imrotate(gpu_img,90);%,'bilinear','loose');  % Rotating the Image
    imwrite(gather(rotatedimg), fullname);  % Write the rotated image to file
    ii = ii+1;    
end
