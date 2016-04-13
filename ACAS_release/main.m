rng(213);

%% CODE

opt  = {'optimization', 'ga', 'obj_option', 'quant_int', 'obj_para', {'bin', 20}};

I    = {'R', R, 'method', 'CODE', 'dim',2, 'model_optimisation', opt };
code    = CoEmbedding(I);
code    = train(code);

figure
Plotcluster(code.X',lx,code.Y',ly);
title('CODE Algorithm');



figure
%% ************************ACAS data plot********************************

opt  = {'optimization', 'grid', 'obj_option', 'quant_int', 'obj_para', {'bin', 20}};
para_range = {'p', -1:3,  'alpha', 0:0.5:4, 'beta', 0:0.5:2};
I    = {'R', R, 'method', 'ACAS', 'dim',2, 'model_optimisation', opt,'parameter_range',para_range };
%I    = {'R', R, 'method', 'CA', 'dim',2};

acas    = CoEmbedding(I);
acas    = train(acas);

figure
Plotcluster(acas.Y',ly,acas.X',lx);
title('ACAS Algorithm');



