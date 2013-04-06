function [ X ] = Generate_Sample(mean, covariance, n, partion)
    marker = {'*r','+g','.b','xc','om'};
    [k,d] = size(mean);
    X = zeros(n,d);
    gap = 0;
    figure(1);
    hold on
    for i = 1:k
        R = mvnrnd(mean(i,:), covariance(:,:,i), n*partion(i));
        for j = 1:n*partion(i)
            X(j+gap,:) = R(j,:);
        end
        gap = gap + j;
        plot(R(:,1),R(:,2),char(marker(i)));
    end
    title('2 dimensional mixture gaussian samples');
    xlabel('x1'),ylabel('x2');
    hold off
end