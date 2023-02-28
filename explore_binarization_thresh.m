function explore_binarization_thresh(im)
    cntr = 0;
    figure
    for i=0.1:0.1:1
        cntr = cntr + 1;
        bw = imbinarize(im(:,:,1), i);
        subplot(2,5,cntr);
        imshow(bw)
        title(sprintf("Binarizing by level: %.3f", i));
    end
end