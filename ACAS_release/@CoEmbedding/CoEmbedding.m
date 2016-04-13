function [obj] = CoEmbedding(I)

%Computing co-embeddings for heterogeneous objects
%Use 
% o  = DEFC(Setting)
% Setting = {'R', R,...
%            'dim', 2,...
%            'method', 'ACAS',...
%            'option', 'option',...
%           };
%-----------------------------------
% T. Mu June 2011
%-----------------------------------
  if ~exist('I', 'var')
    error('wrong input data given to the constuctor')
  end
  
  % Default Setting    
  obj.method                            = 'ACAS';  
  obj.dim                               = [];     
  obj.cputime                           = 1;
  obj.optimisation_range                = [];
  obj.matrix_match                      = {'optimization', 'ga', 'obj_option', 'quant_integer',...
                                           'obj_para', {'bin', 0:0.1:1},...
                                           };
  obj.ini                               = [];  
  obj.rescale                           =1;
  obj.display                           =1;
  %Setting for CODE                                        
  obj.CODEoptions                            =[];  
  

  if ~nargin
    error('no default constructor available')
  elseif isa(I, 'CoEmbedding')
    obj = I;
  else
    for ii = 1 : 2 : length(I)-1
      switch lower(I{ii})
        case {'r', 'input'}
          obj.R                   	= I{ii+1};
        case 'method'
          obj.method               	= I{ii+1};
        case {'k', 'dim'}
          obj.dim                  	= I{ii+1};
        case {'model_optimisation','model_optimization'}
          obj.matrix_match          = I{ii+1};
        case 'parameter_range'
          obj.optimisation_range    = I{ii+1};
        case 'code_options'
          obj.CODEoptions               = I{ii+1};
        case {'initialisation','initialization'}
          obj.ini                   = I{ii+1};
        case 'display'
          obj.display               = I{ii+1};
        otherwise
          error( [ 'unknown input argument: ' I{ii} ] );
      end
    end
    
    % results
    obj.X    = [];
    obj.Y    = [];
    obj.likelihood  = []; %only for CODE output;
    obj.model = [];
    obj.Rqp = [];
    obj.Rqpz =[];
    obj.best=[];
    obj = class(obj,'CoEmbedding'); 
    
  end
end