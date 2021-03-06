classdef OperatorFermion < handle
    
    properties (SetAccess = private)
        index
    end
    
    methods
        
        %---constructor defines maximal number of orbitals------------
        
        function Op = OperatorFermion(index)
            if nargin ~= 0
                Op(1,length(index)) = OperatorFermion;
                for j=1:length(index)
                    Op(j).index = index(j);
                end;
            end;
        end
        
        %-------------------------------------------------------------
        
        function st_ind = cr(Op,st_ind)
            if (st_ind(Op.index)~=3)
                
                S=(sum(abs(st_ind(1:(Op.index-1))))); %computation of the phase factor
                coef=(-1)^S;
                
                if (st_ind(Op.index)~=0)
                    st_ind(Op.index)=3;
                else
                    if sum(st_ind)>=0
                        st_ind(Op.index)=st_ind(Op.index)+1;
                    else
                        st_ind(Op.index)=st_ind(Op.index)-1;
                    end;       
                end;
                st_ind=coef.*st_ind;
            end;
        end
        
        function st_ind = ani(Op,st_ind)
            if (st_ind(Op.index)~=3)
                
                S=(sum(abs(st_ind(1:(Op.index-1))))); %computation of the phase factor
                coef=(-1)^S;
                
                if (abs(st_ind(Op.index))~=1)
                    st_ind(Op.index)=3;
                else
                    if sum(st_ind)>=0
                        st_ind(Op.index)=st_ind(Op.index)-1;
                    else
                        st_ind(Op.index)=st_ind(Op.index)+1;
                    end;
                end;
                st_ind=coef.*st_ind;                
            end;
        end
        
        %-------------------------------------------------------------
        
        function b=mtimes(Op,b)
            if (isobject(b))                 %operates on the operator or operators
                s=size(b.index);
                if (s(1)==s(2))&&(s(1)==1)   % the index is a constant meaning it is not a cluster
                    % create a cluster consisting of two operators
                    A=[Op.index 0;...        % the left colomn contains indecies of states
                        b.index 0];          % the left colomn contains zero or one depending on whether creation or anigilation operator is acting
                    b = OperatorCluster(A);
                else                         % the index is an array meaning it is a cluster
                    % combine the operator and cluster into a new cluster
                    A=[Op.index 0; b.index];
                    b = OperatorCluster(A);
                end;
            else                             %operates on the quantum state
                b=Op.ani(b);
            end;
        end
        
        function b=times(Op,b)
            if (isobject(b))
                s=size(b.index);
                if (s(1)==s(2))&&(s(1)==1)
                    A=[Op.index 1;...
                        b.index 0];
                    b = OperatorCluster(A);
                else
                    A=[Op.index 1; b.index];
                    b = OperatorCluster(A);
                end;
            else
                b=Op.cr(b);
            end;
        end
        
    end % methods
end % classdef