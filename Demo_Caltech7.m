clear all
clc
addpath(genpath(pwd))

load caltech7_Per0.3.mat
numView = length(data);
nCluster = length(unique(truelabel{1}));
m = 3;  
k = 15;


%% Dataset Normalization
data = NormalizeFeature(data,numView);

%% Initialization (individual similarity matrix, unified similarity matrix and vector V)
[L,V,Q] = Initialization(data,index,nCluster,k);

Para = [];
Para.m = m;
Para.k = k;
Para.alpha = 5;   % Para.alpha = 5; for 100Leaves
Para.lambda = 1;  % Para.lambda = 1; for 100Leaves
Para.numView = numView;
Para.maxIter = 5;
Para.nCluster = nCluster;

[L,V,Q] = Initialization(data,index,nCluster,k);
[predictLabel, A, Q, L, U,V] = SGC(data,index,L,V,Q,Para);

FinalResult = CalcMeasures(truelabel{1}, predictLabel);  

fprintf('\n ###### Clustering results: ACC=%.4f, NMI=%.4f ####### \n', FinalResult(1), FinalResult(2) );
