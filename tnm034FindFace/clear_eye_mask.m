function [clear_eye_mask] = clear_eye_mask(L, pairofeyes, r, c)
% Clear the eye mask from all potentiall eyes except the true eyes

value_eye1 = L(round(pairofeyes(1,2)), round(pairofeyes(1,1)));
value_eye2 = L(round(pairofeyes(2,2)), round(pairofeyes(2,1))); 

clear_eye_mask = zeros(r,c); 

for(i = 1 : r)
    for(j = 1 : c)
        if(L(i,j) == value_eye1)
           clear_eye_mask(i,j) = 1;  
        elseif(L(i,j) == value_eye2)
           clear_eye_mask(i,j) = 1;   
        end
    end
end

end

