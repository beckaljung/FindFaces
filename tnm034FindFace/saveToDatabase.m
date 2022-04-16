function [I, w, Ui, meanFace] = saveToDatabase(n_vector, sizeS)
%Save images information to a database
meanFace = mean(n_vector,2); 


for i = 1:sizeS
    meanFace_diff(:,i) = n_vector(:,i) - meanFace; 
end 

%steg 5 find covatiance matric C 
A = meanFace_diff; 

%k �r kopplat till eValues, inte mest prio! 
[eVectors, eValues] = eig(A'*A);

%steg 6c, face space
Ui =  A * eVectors; 

w = Ui' * A; 

%EigenFaces
I = meanFace + sum(Ui * w);

%Save to a database
save('database.mat','I', 'w', 'Ui','meanFace');

end

