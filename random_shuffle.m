function [alphas_shuffle, vals_shuffle] = random_shuffle(social, structural, size_)

%ERDOS RENYI POWER GRAPH
sz = 200;

%Run for size_ iterations     
vals_shuffle = zeros(1,sz);
alphas_shuffle = zeros(1,sz);

for j=1:size_
    
    for p=1:9000
        a = randi([1 34], 1,1);
        b = randi([1 34], 1,1);
        c = randi([1 34], 1,1);
        d = randi([1 34], 1,1);
        tmp = social(a,b);
        social(a,b) = social(c,d);
        social(c,d) = tmp;
        tmp = social(b,a);
        social(b,a) = social(d,c);
        social(d,c) = tmp;
    end
    
    %Normalize the social graph by the maximum value in the structural graph
    social1 = social .* max(max(structural)) / max(max(social)); 

    for i=1:sz
        %Create thresholds
        delta = 0;
        alpha = max(max(structural)) / (i+150);
        alphas_shuffle(i) = alpha+alphas_shuffle(i);
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
        vals_shuffle(i) = vals_shuffle(i) + max(abs(cdf_strong_social - cdf_weak_social));
    end
end
alphas_shuffle = alphas_shuffle./size_;
vals_shuffle = vals_shuffle./size_;