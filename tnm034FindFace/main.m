clear all
close all
D = 'C:\Users\Ljung\Documents\Avancerad bildbehandling\Projektet FindFaces\Images\DB1\DB1';
D0 = 'C:\Users\Ljung\Documents\Avancerad bildbehandling\Projektet FindFaces\Images\DB0\DB0';
n=1;
S = dir(fullfile(D,'*.jpg')); % pattern to match filenames.

%------ Ifall databasen ska göras om-------------
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
    cropedIM = ImChanges(I);

    [numrows, numcols, rgb] = size(cropedIM);

    cropedIM = reshape(cropedIM, [numrows*numcols, 1]); 

    n_vector(:,k) = cropedIM;  
end

[I, w, Ui, meanFace] = saveToDatabase(n_vector, numel(S));




for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
    %I= imroate()
    % skala
    % färgändring
    id= tnm034(I);
    
     if(id == k)
        disp('rätt');  
    else
       disp('fel: '); 
       disp(k)
    end
end
