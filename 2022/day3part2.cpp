#include<iostream>
#include<fstream>
#include<unordered_set>
#include<string>

using namespace std;
int main(int argc, char** argv) {
    ifstream stream(argv[1]);
    int score = 0;
    unordered_set<char> firstElf;
    unordered_set<char> secondElf;
    int j = 0;
    for (string line; getline(stream, line);) {
        for (auto i = 0; i < line.size(); i++) {
            if (j % 3 == 0) {
                firstElf.insert(line[i]);
            } else if (j % 3 == 1) { 
                secondElf.insert(line[i]);
            } else {
                if (firstElf.find(line[i]) != firstElf.end() && secondElf.find(line[i]) != secondElf.end()) {
                    if (isupper(line[i])) {
                        score += line[i] - 'A' + 27;
                    } else {
                        score += line[i] - 'a' + 1;
                    }
                    break; 

                }
            }
       
        }
        if (j % 3 == 2) { 
            firstElf.clear();
            secondElf.clear();
        }
        j++;
    }
    cout << score << endl;
    return 0;
}


