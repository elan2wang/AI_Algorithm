function [W,M,V] = Init_Kmeans(X, k)
    % W ��ʾ��ʼ���ĸ�����ĸ��ʣ�������
    % M ��ʾ��ʼ���ĸ�����ľ�ֵ
    % V ��ʾ��ʼ���ĸ������Э����
    
    [n,d] = size(X);
    [Ci,C] = kmeans(X,k,'emptyaction','singleton');
    % Ci�洢ÿ������ֵ�������
    % C�洢Centroid��ֵ
    
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

