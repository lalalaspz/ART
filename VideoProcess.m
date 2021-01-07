function [images,fn]=VideoProcess(filename)

video1=VideoReader(filename); 
numFrames=video1.NumberOfFrames; 
FrameReadNum=numFrames; 
fn=numFrames;
for k=1:FrameReadNum;
    frame=255-read(video1,k);
    frame=double(frame);
    images(:,:,k)=frame;
end
end