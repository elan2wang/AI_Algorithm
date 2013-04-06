% The input D is the test sample
% The input W is the trained weight vector
% The output e is the error rate
function [ er ] = perception_testing( D,W )
[n,d] = size(D);
count = 0;
for i = 1:n
    y = W * D(i,:)';
    if y < 0
        count = count+1;
    end
end
er = count/n;
end