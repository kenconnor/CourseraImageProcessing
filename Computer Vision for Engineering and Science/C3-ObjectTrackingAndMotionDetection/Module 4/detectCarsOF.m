function [maskLeft,maskRight,of] = detectCarsOF(frame,of)
flow = estimateFlow(of,im2gray(frame));
magThresh = 0.5;
VxThresh = 0.5;
mask = (flow.Magnitude > magThresh);
se = strel("disk",3,0);
mask = imopen(mask,se);
se = strel("disk",10,0);
mask = imclose(mask,se);
mask = imfill(mask,"holes");
mask = bwareafilt(mask,[5000,Inf]);

maskLeft = mask & (flow.Vx < -VxThresh);
maskLeft = bwareafilt(maskLeft,[1000,Inf]);
maskRight = mask & (flow.Vx > VxThresh);
maskRight = bwareafilt(maskRight,[1000,Inf]);

detectionsLeft = [];
detectionsRight = [];
end