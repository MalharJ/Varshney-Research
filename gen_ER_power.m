function G = gen_ER_power( A )
%Generate an ER random graph with power law weights
%   Given a weighted adjacency matrix A, the function generates an Erdos
%   Renyi random graph and weights the edges using random draws from the
%   power law distribution using ML estimates of the parameters obtained
%   from A.
%   Input: Weighted adjancency matrix A
%   Output: Weighted adjacency matrix of random graph G

n = length(A);

non_zero_ind = find(A ~= 0);
p = length(non_zero_ind)/(n*(n-1));

xmin = min(A(non_zero_ind));
x = log(A(non_zero_ind)/xmin);
alpha = 1 + length(non_zero_ind)/sum(x);

G = zeros(n);
ER_edges = [];
for i=1:n
    for j=i+1:n
        G(i,j) = binornd(1,p);
        if G(i,j) == 1
            ER_edges = [ER_edges n*(i-1)+j];
        end
    end
end

m = length(ER_edges);
U = unifrnd(0,1,1,m);
X = xmin*(1-U).^(-1/(alpha-1));
G(ER_edges) = X;

G = G+G';

G = floor(G);

end

