function [pred] = Predict(theta, inputSize, hiddenSize, numClasses, netconfig, data)
                  

% We first extract the part which compute the softmax gradient
softmaxTheta = reshape(theta(1:hiddenSize*numClasses), numClasses, hiddenSize);

% Extract out the "stack"
stack = params2stack(theta(hiddenSize*numClasses+1:end), netconfig);

[nfeatures, nsamples] = size(data);
depth = numel(stack);
a = cell(depth + 1, 1);
a{1} = data;

for layer = 1 : depth
    a{layer + 1} = bsxfun(@plus, stack{layer}.w * a{layer}, stack{layer}.b);
    a{layer + 1} = sigmoid(a{layer + 1});
end

M = softmaxTheta * a{depth + 1};
M = bsxfun(@minus, M, max(M));
p = bsxfun(@rdivide, exp(M), sum(exp(M)));
log(p)
[Max, pred] = max(log(p));

end

% You might find this useful
function sigm = sigmoid(x)
    sigm = 1 ./ (1 + exp(-x));
end
