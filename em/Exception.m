function [E,L] = Exception(X,k,W,M,V)
    [n,d] = size(X);
    a = (2*pi)^(0.5*d);
    S = zeros(1,k);
    iV = zeros(d,d,k);
    
    for j = 1:k
        S(j) = sqrt(det(V(:,:,j)));
        iV(:,:,j) = inv(V(:,:,j));
    end
    
    E = zeros(n,k);
    
    for j = 1:k
        meanSubtracted = X' - repmat(M(:,j),1,n);
        pdfValueVectorToExp = diag(-0.5*meanSubtracted'*iV(:,:,j)*meanSubtracted);
        pdfValueVector = exp(pdfValueVectorToExp)/(a*S(j));
        E(:,j) = W(j)*pdfValueVector';
    end
    
    sumInColumnDirection = sum(E,2);
    divisor = repmat(sumInColumnDirection,1,k);
    
    %log-likelihood function   sum(log(sum(E,2)))
    L = sum(log(sum(E,2)));
    
    E = E./divisor;
end

