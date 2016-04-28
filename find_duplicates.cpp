//This file serves to find the positions of duplicate lines in a text file

//Include the libraries
#include <algorithm>
#include <vector>
#include <iostream>
#include <string>
#include <fstream>
#include <boost/algorithm/string.hpp>
#include <ctime>
using namespace std;

void add_to_vector(std::ifstream &reference_file, std::vector<std::string> &vect) {
	std::string str;				
	while (std::getline(reference_file, str)) {
		vect.push_back(str);
	}
	return;
}

int main() {
	std::ifstream in("brain_names_updated.txt");
	vector<string> words;
	add_to_vector(in, words);

	for (uint64_t i=0; i<words.size()-1; ++i) {
		for (uint64_t j=i+1; j<words.size(); ++j) {
			if (words[i]==words[j]) 
				cout<<i<<" "<<j<<endl;
		}
	}

	return 0;	
}
