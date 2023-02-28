function Explore_colorspaces( digital_im )
%Explore_colorspaces Exploration of the image in 9 different channels in 3 
% color spaces
%   
% The channels explored here are respective channels in RGB, HSV, L*a*b
% This function assumes that the initial image is in RGB colorspace. 

d_im = digital_im;


figure;
plot_cntr = 1;
subplot(3,3,plot_cntr);
imshow(d_im(:,:,1));
axis image;
title("(RGB) Red channel")
plot_cntr = plot_cntr + 1;

subplot(3,3,plot_cntr);
imshow(d_im(:,:,2));
axis image;
title("(RGB) Green channel")
plot_cntr = plot_cntr + 1;

subplot(3,3,plot_cntr);
imshow(d_im(:,:,3));
axis image;
title("(RGB) Blue channel")
plot_cntr = plot_cntr + 1;

% Convertion: RGB to HSV
hsv_im = rgb2hsv(d_im);

subplot(3,3,plot_cntr);
imshow(hsv_im(:,:,1));
axis image;
title("(HSV) Hue channel")
plot_cntr = plot_cntr + 1;

subplot(3,3,plot_cntr);
imshow(hsv_im(:,:,2));
axis image;
title("(HSV) Saturation channel")
plot_cntr = plot_cntr + 1;

subplot(3,3,plot_cntr);
imshow(hsv_im(:,:,3));
axis image;
title("(HSV) Value channel")
plot_cntr = plot_cntr + 1;


% Convertion: RGB to LAB
lab_img = rgb2lab(d_im);

subplot(3,3,plot_cntr);
imshow(lab_img(:,:,1));
axis image;
title("(LAB) Lightness channel")
plot_cntr = plot_cntr + 1;

subplot(3,3,plot_cntr);
imshow(lab_img(:,:,2));
axis image;
title("(LAB) Red/Green channel")
plot_cntr = plot_cntr + 1;

subplot(3,3,plot_cntr);
imshow(lab_img(:,:,3));
axis image;
title("(LAB) Blue/Yellow channel")
end