% video feedback
% initial grayscale image is put through feedback loop with custom defined
% transformations and normalization; edit parameters and run as script
% parameters
imgsize = 256;      
framenum = 1000;    % number of frames
scale = .3;         % ratio for combining output and input frames
disp=1;             % 1 to display output in real time, 0 to omit
write_video=1;      % 1 to write output video
exponent = 1.5;     % sharpening factor to avoid blurring
a=0.2;              % for blurring filter; higher value = more blur
theta = 17;         % rotation for each iteration - very important for good feedback
zoom_scale = 1.00;  % zoom for each iteration
thresh_high=0.9;    % threshold for output display
thresh_low = 0;
p_size = 1;         % not sure what this was for
thickness = 5;      % parameter for initial image generation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

im_init = zeros(imgsize);

% make line
offset = 0;
im_half = round(imgsize/2);

im_init(1:imgsize,im_half+offset:im_half+offset+thickness) = 1;
% %make box
im_init(im_half:end,im_half:end) = 1;
im_init(1:im_half,1:im_half) = 1;

% im_init = rand(imgsize);

imshow(im_init)
im_input = imrotate(im_init,10,'crop');


%filter
% X = fspecial('sobel');

X = [a a a; a 1-a a; a a a];
% X = [0 a 0;a 10*a a;0 a 0];
shift = 6;
shiftSize=im_half-shift;

im_diff = round(imgsize*zoom_scale)-imgsize;
im_start = round(im_diff/2);
vr = VideoWriter('test1.avi');
video_out = zeros(imgsize,imgsize,framenum);


for i=1:framenum
    if ~mod(i,100)
        fprintf('%d\n',i)
    end
%     theta = i;
    im_out = imrotate(im_input,theta, 'bilinear', 'crop');
    %shift
%     imshift = im_out(im_half+shift:im_half+shiftSize+shift,im_half+shift:im_half+shiftSize+shift);
%     im_out(im_half:im_half+shiftSize,im_half:im_half+shiftSize) = imshift;

    %zoom
    im_large = imresize(im_out,zoom_scale);
    im_out = im_large(im_start+1:imgsize+im_start,im_start+1:imgsize+im_start);
    im_out = single(abs(im_out));
    im_out=imfilter(im_out.^exponent,X);
    
    m=max(im_out);
    mm=max(m);
    %perturbation - define warp transform as tf
%     if ~mod(i,15)
% %         im_out(im_half,im_start+1:imgsize)=1;
% % %         theta=-theta;
%         im_out = imtransform(im_out,tf);
%         im_out(imgsize+1:end,:)=[];
%         im_out(:,imgsize+1:end)=[];
%     end
%     
%     
%     im_out = im_out./mm;
%     im_out(im_out>thresh_high)=1;
%     im_out(im_out<thresh_low)=0;
    im_input = normc(im_out+scale*im_input);
    im_input = normr(im_input);
    im_input = imadjust(im_input);
%     im_input = im_out+scale*im_input;
    if disp==1
        
        imshow(im_out,[]);
    end
    video_out(:,:,i) = im_out;
    
end
if write_video==1
    m=max(video_out);
    mm=max(m);
    mmm=max(mm)
    video_out = video_out./mmm;
    vr = VideoWriter('1_3.mp4','MPEG-4');
    open(vr);
    for i=1:framenum
        writeVideo(vr,video_out(:,:,i));
    end
    close(vr);
end