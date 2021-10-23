function [] = save_result(result,filename)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i = 1:size(result,1)
    
    current_result = result(i,:);
    current_result = rescale(current_result,-1,1);
    
    current_str = [filename num2str(i),'.wav'];
    audiowrite(current_str,current_result,44100);
end
end

