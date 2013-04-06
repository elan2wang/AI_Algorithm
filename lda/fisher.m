function [] = fisher( k )
% load data
D = importdata('digitdata.txt');
[n, d] = size(D);

% upset the order of the imported data
for i = 1 : n
    r = randi(n,1,1);
    temp = D(i,:);
    D(i,:) = D(r,:);
    D(r,:) = temp;
end

% k cross-validation
subset_size = n/k;
w = zeros(k, 10);
error_rate = zeros(1,k);
elapsed_time = zeros(1,k);
training_data = zeros(subset_size*(k-1),10);
testing_data = zeros(subset_size,10);
for i = 1:k
    % generate training data and testing_data
    for j = 1 : subset_size*(i-1)
        training_data(j,:) = D(j,:);
    end
    for j = subset_size*(i-1)+1 : subset_size*i
        testing_data(j-subset_size*(i-1),:) = D(j,:);
    end
    for j = subset_size*i+1 : n
        training_data(j-subset_size*i,:) = D(j,:);
    end
    
    % start timer
    t_start = clock;
    % training
    [w(:,i)] = fisher_training(training_data);
    % calculate elapsed time
    elapsed_time(i) = etime(clock, t_start);
    % testing
    error_rate(i) = fisher_testing(testing_data, w(:,i));
end

% calculate average error rate
error = 0;
time = 0;
for i = 1 : k
    error = error+error_rate(i);
    time = time + elapsed_time(i);
end
str1 = sprintf('average error rate is %.4f', error/k);

figure(3)
hold on
plot(1:k,error_rate,'--r*');
title('Figure 3: Error rate of Fisher LDA');
legend(str1);
hold off

str2 = sprintf('average training time is %.4f s', time/k);
figure(4)
hold on
plot(1:k,elapsed_time);
title('Figure 4: Traing Time of Fisher LDA');
legend(str2);
hold off

end

