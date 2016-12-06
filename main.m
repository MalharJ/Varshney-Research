% Read in the data using connectome_reader
clear;
socp = 'social.xlsx';
strp= 'structural.xlsx';
lp = 'node_labels.txt';
[social,structural,social_results,structural_results,names,edgeNames] = connectome_reader(socp, strp, lp);
clear socp; clear strp; clear lp;

%Fill in the table
[social_results, structural_results] = connectome_properties(social_results, structural_results, social, structural);

%EDGE TESTS
%Edge test 1: Kolmogorov-Smirnov tests on random graphs
sz = 200;
[alphas_soc, vals_soc] = social_ks_test(social,structural, sz);
[alphas_ERpower_ks_test, vals_ERpower_ks_test] = erdos_renyi_power_ks_test(social, structural, sz);
[alphas_multinomial_ks_test, vals_multinomial_ks_test] = multinomial_ks_test(social, structural,sz);
[alphas_ERdirichlet_ks_test, vals_ERdirichlet_ks_test] = erdos_renyi_dirichlet_ks_test(social, structural, sz);
[alphas_shuffle,vals_shuffle] = random_shuffle(social, structural, sz);

figure();
subplot(2,2,1);
plot(alphas_soc, vals_soc, 'r'); 
hold on;
plot(alphas_ERpower_ks_test, vals_ERpower_ks_test, 'b');
xlabel('Alpha values');
ylabel('KS-test values');
title('Erdos-Renyi power random graph results');
legend('Social graph results' ,'Random graph results');

subplot(2,2,2);
plot(alphas_soc, vals_soc, 'r'); 
hold on;
plot(alphas_multinomial_ks_test, vals_multinomial_ks_test, 'b');
xlabel('Alpha values');
ylabel('KS-test values');
title('Multinomial random graph results');
legend('Social graph results' ,'Random graph results');

subplot(2,2,3);
plot(alphas_soc, vals_soc, 'r');
hold on;
plot(alphas_ERdirichlet_ks_test, vals_ERdirichlet_ks_test, 'b');
xlabel('Alpha values');
ylabel('KS-test values');
title('Erdos-Renyi Dirichlet random graph results');
legend('Social graph results' ,'Random graph results');

subplot(2,2,4);
plot(alphas_soc, vals_soc, 'r');
hold on;
plot(alphas_shuffle, vals_shuffle, 'b');
xlabel('Alpha values');
ylabel('KS-test values');
title('Shuffled random graph results');
legend('Social graph results' ,'Random graph results');

%Edge test 2: k-means clustering on hubs and edges
%kmeans_connectome_clustering(social, structural, names, edgeNames);

%Edge test 3: Edge betweenness centrality