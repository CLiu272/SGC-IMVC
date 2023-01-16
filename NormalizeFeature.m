function [NormData] = NormalizeFeature(data,numView)
%% Dataset Normalization
n_num = size(data{1},2); % the number of instances
for i = 1:numView
    NormData{i} = zeros(size(data{i}));
    for  j = 1:n_num
        normItem = std(data{i}(:,j));
        if (0 == normItem)
            normItem = eps;
        end
        NormData{i}(:,j) = (data{i}(:,j)-mean(data{i}(:,j)))/(normItem);
    end
end
clear data
end

