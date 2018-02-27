imgsize = 512;
framenum = 1000000;

im_init = rgb2gray(imread('face.jpg'));
imshow(im_init)

im_resize = imresize(im_init,0.9);
shift_vec = (size(im_init)-size(im_resize))/2;
im_translate = imtranslate(im_resize,shift_vec,'OutputView','full');
imshowpair(im_init,im_translate)

dField = imregdemons(im_translate,im_init);

im_warp = imwarp(im_translate,dField);
imshowpair(im_warp,im_translate)
im_noise = rand(size(im_init));
dField = 0.1*dField;
dField = ceil(2*(rand([size(im_init) 3])-0.5));


im_init = (imread('face.jpg'));
for i=1:framenum
    
    ff = ceil(rand(3)-0.5);
    ff = (1/numel(find(ff)))*ff;
%     im_out = imwarp(im_init,dField);
    im_out = imfilter(im_init,ff);
%     im_out = imadjust(im_out);
    im_init = im_out;
    imshow(im_out)
%     if ~mod(i,10)
%         dField = ceil(2*(rand([size(im_init) 3])-0.5));
%         imshow(im_out)
%     end
end

