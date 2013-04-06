function [] = draw(L1,L2,L3,count1,count2,count3)
    figure(10);
    hold on
    plot(1:count1-1,L1,'--r*');
    plot(1:count2-1,L2,'--bo');
    plot(1:count3-1,L3,'--g+');
        legend('kmeans','random1','random2');
        title('E-M Algorithm Convergence');
        xlabel('number of EM steps'),ylabel('The log-likelihood');
    hold off

end

