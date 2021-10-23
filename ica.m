function [after_ica] = ica(data,eta,epoch)
%apllying ICA algorithem


func = @Sigmoid;

if iscell(data) == 1
    data_mat = cell2mat(data)';
    W = randn(length(data));
    
elseif ismatrix(data)
    data_mat = data';
    W = randn(size(data,2));
    
else
    error('please insert a cell or a matrix');
    
end

rec_length = length(data_mat);

for i = 1:epoch
    shuffle_idx = randperm(rec_length);
    current_data = data_mat(:,shuffle_idx);
    
    for t = 1:rec_length
        x = current_data(:,t);
        y = 1 - 2 * func(W*x);
        
        dW = eta * (inv(W') + y*x');
        
        W = W + dW;
        
    end
    
end

after_ica = W * data_mat;

end

