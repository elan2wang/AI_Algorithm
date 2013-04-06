function [W,M,V] = Maximization(X,k,E)
    [n,d] = size(X);
    V = zeros(d,d,k);
    
    W = sum(E,1);
    M = X' * E;
    M = M ./ repmat(W,d,1);
    
    for i = 1:k
        for j = 1:n
            dXM = X(j,:)' - M(:,i);
            V(:,:,i) = V(:,:,i) + E(j,i) * (dXM) * dXM';
        end
        V(:,:,i) = V(:,:,i)/W(i);
    end
    W = W/n;
end

