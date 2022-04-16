function [index] = tnm034(im)
% find index for serch image, if not foud return 0

    %load image database
    load('database.mat');
    %crop image
    [cropedIMchange] = ImChanges(im);
    %find index from database
    index = identyfy_index(cropedIMchange, meanFace, Ui, w); 

end

