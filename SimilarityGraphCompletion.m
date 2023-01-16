function [Q,ObjValue,ObjList] = SimilarityGraphCompletion(V0,Q0,index,lambda)

Q_star = zeros(size(Q0));
Q_star(index,index) = Q0(index,index);

Q = zeros(size(Q_star));
N = size(Q_star,1);
indexVec = zeros(N,1);
indexVec(index) = 1;
Omega = indexVec * indexVec';


tau = 1;
%lambda = 0.1;
mu = 1;
maxIter = 30;
maxIter = 10;

for iter = 1:maxIter
    
    G = Q - tau*((Q-Q_star).*Omega) + tau*lambda*(V0*V0');  
    [U,S,V] = svd(G);
    
    for i=1:N   
        S(i,i) = max(S(i,i) - tau*mu, 0);  
    end   
    
    Q = (U*S*V');
    obj(iter) = norm((Q-Q_star).*Omega,'fro')^2/2 - lambda*trace(V0'*Q*V0);
 
    
    if iter > 1     
        diff_obj = abs(obj(end-1) - obj(end))/abs(obj(end-1));       
        if diff_obj < 1e-5          
            break          
        end  
    end
     
end

ObjValue = obj(end);
ObjList = obj;

end

