function obj = subsasgn(obj, index, val)
 
  switch index.type
    case '()'
      switch index.subs{:}
        otherwise error('index out of range')
      end
    case '.'
      switch index.subs          
        case 'R'
          obj.R = val;
        case 'X'
          obj.X = val;
        case 'Y'
          obj.Y = val;
        case 'method'
          obj.method  = val;
        case 'CODEoptions'
          obj.CODEoptions  = val;
        case 'optimisation_range'
          obj.optimisation_range = val;                   
        case 'ini'
          obj.ini = val;
        case 'matrix_match'
          obj.matrix_match =val;
        case 'dim'
          obj.dim = val;
        case 'cputime'
          obj.cputime = val;
        case 'model'
          obj.model = val;
        case 'rescale'
          obj.rescale = val;
        case 'likelihood'
          obj.likelihood = val;
        case 'display'
          obj.display =val;
        case 'Rqp'
          obj.Rqp = val;
        case 'Rqpz'
          obj.Rqpz =val;
        otherwise
          error('invalid field name')
      end
    otherwise
      error('undefined undefined variable')
  end
 
end
