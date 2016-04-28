/*
	This file has a simple functionality as well. 
	1. It takes in the output files from the filtering program as inputs.
	2. It creates an adjacency matrix out of each pair in a file. 
	Example: if there are 4 entries in the first file, it will create 1 node of each entry (and hence a 4 node, complete graph).
	If it encounters another file with 2 entries that are the same above, then two edges will increase in weight. If the entries
	are not in the first file, then 2 new nodes will be created. Its remarkably simple actually.


*/

//Include the libraries
#include <algorithm>
#include <vector>
#include <iostream>
#include <string>
#include <fstream>
#include <boost/algorithm/string.hpp>
#include <ctime>
#include <map>
using namespace std;

//Function to add strings to a vector from an ifstream
void add_to_vector(std::ifstream &reference_file, std::vector<std::string> &vect) {
	std::string str;				
	while (std::getline(reference_file, str)) {
		vect.push_back(str);
	}
	return;
}

int main()
{
	//My custom data structure. Its a 2D array, where each array element is accessed by a string rather than an integer
    std::map <std::string, std::map <std::string, unsigned int> > map;

    //create vector out of the brain structure names
    vector<string> vect;
    //std::ifstream names("brain_names_updated_noduplicates.txt");
    std::ifstream names("inputfiles/test_brain_names.txt");
    add_to_vector(names, vect);

    //initialize the vector
    for (uint64_t i=0; i<vect.size(); ++i) {
    	for (uint64_t j=0; j<vect.size(); ++j) {
    		map[vect[i]][vect[j]] = 0;
    		//Debugging line here
    		//cout<<vect[i]<<" ::: "<<vect[j]<<" ::: "<<map[vect[i]][vect[j]]<<endl;
    	}
    }

    //create vector of file names
    vector<string> file_names;
    std::ifstream filenames_stream("inputfiles/processed_file_names.txt");
    add_to_vector(filenames_stream, file_names);
    filenames_stream.close();

    //update the map if there are pairs
    for (uint64_t i=0; i<file_names.size(); ++i) {
    	//Debugging line here
    	//cout<<"File names : "<<file_names[i]<<endl;
    	//Read in the file 
    	std::ifstream val("inputfiles/datafiles/"+file_names[i]); 

    	//Create a vector for the input file that has the nodes
    	vector<string> values;			
    	//Add the strings to the vector
    	add_to_vector(val, values);

    	for (uint64_t j=0; j<values.size()-1; ++j) {
    		for (uint64_t k=j+1; k<values.size(); ++k) {
    			++map[values[j]][values[k]]; //cout<<__LINE__<<endl;
    			++map[values[k]][values[j]]; //cout<<__LINE__<<endl;
    		}
    	}
    	val.close();
    }


   	 ofstream out("output.csv");
    //print it out to a csv file
    for (uint64_t i=0; i<vect.size(); ++i) {
    	for (uint64_t j=0; j<vect.size(); ++j) {
    		//Debugging line here
    		//cout<<vect[i]<<" - "<<vect[j]<<" : "<<map[vect[i]][vect[j]]<<endl;
    		cout<<map[vect[i]][vect[j]]<<" ";
    		out<<map[vect[i]][vect[j]]<<",";
    	}
    	cout<<" "<<endl;
    	out<<","<<endl;
    }

    out.close();

    return 0;
}