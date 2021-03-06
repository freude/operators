classdef OperatorCluster < handle
    
    properties (SetAccess = private)
        index
        a
    end
    
    methods
        
        function Op = OperatorCluster(A)
            Op.index = A;
            Op.a=OperatorFermion(1:max(Op.index(:,1)));
        end
        
        function b=times(Op,b)
            if (isobject(b))
                s=size(b.index);
                if (s(1)==s(2))&&(s(1)==1)
                    A=[Op.index; b.index 0];
                    A(length(Op.index(:,1)),2)=1;
                    b = OperatorCluster(A);
                else
                    A=[Op.index; b.index];
                    A(length(Op.index(:,1)),2)=1;
                    b = OperatorCluster(A);
                end;
            else
                for j=length(Op.index(:,1)):-1:1
                    if (j==length(Op.index(:,1)))
                        b=Op.a(Op.index(j,1)).*b;
                    else
                        if Op.index(j,2)==0
                            b=Op.a(Op.index(j,1))*b;
                        else
                            b=Op.a(Op.index(j,1)).*b;
                        end;                        
                    end;
                end;
            end;
        end
        
        function b=mtimes(Op,b)
            if (isobject(b))
                s=size(b.index);
                if (s(1)==s(2))&&(s(1)==1)
                    A=[Op.index; b.index 0];
                    b = OperatorCluster(A);
                else
                    A=[Op.index; b.index];
                    b = OperatorCluster(A);
                end;
            else
                for j=length(Op.index(:,1)):-1:1
                    if Op.index(j,2)==0
                        b=Op.a(Op.index(j,1))*b;
                    else
                        b=Op.a(Op.index(j,1)).*b;
                    end;
                end;
            end;
        end
        
    end % methods
    
end % classdef