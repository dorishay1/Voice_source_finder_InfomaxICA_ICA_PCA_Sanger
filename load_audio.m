function [temp_cell] = load_audio(filetype)
%finds all the files in the folder with the relavent name and sort it in a cell.

files = dir(filetype) ;
N = length(files) ;
for i = 1:N
    thisfile = files(i).name ;
    % do what you want
    temp_cell{i} = audioread(thisfile);
end
end

