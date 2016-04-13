%%% Classification accuracy evaluation for link-based algorithms
% we use the classification accuracy to evaluate the quanlity of each
% algorithms, the following is just one example to calculate it.

%% 
dim = 3;
data = struct(led);
ldata = categorical([lx; ly]);

t = templateKNN( 'Standardize', false);
Mdl = fitcecoc([data.X; data.Y], ldata, 'Learners', t); %, 'Options', options);
CVMdl = crossval(Mdl);
loss = kfoldLoss(CVMdl)
