function [W,M,V] = Init_Kmeans(X, k)
    % W 表示初始化的各分类的概率（比例）
    % M 表示初始化的各分类的均值
    % V 表示初始化的各分类的协方差
    
    [n,d] = size(X);
    [Ci,C] = kmeans(X,k,'emptyaction','singleton');
    % Ci存储每个样本值所属类别
    % C存储Centroid的值
    
    M = C';
    Vp = repmat(struct('count',0,'X',zeros(n,d)),1,k);
    
    for i=1:n 
        Vp(Ci(i)).count = Vp(Ci(i)).count + 1;
        Vp(Ci(i)).X(Vp(Ci(i)).count,:) = X(i,:);
    end
    
    V = zeros(d,d,k);
    W = zeros(k);

    for i=1:k
        W(i) = Vp(i).count/n;
        V(:,:,i) = cov(Vp(i).X(1:Vp(i).count,:));
    end
end

