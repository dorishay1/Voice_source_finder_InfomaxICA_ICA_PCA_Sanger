function [W] = sanger(input,output_dim,eta,epoch)
%Sangler Rule -Training Online learning

input_dim = length(input);
X = cell2mat(input)';
W = 0.1*randn(output_dim,input_dim);        %preduce random weights.

for epoch= 1:epoch
    eta         = eta/(epoch);              %Reduce learning rate each epoch
    idx = randperm(length(X));              %produce a random index vector
    for  n_ex = 1:length(X)                 %for each example
        x = (X(:,idx(n_ex)));               %Get a random sample
        Y = W * x;                          %code the example according to the W's.
        
        %Update rule
        for i = 1:output_dim
            for  j = 1:input_dim
                sigma = 0;
                for k = 1:i
                    sigma = sigma + (W (k,j) * Y(k));
                end
                dW = eta * Y(i) * (x(j) - sigma);
                W(i,j)= W(i,j) + dW;        %updating the current W
            end
        end
    end
end


end

