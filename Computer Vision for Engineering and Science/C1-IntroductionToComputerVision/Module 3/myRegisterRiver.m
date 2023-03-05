function registeredImage = myRegisterRiver(moving,fixed)
movingrgb = moving;
moving = im2gray(moving);
fixed = im2gray(fixed);

fixedPts = detectSURFFeatures(fixed,"NumOctaves",4);
movingPts = detectSURFFeatures(moving,"NumOctaves",4);

[fixedFeat,fixedValidPts] = extractFeatures(fixed,fixedPts);
[movingFeat,movingValidPts] = extractFeatures(moving,movingPts);

indexPairs = matchFeatures(fixedFeat,movingFeat);
fixedMatchedPts = fixedValidPts(indexPairs(:,1));
movingMatchedPts = movingValidPts(indexPairs(:,2));

tform = estgeotform2d(fixedMatchedPts,movingMatchedPts,"rigid");
registeredImage = imwarp(movingrgb,tform,"OutputView",imref2d(size(fixed)));
end