function [social,structural,social_results,structural_results,names,edgeNames] = connectome_reader(social_path, structural_path, labels_path);

% CONNECTOME_READER
% This function takes in 3 different parameters - the social connectome, the structural connectome, and the 
% node labels of the connectomes. 
% 
% It returns the:
%     -adjacency matrix of the social connectome
%     -adjacency matrix of the structural connectome 
%     -names of the nodes in both connectomes 
%     -adjacency matrix of node-node names
%     -empty table containing node test-values of social and structural connectomes
%     
% Malhar Jere, University of Illinois at Urbana Champaign, 2016

%Part 1: Read in the graphs and construct preliminary data
social = xlsread(social_path);
structural = xlsread(structural_path);


%Normalize the social to the structural
social = social .* (max(structural(:))/max(social(:)));


%Read in the names of the brain regions
%This creates a cell that holds the names of the nodes
fid = fopen(labels_path,'r');
names = cell(length(social),1);

for i=1:length(social)
    names{i} = fgetl(fid);
end


%This creates a cell that holds the edge labels
edgeNames = cell(length(social),length(social));
for i=1:length(social)
    for j=1:length(social)
        edgeNames{i,j} = strcat(names{i},'-',names{j});
    end
end


%The cell that holds the values for the social structure
social_results = cell(length(social),16);

%The cell that holds the values for the social structure
structural_results = cell(length(social),16);

%Initialize stuff
social_results{1,1} = 'Names of regions';
social_results{1,2} = 'Degrees';
social_results{1,3} = 'Degree ranks in descending';
social_results{1,4} = 'Strengths';
social_results{1,5} = 'Strength ranks in descending';
social_results{1,6} = 'Clustering Coefficient';
social_results{1,7} = 'Clustering Coefficient ranks in descending';
social_results{1,8} = 'Local Efficiency';
social_results{1,9} = 'Local Efficiency ranks in descending';
social_results{1,10} = 'Eigenvector Centrality';
social_results{1,11} = 'Eigenvector Centrality ranks in descending';
social_results{1,12} = 'Subgraph Centrality';
social_results{1,13} = 'Subgraph Centrality ranks in descending';
social_results{1,14} = 'Node Betweenness Centrality';
social_results{1,15} = 'Node Betweenness Centrality ranks in descending';
social_results{1,16} = 'Hub ranking in descending';

for i=1:16
    structural_results{1, i} = social_results{1,i};
end

for i=1:length(social)
    social_results{i+1,1} = names{i};
    structural_results{i+1,1} = names{i};
end
clear fid; clear i; clear j;