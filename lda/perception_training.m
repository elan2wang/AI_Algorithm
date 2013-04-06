% The input D is a metrix of training sample,First column of each row is the class label
% The output ITE is iteration times
% The output W is weight vector
function [ ITE,W ] = perception_training( D )
% Initialization
% Set Weight Vector W to [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1]
% Set Learning rate a to 0.1
[n,d] = size(D);
W = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
a = 0.1;
% Beging Iteration
ITE = 0;
count = 1;
while count ~= 0
    count = 0;
    for j = 1:n
    y = W*D(j, :)';
    if y < 0 
        W = W + a * D(j, :);
        count = count + 1;
    end
    end
    ITE = ITE + 1;
end
end

