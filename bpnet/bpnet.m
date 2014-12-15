clc;
close all;
clear all;

%% Load data
load('finalCS6923.mat');
train_label(train_label == 0) = 2; % Remap 0 to 2 since our labels need to start from 1

testData = train(80001:100000, :);
testLabels = train_label(80001:100000, :);
train = train(1:80000, :);
train_label = train_label(1:80000, :);
train = train';
testData = testData';

meanData = mean(train, 2);
train = bsxfun(@minus, train, meanData);
stdData = std(train, 0, 2);
train = bsxfun(@rdivide, train, stdData);

testData = bsxfun(@minus, testData, meanData);
testData = bsxfun(@rdivide, testData, stdData);

%% init
inputSize = 54;
numClasses = 2;
hiddenSizeL1 = 100;    % Layer 1 Hidden Size
hiddenSizeL2 = 64;    % Layer 2 Hidden Size 
lambda = 3e-3;         % weight decay parameter          
maxIter = 300;
% Randomly initialize the parameters
layer1Theta = initializeParameters(hiddenSizeL1, inputSize);
layer2Theta = initializeParameters(hiddenSizeL2, hiddenSizeL1);
SoftmaxTheta = 0.005 * randn(hiddenSizeL2 * numClasses, 1);

%% Training
% Implement the stackedAECost to give the combined cost of the whole model
% then run this cell.

% Initialize the stack using the parameters learned
stack = cell(2,1);
stack{1}.w = reshape(layer1Theta(1:hiddenSizeL1*inputSize), ...
                     hiddenSizeL1, inputSize);
stack{1}.b = layer1Theta(2*hiddenSizeL1*inputSize+1:2*hiddenSizeL1*inputSize+hiddenSizeL1);
stack{2}.w = reshape(layer2Theta(1:hiddenSizeL2*hiddenSizeL1), ...
                     hiddenSizeL2, hiddenSizeL1);
stack{2}.b = layer2Theta(2*hiddenSizeL2*hiddenSizeL1+1:2*hiddenSizeL2*hiddenSizeL1+hiddenSizeL2);

% Initialize the parameters for the deep model
[stackparams, netconfig] = stack2params(stack);
Theta = [ SoftmaxTheta ; stackparams ];

%  Use minFunc to minimize the function
addpath minFunc/
options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                          % function. Generally, for minFunc to work, you
                          % need a function pointer with two outputs: the
                          % function value and the gradient. In our problem,
                          % sparseAutoencoderCost.m satisfies this.
options.maxIter = maxIter;% Maximum number of iterations of L-BFGS to run 
options.display = 'on';
[Theta, cost] = minFunc( @(p) getCost(p, ...
                                   inputSize, hiddenSizeL2, ...
                                   numClasses, netconfig, ...
                                   lambda, train, ...
                                   train_label), ...
                                    Theta, options);

%% STEP 6: Test 
[pred] = Predict(Theta, inputSize, hiddenSizeL2, ...
                          numClasses, netconfig, testData);

acc = mean(testLabels(:) == pred(:));
fprintf('Test Accuracy: %0.3f%%\n', acc * 100);
%}