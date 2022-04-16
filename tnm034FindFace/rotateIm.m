function [rotIm,rotEye] = rotateIm(Im, Eyes, pairofeyes, r, c)
%Rotate the image so that the eyes are horizontal
Im = rgb2gray(Im);

%The angle neede to rotate the left eye in position with the left
iTan=(abs(pairofeyes(1,2)-pairofeyes(2,2)))/(abs(pairofeyes(1,1)-pairofeyes(2,1)));
degrees_to_rotateat = atand(iTan);
direction= 1;
%Wich direction the rotation is
if (pairofeyes(1,2) > pairofeyes(2,2))
    direction= -1;       %medurs
end
degrees_to_rotateat = degrees_to_rotateat * direction;

%Padd the image so that the right eye is placed in the middle of the image
rightN= c-pairofeyes(1,1);
paddN = abs(round(rightN-pairofeyes(1,1)));
rightM = r-pairofeyes(1,2);
paddM = abs(round(rightM-pairofeyes(1,2)));

paddIm = padarray(Im,[paddM,paddN],0,'pre');
paddEyes = padarray(Eyes,[paddM, paddN],0,'pre');

%Rotate the padded image and the eye mask
rotIm  = imrotate(paddIm,degrees_to_rotateat, 'bicubic','crop');
rotEye = imrotate(paddEyes,degrees_to_rotateat,  'bicubic', 'crop');

end

