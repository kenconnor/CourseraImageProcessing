function results = crackAnalysis(im)
gs = im2gray(im);
gsf = imgaussfilt(gs,1);

thresh = multithresh(gsf,2);
levels = imquantize(gsf,thresh);
bw = levels>1;
bw = ~bw;
bw = imclose(bw,strel("disk",4,0));
bw = bwpropfilt(bw,"Area",[50,inf]);

rp = regionprops("table",bw,"Area");
distToEdge = bwdist(~bw);
maxWidth = 2 * max(distToEdge,[],"all");

results.BW = bw;
results.NumberRegions = height(rp);
results.Area = sum(rp.Area);
results.MaxWidth = maxWidth;
end