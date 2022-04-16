function [Imcroped] = ImChanges(Im)
%Return a croped image and color corrected image

%Color correctd and change colorspace of the image
Im = im2double(Im);
Im1 = AWB(Im);
Im2 = Im1./max(max(Im1)); 
YCbCr = rgb2ycbcr(Im2);

Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2); 
Cr = YCbCr(:,:,3); 

%------------EYE MAP----------------------
eyeC = eyeMapC(Cb, Cr);
eyeC = imadjust(eyeC,stretchlim(eyeC),[]);
eyeL = eyeMapL(Y);
eye = eyeMap(eyeC, eyeL);
%------------MOUTH MAP----------------------
mouth = mouthMap(Cr,Cb);
mouth = bwareaopen(mouth, 1000);
[r, c] = size(mouth); 

%------------CUT AWAY FROM THE EYE AND MOUTH MAP----------------------
for i = 1:r
    for j = 1:c
        if(i < 290)
            mouth(i,:) = 0;
        end
        if(j < 75)
            eye(:,j) =  0; 
            mouth(:,j) =  0; 
        end
        if(i < 100)
            eye(i,:) = 0;
        end 
        if(j > 300 )
            mouth(:,j) =  0; 
        end
        if(i > 300) 
         eye(i,:) = 0;   
        end    
    end
end 

%------------Find the postions of the eyes----------------------
[pairofeyes, L] = find_elements(mouth, eye, r, c); 
%If no pair of eyes were found
if(pairofeyes(1,1) == 0 && pairofeyes(1,2) == 0 && pairofeyes(2,1) == 0 && pairofeyes(2,2) == 0 )
    Imcroped = zeros(251,251); 
else
%---------------CLEAR EYE MASK----------------
clear_eye_maskIM = clear_eye_mask(L, pairofeyes, r, c);
%---------------ROTATION----------------------
[rotatedIM, rotatedEye] = rotateIm(Im2, clear_eye_maskIM, pairofeyes, r, c);
%---------------SCCALE------------------------
[scaledIM, scaledEyes, decidedEyeAvstand] = scaleIm(rotatedIM, rotatedEye);
%---------------CROP--------------------------
[Imcroped] = cropIm(scaledIM, scaledEyes, decidedEyeAvstand); 
end

end

