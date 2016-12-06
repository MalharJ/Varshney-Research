function [social_results, structural_results] = connectome_properties(social_results, structural_results, social, structural)

% PROPERTIES_FILLER
% This function runs all of the tests on the nodes.These are:
%   Degree: Number of edges coming out of a node
%   Strength: Sum of edge weights coming out of a node
%   Clustering Coefficient: 
%   Local Efficiency: 
%   Eigenvector Centrality: 
%   Subgraph centrality: 
%   Node betweenness centrality: 
%   Determining hubs: 
%   Small world characteristics: 
%   Clustering coefficient: 
%   Characteristic path length: 
% It fills these values in 2 different tables, 1 for the social and 1 for
% structural connectome
% Malhar Jere, University of Illinois at Urbana Champaign, 2016

%Part 2.1: Degree and degree ranks
%Degrees
degree_social = degrees_und(social);
degree_structural = degrees_und(structural);
%Ranks
[~,~,degree_social_ranks] = unique(1./degrees_und(social));
[~,~,degree_structural_ranks] = unique(1./degrees_und(social));
for i=1:length(social)
    %Social
    social_results(i+1,2) = num2cell(degree_social(i));
    %Structural
    structural_results(i+1,2) = num2cell(degree_structural(i));
end


%Part 2.2: Strength and strength ranks
strength_social = strengths_und(social);
strength_structural = strengths_und(structural);

%Ranks
[~,~,strength_social_ranks] = unique(1./strengths_und(social));
[~,~,strength_structural_ranks] = unique(1./strengths_und(structural));
for i=1:length(social)
    %Social
    social_results(i+1, 4) = num2cell(strength_social(i));
    social_results(i+1, 5) = num2cell(strength_social_ranks(i)); 
    %Structural
    structural_results(i+1, 4) = num2cell(strength_structural(i));
    structural_results(i+1, 5) = num2cell(strength_structural_ranks(i)); 
end

%Locations of hubs based on strengths in social graph
hubs_social_strengths = [29 14 27 23 6 21 12 30 15 8 22];
%Locations of hubs based on strenghts in structural graph
hubs_structural_strengths = [34 29 6 24 12 22 14 20 30 9 23];
%Locations of hubs based on degrees in social graphs
hubs_social_degrees = [];
%Locations of hubs based on degrees in structural graphs
hubs_structural_degrees=[];

%Part 2.3: Clustering Coefficient
%CC_social = clustering_coef_wu(social);
%CC_structural = clustering_coef_wu(structural);

%Part 2.4: Local Efficiency

%Part 2.5: Eigenvector Centrality

%Part 2.6: Subgraph centrality

%Part 2.7: Node betweenness centrality

%Part 2.8: hubs

%Part 2.9: Small world characteristics
