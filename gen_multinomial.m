function G = gen_multinomial( A )
%Generate an ER random graph with power law weights
%   Given a weighted adjacency matrix A, the function generates
%   redistributes the available budget using a multinomial distribution
%   assignment on the edges, preserving the overall budget, according to a
%   probability vector determined as a Dirichlet random vector.
%   Input: Weighted adjancency matrix A
%   Output: Weighted adjacency matrix of random graph G

n = length(A);

S = floor(sum(A(:))/2);

for i=1:n
    non_zero_ind = find(A(i,:) ~= 0);
    p(i) = 1 - length(non_zero_ind)/(n-1);
end

G = zeros(n);

m = n*(n-1)/2;
a = 10*ones(m,1);
q = dirich_rnd(a);
X = mnrnd(S,q);
k=0;

for i=1:n
    for j=i+1:n
        k=k+1;
        G(i,j) = X(k);
    end
end

G = G+G';

end

