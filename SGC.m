function [predictLabel, A, Q, L, U,V] = SGC(data,index,L,V,Q,Para)

maxIter = Para.maxIter;
numView = Para.numView;
nCluster = Para.nCluster;
m = Para.m;
k = Para.k;
alpha = Para.alpha;
lambda = Para.lambda;

for i = 1:numView
    %[U{i}] = data{i};
    [U{i}] = GraphFiltering(data{i},L, index{i},alpha);
end


for iter = 1:maxIter
    
    
    %% Similarity matrix generation for each view
    for i = 1 :numView
        Q{i} = SimilarityGeneration(U{i}, k, 0);
    end
    
    for i = 1 :numView
        [A{i}] = SimilarityGraphCompletion(V,Q{i},index{i},lambda);
    end
    
    %% Consensus Learning
    [L,V,predictLabel] = FusionSum(A, nCluster, numView);
    
    
    %% Refine dataset via mask graph filtering
    for i = 1 :numView
        [U{i}] = GraphFiltering(data{i},L,index{i},alpha);
    end
    
    
end

end

