function Rq= ACAS_R(R, type, para)
  
  bin =10;
  for ii = 1 : 2 : length(para)-1
    switch lower(para{ii})
      case 'bin'
        bin	= para{ii+1};
      otherwise
        error( [ 'unknown input argument: ' I{ii} ] );
    end
  end
   
 switch lower(type)
   case {'quant_integer','quant_int'}
     bound = quantile(R(:),bin);
     Rq=zeros(size(R));
     for ii=1:length(bound)
       if ii==1
         ind = find(R<=bound(1));
       elseif ii==length(bound)
         ind = find(R>bound(end));
       else
         ind = find( R>bound(ii-1) & R<=bound(ii) );
       end
       Rq(ind)=ii;
     end
   case {'fast_quant_integer','fast_quant_int'}
     tt = R(:);
     [tt,N] = sort(tt);
     if length(tt)>5000
       Nstep = round(length(tt)/5000)+1;
     else
       Nstep=1;
     end
     bound = quantile(tt(1:Nstep:length(tt)),bin);
     Rq=zeros(size(R));
     for ii=1:length(bound)
       if ii==1
         ind = find(R<=bound(1));
       elseif ii==length(bound)
         ind = find(R>bound(end));
       else
         ind = find( R>bound(ii-1) & R<=bound(ii) );
       end
       Rq(ind)=ii;
     end
   case 'quant_adapt'
     R = R/(sum(R(:)));
     bound = quantile(R(:),bin);
     Rq=zeros(size(R));
     for ii=1:length(bound)
       if ii==1
         ind = find(R<=bound(1));
         Rq(ind) = (min(R(:)) + bound(ii))/2;
       elseif ii==length(bound)
         ind = find(R>bound(end));
         Rq(ind) = (max(R(:)) + bound(ii))/2;
       else
         ind = find( R>bound(ii-1) & R<=bound(ii) );
         Rq(ind) = (bound(ii-1) + bound(ii))/2;
       end       
     end
   case 'fast_quant_adapt'
     R = R/(sum(R(:)));
     tt = R(:);
     [tt,N] = sort(tt); 
     if length(tt)>5000
       Nstep = round(length(tt)/5000)+1;
     else
       Nstep=1;
     end
     bound = quantile(tt(1:Nstep:length(tt)),bin);
     Rq=zeros(size(R));
     for ii=1:length(bound)
       if ii==1
         ind = find(R<=bound(1));
         Rq(ind) = (min(R(:)) + bound(ii))/2;
       elseif ii==length(bound)
         ind = find(R>bound(end));
         Rq(ind) = (max(R(:)) + bound(ii))/2;
       else
         ind = find( R>bound(ii-1) & R<=bound(ii) );
         Rq(ind) = (bound(ii-1) + bound(ii))/2;
       end       
     end
   otherwise
     error( [ 'unknown method for processing ACAS optimisation objective: ',  type{ii} ] );
 end
 
end

