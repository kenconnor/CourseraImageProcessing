function [BW,maskedImage] = segmentCurling(X)
%segmentImage イメージの領域分割アプリから自動生成されたコードを使用してイメージをセグメント化
%  [BW,MASKEDIMAGE] = segmentImage(X) イメージの領域分割アプリから自動生成されたコードを使用してイメージ X
%  をセグメント化します。最終セグメンテーションは BW で返され、マスク イメージは MASKEDIMAGE で返されます。

% Auto-generated by imageSegmenter app on 02-Mar-2023
%----------------------------------------------------
XRGB = X;
X = im2gray(X);

% 空のマスクを作成
BW = false(size(X,1),size(X,2));

% イメージのしきい値処理 - 適応しきい値
BW = imbinarize(X, 'adaptive', 'Sensitivity', 0.420000, 'ForegroundPolarity', 'dark');

% マスクの反転
BW = imcomplement(BW);

% 穴の塗りつぶし
BW = imfill(BW, 'holes');

% default によるマスクのクローズ
radius = 20;
decomposition = 0;
se = strel('disk', radius, decomposition);
BW = imclose(BW, se);

% Create masked image.
maskedImage = XRGB;
maskedImage(repmat(~BW,[1,1,3])) = 0;
end
