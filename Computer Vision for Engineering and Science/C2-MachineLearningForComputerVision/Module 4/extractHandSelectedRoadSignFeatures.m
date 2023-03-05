function handSelectedTable = extractHandSelectedRoadSignFeatures(imds)
numSigns = numel(imds.Files);
reset(imds);
intensityAvg = zeros([numSigns,1]);
intensitySTD = zeros([numSigns,1]);
saturationAvg = zeros([numSigns,1]);
saturationSTD = zeros([numSigns,1]);
i = 1;
while hasdata(imds)
    img = read(imds);
    imgGS = im2gray(im2double(img));
    intensityAvg(i) = mean(imgGS(:));
    intensitySTD(i) = std(imgGS(:));
    % [~,name,ext] = fileparts(info.Filename);
    imgHSV = rgb2hsv(img);
    saturationAvg(i) = mean(imgHSV(:,:,2),"all");
    saturationSTD(i) = std2(imgHSV(:,:,2));
    i = i + 1;
end
handSelectedTable = table(intensityAvg,intensitySTD,saturationAvg,saturationSTD);
end