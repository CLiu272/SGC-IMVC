function [Lstar, V1, label] = FusionSum(S, numC, numViews)

%% eigenvalues and the corresponding eigenvectors of each view
L = cell(1, numViews);
Lstar = zeros(size(S{1}));
% Sstar = 0;
% for i = 1 : numViews
%     Sstar = Sstar + S{i};
% end
% Sstar = Sstar/numViews;
% 
% D = diag(sum(Sstar,2));
% Di = diag(1 ./ sqrt(diag(D)));
% Di((Di==inf)) = 0;
% Lstar = Di * Sstar * Di;

D = cell(1, numViews);
for i = 1:numViews
    D{i} = diag(sum(S{i},2));
end

for i = 1 : numViews
    Di = diag(1 ./ sqrt(abs(diag(D{i}))));
    Di(isinf(Di)) = 0;
    Di(isnan(Di)) = 0;
    L{i} = Di * S{i} * Di;
    Lstar = Lstar + L{i};
end
Lstar = Lstar/numViews;


[V1 , ~, ~] = svd(Lstar);

    
V1 = V1(:, 1:numC);
VV = V1./max(repmat(sum(V1.*V1, 2).^(1/2), 1, numC), 1e-10);

[label] = kmeans(VV(:, 1:numC), numC,'Replicate', 10, 'emptyaction', 'singleton');
%[label] = k_means(VV(:, 1:numC), [], numC, 100);


end