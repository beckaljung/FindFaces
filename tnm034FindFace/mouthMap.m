function [mouth_map] = mouthMap(cr,cb)
%Return a mouth mask, with potential mouths

cr2 = power(cr,2);

numerator = (sum(cr2, 'all')); 
denominator = (sum((cr./cb), 'all'));

ita = 0.95 * (numerator./denominator);
mouth_map = cr2 .* power((cr2 - ita.*(cr./cb)), 2); 
mouth_map = mouth_map * 255;

%Dialate the elements
SE = strel('disk',7);
mouth_map = imdilate(mouth_map, SE);

mouth_map = mouth_map > 0.5; 

end

