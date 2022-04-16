function [gray_world_lightning] = AWB(Image)
% lightning correction (gray world), return corrrected image

size_ = size(Image(:,:,1));

R_avg = sum(Image(:,:,1), 'all')./( size_(1)* size_(2));
G_avg = sum(Image(:,:,2), 'all')./ (size_(1)* size_(2));
B_avg = sum(Image(:,:,3), 'all')./ (size_(1)* size_(2));

alpha = G_avg/R_avg;
beta = G_avg/B_avg;

Rsen = alpha.* Image(:,:,1);
Gsen = Image(:,:,2);
Bsen = beta.* Image(:,:,3);

gray_world_lightning= cat(3,Rsen, Gsen, Bsen);

end
