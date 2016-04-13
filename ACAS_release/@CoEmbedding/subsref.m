function val = subsref(obj, index)

  switch index.type
    case '()'
      switch index.subs{:}
        otherwise error('index out of range')
      end
    case '.'
      switch index.subs        
        case 'R'
          val = obj.R  ;
        case 'X'
          val = obj.X  ;
        case 'Y'
          val = obj.Y  ;
        case 'method'
          val = obj.method  ;
        case 'CODEoptions'
          val = obj.CODEoptions  ;
        case 'optimisation_range'
          val = obj.optimisation_range ;          
        case 'ini'
          val = obj.ini;
        case 'matrix_match'
          val = obj.matrix_match;
        case 'dim'
          val = obj.dim;
        case 'cputime'
          val = obj.cputime;
        case 'model'
          val = obj.model;          
        case 'rescale'
          val = obj.rescale;
        case 'likelihood'
          val = obj.likelihood;
        case 'display'
          val =obj.display;
        case 'Rqp'
          val = obj.Rqp ;
        case 'Rqpz'
          val = obj.Rqpz ;
          case 'best'
              val=obj.best;
        otherwise
          error('invalid field name')
      end
    otherwise
        error('undefined variable')
  end
  
end

%------------------------------------------------