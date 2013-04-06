function [ W ] = fisher_training( D )
[n,d] = size(D);

% classify the sample D into X1 and X2
index1 = 1;
index2 = 1;
for i = 1 : n
   if D(i,10) == 1
       X1(index1,:) = D(i,1:9);
       index1 = index1+1;
   else
       X2(index2,:) = D(i,1:9);
       index2 = index2+1;
   end
end
% calculate the weight vector
mu = mean(D(:,1:9));
mu1 = mean(X1);
mu2 = mean(X2);
n1 = size(X1,2);
n2 = size(X2,2);
sb1 = n1.*(mu1-mu)*(mu1-mu)';
sb2 = n2.*(mu2-mu)*(mu2-mu)';
sb = sb1+sb2;
s1 = cov(X1);
s2 = cov(X2);
sw = s1+s2;

invSw_by_sb = sw*sb;
[eigVector,eigValue] = eig(invSw_by_sb);

W = eigVector(:,1);
end

