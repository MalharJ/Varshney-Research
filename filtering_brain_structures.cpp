/* This file has a very simple functionality - it has a number of files:
	1. Brain names.txt - this file contains all of the names of the individual brain structures, separated by a line. 
	(this will get converted to a vector)
	2. File names.txt - this file contains all of the names of the files that we need to text mine from. 
	(this will get converted to a vector)
	3. Data files - there are 130,000 of them. They will be referenced to by the vector above. Each one of the 130,000 files
	will be read LINE BY LINE, where each line will be searched for each entry of the top vector. One line will check each element of the vector,
	which will be repeated for all the lines of 1 file, which will be repeated for all of the files.

	The steps will be:
	1. Convert brain names.txt into a vector
	2. Convert file names.txt into a vector
	3. Create a for loop for all the files in the folder (ALL THE FILES)
		a. Create a new text file
		b. Create a loop to read in each line of one file (ONE FILE)
			i. Create a for loop to check each word of the vector (ONE LINE)
				- If one of the words is present in that line (and is new to the new file!), 
				then we store it in a temporary vector and write it to the new file
				- Repeat it for all of the words
			Repeat it for all lines of the file
		Repeat it for all files 
*/

//Include the libraries
#include <algorithm>
#include <vector>
#include <iostream>
#include <string>
#include <fstream>
#include <boost/algorithm/string.hpp>
#include <ctime>
using namespace std;

//Function to add strings to a vector from an ifstream
void add_to_vector(std::ifstream &reference_file, std::vector<std::string> &vect) {
	std::string str;				
	while (std::getline(reference_file, str)) {
		vect.push_back(str);
	}
	return;
}

//Function to check for duplicates
bool duplicate_present(const std::vector<string> &vect, const std::string check) {
	uint64_t i=0; 								//cout<<"LINE "<<__LINE__<<endl;
	while (i<vect.size()) {						//cout<<"LINE "<<__LINE__<<endl;
		if (boost::iequals(vect[i],check) || (vect[i]+" "==check+" ")||(" "+vect[i]==" "+check))
			return true;
		else ++i;
	}
	return false;
}

//Main function
int main() {
	clock_t begin = clock();

	
	int flag = 0;
	std::ofstream outfile_names("results/output_file_names.txt");

	//Step 1: Convert brain names.txt into a vector
	vector<string> structure_names;
	std::ifstream brain_structure_file("brain_names_updated.txt");
	add_to_vector(brain_structure_file, structure_names);

	//Step 2: Convert file names.txt into a vector
	vector<string> file_names;
	std::ifstream files("file_names/file_names.txt");
	add_to_vector(files, file_names);


	//Debugging stuff below
	std::cout<<"Size of the brain vector is "<<structure_names.size()<<std::endl;
	std::cout<<"Size of the files vector is "<<file_names.size()<<std::endl;

	//Step 3: Loop through all the elements in the file names file
	for (uint64_t i=0; i<file_names.size(); ++i) {
		cout<<file_names[i]<<endl;
																						//cout<<"LINE "<<__LINE__<<endl;
		//Get the stream of the file to read
		std::ifstream infile("inputfiles/"+file_names[i]);											//cout<<"LINE "<<__LINE__<<endl;
		std::string temp;																//cout<<"LINE "<<__LINE__<<endl;
		vector<string> output;															//cout<<"LINE "<<__LINE__<<endl;
		//Step 3b: create a for loop to read in each line of one file
		while (std::getline(infile, temp)) {	
			//Step 3b i :  Create a loop to check each word of the vector in that line
			for (uint64_t k=0; k<structure_names.size(); ++k) {							//cout<<"LINE "<<__LINE__<<endl;
				//Search for the string, if we find it push it to a vector
				//if (temp.find(structure_names[k])!=std::string::npos) {					//cout<<"LINE "<<__LINE__<<endl;
				boost::algorithm::to_lower(temp);
				boost::algorithm::to_lower(structure_names[k]);

				if (boost::contains(temp, structure_names[k])) {
					//cout<<"STRUCTURES IN FILE ARE "<<structure_names[k]<<endl;	
					//check to see if the string is duplicated in the output vector. If it isnt then we write it to the output
					if (output.size()==0)
						output.push_back(structure_names[k]);
					if (duplicate_present(output, structure_names[k]) == false) {		//cout<<"LINE "<<__LINE__<<endl;
						output.push_back(structure_names[k]);
					}
				}
			}
		}

		//Write results to new file - do it only if the output vector is not zero
		if (output.size() != 0) {	
			++flag;													
			// Step 3a: creating a new text file
			// Append a number to the end of the file name
			std::ofstream outfile("results/output" + std::to_string(i+1) + ".txt");												//cout<<"LINE "<<__LINE__<<endl;
			outfile_names<<"output"+ std::to_string(i+1) + ".txt"<<endl;
			for (uint64_t j = 0; j < output.size(); ++j) {								//cout<<"LINE "<<__LINE__<<endl;
				//cout<<output[j]<<endl;
				outfile<<output[j]<<endl;
			}
			outfile.close();															//cout<<"LINE "<<__LINE__<<endl;
		}
	}
	if (flag==0) cout<<"NOTHING FOUND"<<endl;
	outfile_names.close();
	clock_t end = clock();
	double elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
	cout<<"Time taken: "<<elapsed_secs<<endl;
	return 0;
}