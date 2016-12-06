function [alphas_soc, vals_soc] = social_ks_test(social, structural, size_)

%ERDOS RENYI POWER GRAPH
%First plot the social graph
%Normalize the social graph by the maximum value in the structural graph
social1 = social .* max(max(structural)) / max(max(social)); 
sz = 200;
vals_soc = zeros(1,sz);
alphas_soc = zeros(1,sz);
loc = zeros(1,sz);

for i=1:sz
    %Create thresholds
    delta = 0;
    alpha = max(max(structural)) / (i+150);
    alphas_soc(i) = alpha;
    less_idx = find(structural <=(alpha - delta));
    more_idx = find(structural > (alpha + delta));

    %Create social values
    weak_social = social1(less_idx);
    strong_social = social1(more_idx);

    %Create PMFs
    v1 = linspace(min(min(social1)), max(max(social1)), 20);
    v2 = linspace(min(min(social1)), max(max(social1)), 20);
    
    pmf_weak = (hist(weak_social, v1));
    pmf_weak = pmf_weak ./ length(weak_social(:));
    pmf_strong = (hist(strong_social, v2));
    pmf_strong = pmf_strong ./ length(strong_social(:));

    %Create CDF for weak edges
    cdf_weak_social = cumsum(pmf_weak);
    cdf_strong_social = cumsum(pmf_strong);
    
    
    %%Ks test
    [vals_soc(i), loc(i)] = max(abs(cdf_strong_social - cdf_weak_social));
end