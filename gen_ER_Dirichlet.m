function G = gen_ER_Dirichlet( A )
%Generate an ER random graph with power law weights
%   Given a weighted adjacency matrix A, the function generates an Erdos
%   Renyi random graph and weights the edges by scaling random draws from the
%   Dirichlet distribution using ML estimates of the parameters obtained
%   from A.
%   Input: Weighted adjancency matrix A
%   Output: Weighted adjacency matrix of random graph G

n = length(A);

S = sum(A(:))/2;
non_zero_ind = find(A ~= 0);
p = length(non_zero_ind)/(n*(n-1));

G = zeros(n);
for i=1:n
    for j=i+1:n
        G(i,j) = binornd(1,p);
    end
end

ER_edges = find(G ~= 0);

a = 1;
m = length(ER_edges);
q = dirich_rnd(m);
X = S*q;
G(ER_edges) = round(X);

G = G+G';

end

