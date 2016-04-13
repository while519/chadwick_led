%%% Top words evaluation for the full Clinical Trial Data
% Use the center of the topic clusters to represent one class and then
% compute top word according the distance to each class. Before using this
% script please have the co-embedding of all algorithms named 'code', 'led',
% 'acas' and their topics label 'train_label'  in workspace.

%% initialise
close all
clc
tid = 1;                        % the topic id from 1 to 9
aid = 1;                        % embedding algorithm id from 1 to 3 of code, led, acas respectively
Methods = {'code', 'led', 'acas'};
Mea = cell(20,3);               % storage for the mean of each topic
id = cell(20,3);                % for stoting topwords id

% ~~~~~~~~ turn the class to struct data types as the class could only be
% used within their class folder
led = struct(led);
code = struct(code);
acas = struct(acas);
train_label = topic(lx);

xlabel = categorical(train_label); % the classlabel

rng(1);

%% Extract the topics cluster mean and storing the close words to each topics in id{tid,:}
for tid = 1 : 9
    for aid = 1 : 3
        obj = eval(Methods{aid});       % select the algorithm
        idx = find(xlabel == topic(tid));
        
        data = obj.X(idx,:);             % the documents of topic tid
        Mea{tid,aid} = mean(data);       % the clustering center for topic tid
        
        dist = pdist2(Mea{tid,aid},obj.Y);  % the distance from words to the clustering centre
        [~,id{tid, aid}] = sort(dist,'ascend');
        
    end
end

% Reconstruct the  relational matrix R_topwords using the top related words
% for each algorithm
figure;
h = cell(3,1);
perf = cell(3,1);
h{1} = animatedline('Marker', '*', 'MarkerEdgeColor','r', 'Color', 'r');
h{2} = animatedline('Marker', '*', 'MarkerEdgeColor','b', 'Color', 'b');
h{3} = animatedline('Marker', '*', 'MarkerEdgeColor','g', 'Color', 'g');
perf{1} = [];
perf{2} = [];
perf{3} = [];

for num = 10 : 5 : 100
    for aid = 1:3
        selected_topwords = unique([id{1,aid}(1:num) id{2,aid}(1:num) id{3,aid}(1:num) id{4,aid}(1:num) id{5,aid}(1:num)...
                                     id{6,aid}(1:num) id{7,aid}(1:num) id{8,aid}(1:num) id{9,aid}(1:num)]);
        R_topwords = full(R(:, selected_topwords));
        t = templateSVM('KernelFunction','linear', 'Standardize', false);
        Mdl = fitcecoc(R_topwords, xlabel, 'Learners', t); %, 'Options', options);
        CVMdl = crossval(Mdl);
        loss = kfoldLoss(CVMdl);
        perf{aid} = [perf{aid} loss];
        addpoints(h{aid},num,loss);
        drawnow
    end
end
legend('CODE', 'LEDF', 'ACAS');

% x-axis corresponds to the top words selected per topic while y-axis
% corresponds to the SVM cross-validated classifaiction loss
