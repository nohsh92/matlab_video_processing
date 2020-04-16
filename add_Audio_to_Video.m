close all; clear; clc;
%% Working out directory
% workingDir = tempname
% mkdir(workingDir)
% mkdir(workingDir, 'images')

workingDir = pwd
mkdir(workingDir, 'images')

outputDir = './output';
mkdir(outputDir);

referenceVideo = VideoReader('Kakao_rotate.mp4');
inputVideoPath = fullfile(outputDir,'/rotated_vid.avi');

%% Extract Audio
[input_audio, Fs] = audioread('Kakao_rotate.mp4');
audiowrite('audio_file.WAV', input_audio, Fs);


%% Add video and audio together
video_filename = inputVideoPath;
audio_filename = 'Kakao_rotate.mp4';
out_filename = 'newvideo.avi';
videoFReader = VideoReader(video_filename);
FR = videoFReader.FrameRate;
[AUDIO,Fs] = audioread(audio_filename);
SamplesPerFrame = floor(Fs/FR);
videoFWriter = vision.VideoFileWriter(out_filename, 'AudioInputPort', true, 'FrameRate', FR);
videoframes = read(videoFReader);    %reads all frames, not recommended in current MATLAB
for framenum = 0 : size(videoframes, 4)-1
   videoFrame = videoframes(:,:,:,framenum+1);
   this_audio = AUDIO(framenum*SamplesPerFrame + 1 : min(end, (framenum+1)*SamplesPerFrame), :);
   if size(this_audio,1) < SamplesPerFrame
       this_audio(SamplesPerFrame,:) = 0; %zero pad short frames
   end
   step(videoFWriter, videoFrame, this_audio);
end
delete(videoFReader);
release(videoFWriter);