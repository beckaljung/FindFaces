function [mask] = eyeMap(eyeC, eyeL)

eye = eyeC .* eyeL; 

SE2=strel('disk',1);
eye = imerode(eye, SE2);
SE2=strel('disk',10);
eye = imdilate(eye, SE2);

mask = eye > 0.4; 

end

