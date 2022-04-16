function [eyeMapL_output] = eyeMapL(image)

SE = strel('disk',12,8);
numerator = imdilate(image,SE);
denominator = imerode(image,SE) + 1;

eyeMapL_output = numerator./denominator;

end
