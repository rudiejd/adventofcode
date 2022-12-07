#include <iostream>
#include <fstream>
#include <sstream>
#include <unordered_set>
#include <vector>
#include <unordered_map>
#include <stack>
#include <deque>
#include <tuple>

using namespace std;

unordered_map<string, vector<string>> fileTree;
unordered_map<string, int> dirSizes;
unordered_set<string> computedList;

int getAdditionalSize(const string& dir) {
    int ret = 0;
    for (string child : fileTree[dir]) {
        ret += dirSizes[child];
        if (computedList.find(child) == computedList.end()) {
            ret += getAdditionalSize(child);
        }
    }
    computedList.insert(dir);
    return ret;
}

int main(int argc, char** argv) {
    ifstream ifs(argv[1]);
    string directoryName = "";
    for (string line; getline(ifs, line);) {
        istringstream iss(line);
        if (line[0] == '$') {
            if (line.find("cd") != string::npos) {
                iss >> directoryName >> directoryName >> directoryName;
                if (fileTree.find(directoryName) == fileTree.end()) {
                    vector<string> v;
                    fileTree[directoryName] = v;
                }
            }
        } else if (line.find("dir ") == 0) {
            string childDir;
            iss >> childDir >> childDir;
            fileTree[directoryName].push_back(childDir);
            
            if (fileTree.find(childDir) != fileTree.end()) {
                vector<string> v;
                fileTree[childDir] = v;
            }
        } else {
            int fileSize;
            iss >> fileSize;
            dirSizes[directoryName] += fileSize;

        }
    }
    for (auto e : fileTree) {
        dirSizes[e.first] += getAdditionalSize(e.first);
    }
    int score = 0;
    for (auto e : dirSizes) {
        cout << e.first << ": " << e.second << endl;
        if (e.second <= 100000) score += e.second;
    }
    cout << score << endl;
    return 0;
}


