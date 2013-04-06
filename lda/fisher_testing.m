% The input D is the test sample
% The input W is the trained weight vector
% The output e is the error rate
function [ er ] = fisher_testing( D,W )
[n,d] = size(D);
count = 0;
for i = 1:n
    y = W * D(i,1:9);
    if D(i,10)*y < 0
        count = count+1;
    end
end
er = count/n;
end

