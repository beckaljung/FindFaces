function [cropedIm] = cropIm(Im, Eyes, decidedEyeAvstand)
% crop the image and set the eyes in the same postion for every image

%Find the two eyes and their centroids
 L = bwlabel(Eyes);
 Stats = regionprops(L, 'Centroid');
 centroids= zeros(length(Stats),2);
for i=1: length(Stats)    
    centroids(i,1)= Stats(i).Centroid(1);
    centroids(i,2)= Stats(i).Centroid(2);
end

%Find wich eye is the left one
leftEyeCent= [10000.0, 0.0];
for i=1:2
    if(centroids(i,1) < leftEyeCent(1))
        leftEyeCent(1)= centroids(i,1);
        leftEyeCent(2)= centroids(i,2);
    end
end

% Size of the croped image.
wantedM= 250;
wantedN= 250;

%Find the wanted postion for the left eye in x
wantedPosX= (wantedN/2)-(decidedEyeAvstand/2);
column= round(leftEyeCent(1)- wantedPosX);

%The wanted position for the left eye in y
wantedPosY= 110;
row= round(leftEyeCent(2)- wantedPosY);

%Crop and normalize the image
cropedIm = imcrop(Im, [column row wantedM wantedN]);
cropedIm = rescale(cropedIm); 
 
end

