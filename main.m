%%
%
% Create directory for figures
%

mkdir("figs");


%% 
% 
% Reading image
%
filename = "bbb_2.jpeg";
im = im2double(imread(filename));
figure, imshow(im);

fig_id = 0;
saveas(gcf ,sprintf('figs/FIG_%d.png',fig_id));

%% 
% 
% Explore histogram equilizer 
%
enhanced_bbb = histeq(im, 10);
figure, imshow(enhanced_bbb);
gray_bbb = im2gray(enhanced_bbb);

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d.png',fig_id));

%%
%
% Exploring the image in different colorspaces
% 
explore_colorspaces(im)

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d.png',fig_id));

%%
%
% Green looks with the most distinguishable features
%

subplot(2,2,1)
im_gray = im(:,:,2);
im_gray = 1 - im_gray;
imshow(im_gray);

subplot(2,2,3)
imhist(im_gray);

subplot(2,2,2);
imshow(imadjust(im_gray));

subplot(2,2,4)
imhist(imadjust(im_gray));
adjust_im = imadjust(im_gray);

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d.png',fig_id));

%%
%
% Explore different levels of binarization
%
explore_binarization_thresh(adjust_im)

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d.png',fig_id));

%%
%
% Segment out the white space in the background
%
level = 0.4;
segmentation = imbinarize(adjust_im, level);
figure, imshow(segmentation)

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d.png',fig_id));

%%
%
% Label all the segmented cells
%
[bw, n] = bwlabel(segmentation);
figure, imagesc(bw);
title("Segmented out cells", n)
colorbar
axis image
n

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d.png',fig_id));

%% 
% 
% Post Processing - Clear out objects with areas smaller than 100 
%

bw_postprocessed = bwareaopen(segmentation, 100);

[bw, n] = bwlabel(bw_postprocessed);
figure, imagesc(bw)
title("PROCESSED: Segmented out cells", n)
colorbar
axis image
n

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d.png',fig_id));

%% 
%
% Find orientation
%
res = regionprops(bw, "Area", "Orientation");

resOrientation = zeros(1,n);
for i = 2:n
    resOrientation(i) = res(i).Orientation;
end

%%
%
% Save histogram of orientation
%

figure, histogram(resOrientation, 75)
title("Distribution of orientation")
xlabel("Degree")
ylabel("Cell number")

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d.png',fig_id));