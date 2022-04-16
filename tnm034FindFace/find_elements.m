function [pairofeyes, L_e] = find_elements(mouth, eye, width, height)
%Find the stel elements int the mouth mask ans props for them
L_m = bwlabel(mouth);
Stats_mouth = regionprops(L_m, 'Area', 'Orientation');% Create struct with relevant object properties

for i=1: length(Stats_mouth)
    Area_m(i)=Stats_mouth(i).Area;
    Orientation_m(i)= Stats_mouth(i).Orientation; 
end

[r, c]= size(L_m);

%Creat empty masks for the potential eyes and mouths
eyes=zeros(r,c); 
mouths=zeros(r,c);

%interval for the mouths areas
lower_m = 1000; 
upper_m = 9090; 

%Find the moths with the searched area and orientation
find_m=find(Area_m > lower_m & Area_m < upper_m);
number_of_mouths = size(find_m, 2);

if(number_of_mouths > 1)
    find_m=find(Area_m > lower_m & Area_m < upper_m & Orientation_m > -21 & Orientation_m < 21);
end

%Find the centroids for the mouth elements
allcentroid_m=[length(find_m), 2];

for i= 1:length(find_m)
    elements_m =zeros(r,c);
    elements_m(L_m == find_m(i)) = 1;
    s_m = regionprops(elements_m,'Centroid');
    centroids2 = cat(1,s_m.Centroid);
    allcentroid_m(i,1) = centroids2(1,1);
    allcentroid_m(i,2) = centroids2(1,2);
    mouths(L_m == find_m(i)) = 1;
end

%Incase there are more then one mouth found, find the true mouth
numberof_m = size(find_m, 2); 
truemouth = zeros(1,2);
index = 0; 
maxy_m = 0;

if(numberof_m > 1) 
   for i = 1:numberof_m
       if(maxy_m < allcentroid_m(i,2))
           maxy_m = allcentroid_m(i,2);
           index = i; 
        end
    end
    truemouth(1,1) = allcentroid_m(index,1);
    truemouth(1,2) = maxy_m;
else
    truemouth= allcentroid_m;
end


% Cut away some of the eye elemets in the eye mask with help of the mouth
posy = truemouth(1,1);
posx = truemouth(1,2);

for i = 1:width
    for j = 1:height
        if(i > posx && j >= posy)
            eye(i,:) = 0;
        end
    end
end

%Find the elments in the eye mask and their area
L_e = bwlabel(eye); 
Stats_eye = regionprops(L_e, 'Area');
for i= 1: length(Stats_eye)
    Area_e(i)=Stats_eye(i).Area;
end

%The intervall for area of potentiall eyes
lower_e = 300;
upper_e = 5350; 

%Find the eye elements with area in the right intervall
findEyes= find(Area_e > lower_e  & Area_e <= upper_e);
allCentroid_e=[length(findEyes), 2];

for i= 1:length(findEyes)
    elements_e =zeros(r,c);
    elements_e(L_e == findEyes(i)) = 1;
    s_e = regionprops(elements_e,'Centroid');
    centroids_e = cat(1,s_e.Centroid);
    allCentroid_e(i,1)= centroids_e(1,1);
    allCentroid_e(i,2) =centroids_e(1,2);
    eyes(L_e == findEyes(i)) = 1;
end 

%Find the true eyes
number_of_eyes = size(findEyes, 2);
[m,n]= size(allCentroid_e);

dist_eye_mouth= zeros(m,1);
diff_eye_mouth = 100;
ydiff_eyes = 100;
dist=10000;
nr_ofpairs = 1; 
xdiff_eyes = 0; 

found = 0;

if(number_of_eyes>1)
    for i=1:length(allCentroid_e)
        dist_eye_mouth(i,1)= abs(truemouth(1,1)-allCentroid_e(i,1));
    end
    
    for i=1:length(dist_eye_mouth)
        for j=1:length(dist_eye_mouth)
            if(i~=j)
                diff_eye_mouth = abs(dist_eye_mouth(i,1)- dist_eye_mouth(j,1));
                ydiff_eyes = abs(allCentroid_e(i,2) - allCentroid_e(j,2));
                xdiff_eyes = abs(allCentroid_e(i,1)-allCentroid_e(j,1)); 
                %Condidtions for a possible pair of eyes
                if diff_eye_mouth < 57 && dist > (dist_eye_mouth(i,1) + dist_eye_mouth(j,1))/2  && ydiff_eyes < 23 && allCentroid_e(j,2) > 190 && xdiff_eyes < 200 && xdiff_eyes > 70
                    found = 1; 
                    eye1(nr_ofpairs) = i;
                    eye2(nr_ofpairs) = j;
                    nr_ofpairs = nr_ofpairs +1; 
                    dist = (dist_eye_mouth(i,1) + dist_eye_mouth(j,1))/2;
                end
            end
        end
    end
end

%Incase there are more than one pair of eyes that could be the true eyes
if(nr_ofpairs > 2)
    %Incase the left eye is the same for both of the pair
    if(eye2(1) == eye2(2))
        eye2 = eye2(1); 
        if(allCentroid_e(eye1(1),1) > allCentroid_e(eye1(2),1))
            eye1 = eye1(1); 
        else
            eye1 = eye1(2); 
        end
    %If their are two pairofeyes with different numbers, take the first
    %one, the one that is furthest down in the image
    else
        eye1 = eye1(1); 
        eye2 = eye2(1);
    end
end

%Incase two eyes where found, otherwise pairofyes will be zeros
pairofeyes= zeros(2,2);
if(found == 1)
    pairofeyes(1,1) = allCentroid_e(eye1,1);
    pairofeyes(1,2) = allCentroid_e(eye1,2);
    pairofeyes(2,1) = allCentroid_e(eye2,1);
    pairofeyes(2,2) = allCentroid_e(eye2,2);
end
end

