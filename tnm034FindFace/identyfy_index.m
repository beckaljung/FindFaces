function [index] = identyfy_index(Image, meanFace, Ui, w)
%Find the index of the serch image, (PCA)
    [rows, columns, rgb] = size(Image);
    ImReshaped = reshape(Image, [rows*columns, 1]); 

    A = (ImReshaped - meanFace);
    wtest = Ui' * A; 

    distance = 100000;
    index = 0;
    thresh = 1150;
    
    [~,n] = size(w);

    %Find the index with the shortes distance to the searched image
    for i = 1:n   
       if sqrt(sum(abs(wtest - w(:,i)).^2)) < distance   
         distance = sqrt(sum(abs(wtest - w(:,i)).^2)); 
         index = i;
       end
    end

    %Incase the distance is to large, the idex should be 0
    if distance > thresh
      index = 0;  
    end

   
end

