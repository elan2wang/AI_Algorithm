function [L,count] = demo()
    marker = {'*r','+g','.b','xc','om'};
    
    %% Generate Sample
    mean = [4 5;10 15;15 10];
    covariance(:,:,1) = [9 0;0 9];
    covariance(:,:,2) = [6 0;0 6];
    covariance(:,:,3) = [4 0;0 4];
    n = 1000; partion = [0.3, 0.5, 0.2];
    k = 3;
    X = Generate_Sample(mean, covariance, n, partion);
    
    %% Initialize the paramters
    %[W,M,V] = Init_Kmeans(X,k);
    %[W,M,V] = Init_Random();
    [W,M,V] = Init_Random2();
    
    % start timer
    t_start = clock;
    
    %% E-M Iteration
    e = 0.000001; EPS = 1;
    count = 1;
    while EPS >= e
        [E,l] = Exception(X,k,W,M,V);
        [W,M,V] = Maximization(X,k,E);
        L(count) = l;
        if count == 1
            EPS = abs(l);
        else
            EPS = abs(l - L(count-1));
        end
        count = count+1; 
    end
    % calculate elapsed time
    elapsed_time = etime(clock, t_start);
    fprintf('Iteration time  is : %.4f s\nTteration count is : %d\n',elapsed_time,count);
    
    %% Draw the figure of clustering procedures
    figure(2)
    hold on
    for i = 1:n
        [a, pos] = max(E(i,:));
        plot(X(i,1),X(i,2),char(marker(pos)));
    end
    title('E-M Clustering result');
    xlabel('x1'),ylabel('x2');
    hold off
        
    %% Draw the figure of the convergence
    figure(3)
    hold on
    plot(1:count-1,L,'--r*');
        title('E-M Algorithm Convergence');
        xlabel('number of EM steps'),ylabel('The log-likelihood');
    hold off
    
end

