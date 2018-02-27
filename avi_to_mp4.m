vr=VideoReader('3.avi');

video=read(vr);

video_size = size(video);
%%
vr_out = VideoWriter('out_slow','MPEG-4');

vr_out.FrameRate=5;
open(vr_out);

for i=1:video_size(4)
    currFrame=imresize(video(:,:,:,i),0.5);
    writeVideo(vr_out,currFrame);
    
end



close(vr_out);
