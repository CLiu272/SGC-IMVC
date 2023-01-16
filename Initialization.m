function [L,V,Q,predictLabel] = Initialization(data,index,nCluster,k)
%INITIALIZATION


%% Similarity matrix generation
%k = 15;
view_num = length(data);
Q = cell(1, view_num);
for i = 1 :view_num
    Q{i} = SimilarityGeneration(data{i}, k, 0);
end

%% Similarity matrix completion via Average
Q = SimilarityCompletionAverage(Q, index, 1);

for i = 1 :view_num
    NanIdx = isnan(Q{i});
    Q{i}(NanIdx) = 0;
end

D = cell(1, view_num);
for i = 1:view_num
    D{i} = diag(sum(Q{i},2));
end

%% Obtain unified similarity matrix by PIC approach
[L,V,predictLabel] = FusionSum(Q, nCluster, view_num);



end

