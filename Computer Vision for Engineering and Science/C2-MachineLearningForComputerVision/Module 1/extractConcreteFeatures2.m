function concreteTable = extractConcreteFeatures2(dsTrain)
%%
imgName = [];
intensityAvg = [];
intensitySTD = [];
while hasdata(dsTrain)
    [img,info] = read(dsTrain);
    img = im2gray(im2double(img));
    intensityAvg = [intensityAvg; mean(img(:))];
    intensitySTD = [intensitySTD; std(img(:))];
    [~,name,ext] = fileparts(info.Filename);
    imgName = [imgName; string(name) + string(ext)];
end

label = dsTrain.Labels;
concreteTable = table(label, imgName, intensityAvg, intensitySTD);
end