%%
%
% Create directory for figures
%

mkdir("figs");
close all
clear
%% 
% 
% Reading image
%
SHOW_FIGURE = false;
data_folder = "./data/";
filename = "1-after flow-4x";
im = im2double(imread(data_folder + filename + ".JPG"));
im = imrotate(im, 90);
figure, imshow(im);

fig_id = 0;
saveas(gcf ,sprintf('figs/FIG_%d_%s.png',fig_id, filename));

%%
%
% Remove black box behind
%

im_red= im(:,:,1);
relevant_pixels = im_red > 0.5;
% relevant_pixels = imdilate(relevant_pixels, strel( "disk", 2));

%% 
% 
% Explore histogram equilizer 
%
% enhanced_bbb = histeq(im, 10);
% figure, imshow(enhanced_bbb);
% gray_bbb = im2gray(enhanced_bbb);
% 
% fig_id = fig_id + 1;
%  saveas(gcf ,sprintf('figs/FIG_%d_%s.png',fig_id, filename));

%%
%
% Exploring the image in different colorspaces
% 
explore_colorspaces(im)

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d_%s.png',fig_id, filename));

%%
%
% Green looks with the most distinguishable features
%

subplot(2,2,1)
im_gray = im(:,:,2) .* relevant_pixels;
im_gray = (1 - im_gray);
imshow(im_gray);
title("Inverted [Green] Grayscale - A")

subplot(2,2,3)
imhist(im_gray);
title("Histogram of values of figure A")

subplot(2,2,2);

adjust_im = imadjust(adapthisteq(im_gray));
imshow(adjust_im);
title("Adjusted values of figure A")

subplot(2,2,4)
imhist(adjust_im);
title("Histogram of adjusted values of figure A")


fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d_%s.png',fig_id, filename));

%%
%
% Explore different levels of binarization
%
explore_binarization_thresh(adjust_im)

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d_%s.png',fig_id, filename));

%%
%
% Segment out the white space in the background
%

level = 0.731;
segmentation = imbinarize(adjust_im, level);
figure, imshow(segmentation)

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d_%s.png',fig_id, filename));

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
 saveas(gcf ,sprintf('figs/FIG_%d_%s.png',fig_id, filename));

%% 
% 
% Post Processing 
%

% Clear out objects with areas smaller than 100
bw_postprocessed = bwareaopen(segmentation, 200);

% Clear out objects with areas greater than 2500
bw_postprocessed = bwareaopen(1-bw_postprocessed, 2500);

% Invert back to normal
bw_postprocessed = 1-bw_postprocessed;

[bw, n] = bwlabel(bw_postprocessed);
figure, imagesc(bw)
title("PROCESSED: Segmented out cells: "  + n)
colorbar
axis image
n

fig_id = fig_id + 1;
saveas(gcf ,sprintf('figs/FIG_%d_%s.png',fig_id, filename));

%%
%
% Sanity-check - Making sure that what is considered a cell, is actually a
% cell
%
sanity_checker = labeloverlay(im_gray, bw, 'Transparency',0.25);
figure, imshow(sanity_checker)
title("PROCESSED: Segmented out cells: " + n)
%% 
%
% Find orientation
%
res = regionprops(bw, "Area", "Orientation");

resOrientation = zeros(n, 1);
for i = 1:n
    if res(i).Orientation < 0
        resOrientation(i) = res(i).Orientation + 180;
    else 
        resOrientation(i) = res(i).Orientation; 
    end
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
 saveas(gcf ,sprintf('figs/FIG_%d_%s.png',fig_id, filename));