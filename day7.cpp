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
unordered_map<string, string> parent;
unordered_map<string, int> dirSizes;
unordered_set<string> computedList;

void getAdditionalSize(const string& dir) {
    if (computedList.find(dir) != computedList.end()) return;
    for (string child : fileTree[dir]) {
        getAdditionalSize(child);
        dirSizes[dir] += dirSizes[child];
    }
    computedList.insert(dir);
}

int main(int argc, char** argv) {
    ifstream ifs(argv[1]);
    string directoryName = "";
    for (string line; getline(ifs, line);) {
        istringstream iss(line);
        if (line[0] == '$') {
            if (line.find("cd") != string::npos) {
                string changedName;
                iss >> changedName >> changedName >> changedName;
                if (changedName == "..") {
                    directoryName = parent[directoryName];
                } else {
                    directoryName = changedName;
                }
                cout << "changed to " << directoryName << endl;
                if (fileTree.find(directoryName) == fileTree.end()) {
                    vector<string> v;
                    fileTree[directoryName] = v;
                }
            }
        } else if (line.find("dir ") == 0) {
            string childDir;
            iss >> childDir >> childDir;
            parent[childDir] = directoryName;
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
        getAdditionalSize(e.first);
    }
    int score = 0;
    for (auto e : dirSizes) {
        if (e.second <= 100000) score += e.second;
    }
    cout << score << endl;
    return 0;
}


