function [BW,maskedImage] = segmentChipsDark(RGB)
%segmentImage イメージの領域分割アプリから自動生成されたコードを使用してイメージをセグメント化
%  [BW,MASKEDIMAGE] = segmentImage(RGB) イメージの領域分割アプリから自動生成されたコードを使用してイメージ RGB
%  をセグメント化します。最終セグメンテーションは BW で返され、マスク イメージは MASKEDIMAGE で返されます。

% Auto-generated by imageSegmenter app on 13-Feb-2023
%----------------------------------------------------


% RGB イメージを L*a*b* 色空間に変換します。
X = rgb2lab(RGB);

% 円の検索
[centers,radii,~] = imfindcircles(RGB,[15 75],'ObjectPolarity','dark','Sensitivity',0.85);
BW = false(size(RGB,1),size(RGB,2));
[Xgrid,Ygrid] = meshgrid(1:size(BW,2),1:size(BW,1));
for n = 1:numel(radii)
    BW = BW | (hypot(Xgrid-centers(n,1),Ygrid-centers(n,2)) <= radii(n));
end

% Create masked image.
maskedImage = RGB;
maskedImage(repmat(~BW,[1 1 3])) = 0;
end
