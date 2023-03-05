function [BW,maskedImage] = segmentDrink(frame,background)
    frameDiff = im2uint8(abs(frame-background));
    % imshow(abs(frame-background),"DisplayRange",[])
    thresh = multithresh(im2gray(frameDiff),2);
    labels = imquantize(im2gray(frameDiff),thresh);
    BW = labels > 2;
    
    % 穴の塗りつぶし
    BW = imfill(BW, 'holes');
    
    % default によるマスクのクローズ
    radius = 3;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW = imclose(BW, se);
    
    % default によるマスクのオープン
    radius = 4;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW = imopen(BW, se);
    
    % square によるマスクのクローズ
    width = 3;
    se = strel('square', width);
    BW = imclose(BW, se);

    maskedImage = im2uint8(frame);
    maskedImage(repmat(BW,[1,1,3])==0) = 0;
end

