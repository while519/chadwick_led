%% CoEmbedding algorithm running script
% To run algorithms on each data, please fowllow the readme

%*****************please add code from readme below ***********************
rng(213);
%R    = CalRelationXY(X,Y,'gaussian','mean');
 opt  = {'optimisation', 'ga', 'obj_option', 'quant_knn', 'obj_para', {'knn', 5,5}};
 
 para_range = {'eta1',[-1, 10],'eta2', [-1, 10],'alpha',[0, 3], 'beta',[0,3]};
 
 I    = {'R', R, 'method', 'LEDeig','dim', 2, 'model_optimisation', opt, 'parameter_range',para_range };
 
 led    = LEDF(I);
 led    = training(led);


 figure;
 Plotcluster(led.X',lx,led.Y',ly);
 
 % save('dot_LEDF_results.mat', 'led', 'lx', 'ly')
 % c=get(gca,'Children');
 % set(gca,'Children',flipud(c))

%********************************* end ************************************