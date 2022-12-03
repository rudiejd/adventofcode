#include<iostream>
#include<fstream>
#include<unordered_set>

using namespace std;
int main(int argc, char** argv) {
    ifstream stream(argv[1]);
    cout << "hi" << endl;
    int score = 0;
    for (string line; getline(stream, line);) {
        unordered_set<char> firstCompartment;
        unordered_set<char> secondCompartment;
        cout << line << endl;
        for (auto i = 0; i < line.size(); i++) {
            if (i < line.size() / 2) {
                firstCompartment.insert(line[i]);
            }
            else if (firstCompartment.find(line[i]) != firstCompartment.end()) {
                if (isupper(line[i])) score += line[i] - 'A' + 27;
                else score += line[i] - 'a' + 1;
                break;
            }
        }
    }
    cout << score << endl;
    return 0;
}


