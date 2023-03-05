function snowTable = extractSnowFeatures(ds)
imgName = [];
saturationAvg = [];
saturationSTD = [];

while hasdata(ds)
    [img,info] = read(ds);
    imgHSV = rgb2hsv(img);
    imgSaturation = imgHSV(:,:,2);
    saturationAvg = [saturationAvg; mean(imgSaturation(:))];
    saturationSTD = [saturationSTD; std(imgSaturation(:))];
    [~,name,ext] = fileparts(info.Filename);
    imgName = [imgName; string(name) + string(ext)];
end

label = categorical(ds.Labels);
snowTable = table(imgName,label,saturationAvg,saturationSTD);
end