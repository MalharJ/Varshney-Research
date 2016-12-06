function [alphas_multinomial_ks_test, vals_multinomial_ks_test] = multinomial_ks_test(social, structural, size_)

%MULTINOMIAL GRAPH
sz = 200;

%Multinomial stuff
vals_multinomial = zeros(1,sz);
alphas_multinomial = zeros(1,sz);

%Run for size_ iterations 
for j=1:size_
    social = gen_multinomial(social);

    %Normalize the social graph by the maximum value in the structural graph
    social1 = social .* max(max(structural)) / max(max(social)); 


    for i=1:sz
        %Create thresholds
        delta = 0;
        alpha = max(max(structural)) / (i+150);
        alphas_multinomial(i) = alpha + alphas_multinomial(i);
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
        vals_multinomial(i)= vals_multinomial(i)+ max(abs(cdf_strong_social - cdf_weak_social));
    end
end
alphas_multinomial_ks_test = alphas_multinomial./size_;
vals_multinomial_ks_test = vals_multinomial./size_;