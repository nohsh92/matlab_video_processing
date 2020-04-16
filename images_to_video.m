close all; clear; clc;
%% Working out directory
% workingDir = tempname
% mkdir(workingDir)
% mkdir(workingDir, 'images')

workingDir = pwd
mkdir(workingDir, 'images')

outputDir = './output';
mkdir(outputDir);

inputVideo = VideoReader('Kakao_rotate.mp4');


%% Find Image FIle names
imageNames = dir(fullfile(workingDir,'images','*.jpg'));
imageNames = {imageNames.name}';

%% Create new video with Image Sequence
outputVideo = VideoWriter(fullfile(outputDir, 'rotated_vid'));
outputVideo.FrameRate = inputVideo.FrameRate;
% outputVideo.FileFormat = 'mp4';
open(outputVideo)
for ii = 1:length(imageNames)
    img = imread(fullfile(workingDir, 'images', imageNames{ii}));
    writeVideo(outputVideo,img)
end
close(outputVideo)

