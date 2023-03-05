function results = crackAnalysys_example(img)
%crackAnalysis segments and analyzes an image from the concrete crack dataset.
%  
%  results = crackAnalysis(img) preprocesses, segments, and analyzes image img. 
%  results, is returned as a structure array with 4 fields:
%  BW, the final black and white mask.
%  NumRegions, the number of individual regions in the mask.
%  Area, the total area in number of pixels of all regions.
%  MaxWidth, the maximum width in number of pixels of all regions.
%----------------------------------------------------

%Preprocessing
%  Convert the input image to grayscale and apply a Gaussian filter to
%  smooth rough concrete textures.
gs = im2gray(img);
gsf = imgaussfilt(gs,1);

%Segmentation
%  Apply multi-level thresholding to distinguish dark cracks from
%  textured concrete. Then morphologically close the mask,
%  and finally filter out all regions below a cutoff size.
thresh = multithresh(gsf,2);
levels = imquantize(gsf,thresh);
bw = levels>1;
bw = ~bw;
bw = imclose(bw,strel("disk",4,0));
bw = bwpropfilt(bw,"Area",[50,inf]);

%Region Analysis
%  Calculate the area of all regions in the mask, then
%  compute the distance from each foreground "crack" pixels to the
%  nearest background pixel.
rp = regionprops("table",bw,"Area");
distToEdge = bwdist(~bw);
maxWidth = 2 * max(distToEdge,[],"all");

%Results
%  Append the results to the returned structure array variable.
results.BW = bw;
results.NumRegions = height(rp);
results.Area = sum(rp.Area);
results.MaxWidth = maxWidth;
end