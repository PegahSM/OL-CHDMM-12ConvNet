function [me] = ahdepthProject(X,u)

[rows cols D] = size(X);
X2D = reshape(X, rows*cols, D);
max_depth = max(X2D(:));
mu=0;
F = zeros(rows, cols);
me=zeros(1,D);
for k = 1:D   
    front = X(:,:,k);

    if k > 1
        mu=mu+nnz(abs(front - front_pre));

    end
    front_pre = front;
    
    me(1,k)=mu;
   
end

me=me/mu;

