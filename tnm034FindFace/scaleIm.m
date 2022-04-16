function [scaledIm, scaledEyes, decidedDistEyes] = scaleIm(Im, Eyes)
%Scale the image and the eye mask

%Find the centroids in the eye mask
 L = bwlabel(Eyes);
 Stats = regionprops(L, 'Centroid');
 centroids= zeros(length(Stats),2);
for i=1: length(Stats)
    centroids(i,1)= Stats(i).Centroid(1);
    centroids(i,2)= Stats(i).Centroid(2);
end

%The distance between the eyes
distEyes = sqrt(((centroids(1,1) - centroids(2,1))^2 + (centroids(1,2) - centroids(2,2))^2));

%The pre decided distance between the two eyes
decidedDistEyes = 94; 

%Scale the image and the eye mask with the scalfactor
scaleFactor = decidedDistEyes/distEyes;
scaledIm = imresize(Im, scaleFactor, 'bicubic');
scaledEyes = imresize(Eyes, scaleFactor, 'bicubic');

end

