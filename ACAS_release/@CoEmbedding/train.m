function [obj] = train(obj)

  switch lower(obj.method)
    case 'code'

      if isempty(obj.dim)
        obj.dim=2;
      end

      obj.cputime = cputime;

      if sum(obj.R(:))==1      
        [obj.X, obj.Y, out] = CODE(obj.R, obj.dim, obj.CODEoptions);
      else
        [obj.X, obj.Y, out] = CODE(obj.R/sum(obj.R(:)),obj.dim, obj.CODEoptions);
      end
      
      obj.likelihood = out.lik;

      obj.cputime = cputime - obj.cputime;
      Rz     = CalRelationXY(obj.X, obj.Y, 'euclidean_sim');
      Rz     =  ACAS_R(Rz, 'quant_int', {'bin', 10});
      R      =  ACAS_R(obj.R, 'quant_int', {'bin', 10});
      o      = dma(1- Rz);
      o.algo = 'covat2';
      o      = o.run();
      A1      =  R(o.perm.row, o.perm.col); 
      A2       = Rz(o.perm.row, o.perm.col);
      obj.Rqp =A1;
      obj.Rqpz=A2;
      
      if obj.display
        figure('Visible','Off');

        subplot(2,3,1)
        imagesc(A1); title('Original Relation Matrix (permute recovered)')
        subplot(2,3,2)
        imagesc(A2); title('Recovered Relation Matrix')
        subplot(2,3,3)
        plot( obj.X(:,1), obj.X(:,2), 'ro',   obj.Y(:,1), obj.Y(:,2), 'b*')
        o      = dma(1- obj.R);
        o.algo = 'covat2';
        o      = o.run();
        A1      =  obj.R(o.perm.row, o.perm.col); 
        A2       = Rz(o.perm.row, o.perm.col); 
        subplot(2,3,4)
        imagesc(A1); title('Original Relation Matrix (permute original)')
        subplot(2,3,5)
        imagesc(A2); title('Recovered Relation Matrix')
      end


    case {'acas', 'acas_svd', 'acassvd'}
      [obj.X, obj.Y, obj.cputime, obj.model, obj.Rqp, obj.Rqpz,obj.best] = ACAS(obj.R, obj.dim, obj.optimisation_range, obj.matrix_match, obj.ini, obj.display);  
    
    case {'acas_eig', 'acaseig'}
      [obj.X, obj.Y, obj.cputime, obj.model] = ACASeig(obj.R, obj.dim, obj.optimisation_range, obj.matrix_match, obj.ini, obj.display);  
    case 'lsi'
      obj.optimisation_range = {'p',0, 'alpha', 0, 'beta', 0};
      obj.matrix_match = {'optimization', 'grid'};
      [obj.X, obj.Y, obj.cputime, obj.model, obj.Rqp, obj.Rqpz] = ACAS(obj.R, obj.dim, obj.optimisation_range, obj.matrix_match, obj.ini, obj.display);  
    case 'ca'
      obj.optimisation_range = {'p',1, 'alpha', 0.5, 'beta', 1};      
      obj.matrix_match = {'optimization', 'grid'};
      [obj.X, obj.Y, obj.cputime, obj.model, obj.Rqp, obj.Rqpz] = ACAS(obj.R, obj.dim, obj.optimisation_range, obj.matrix_match, obj.ini, obj.display);  
    case 'bgp'
      obj.optimisation_range = {'p',1, 'alpha', 0.5, 'beta', 0};      
      obj.matrix_match = {'optimization', 'grid'};
      [obj.X, obj.Y, obj.cputime, obj.model, obj.Rqp, obj.Rqpz] = ACAS(obj.R, obj.dim, obj.optimisation_range, obj.matrix_match, obj.ini, obj.display);  
     otherwise
      error('unknown co-embedding method')
  end
  
  if obj.rescale==1
    X = [obj.X; obj.Y];
    a = min(X);
    b = max(X);
    c = b - a;
    range = 1;
    w = range./c;
    d = -w.*a;
    Y = bsxfun(@times, X, w);
    Y = bsxfun(@plus, Y, d);
    obj.X = Y(1:size(obj.X,1),:);
    obj.Y = Y(size(obj.X,1)+1:end,:);
  end
  
   
end