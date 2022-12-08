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
                } else if (!directoryName.empty()){
                    directoryName = directoryName + "/" + changedName;
                } else {
                    directoryName = changedName;
                }
                cout << "changed to " << directoryName << endl;
                if (fileTree.find(directoryName) == fileTree.end()) {
                    fileTree[directoryName] = {};
                }
            }
        } else if (line.find("dir ") == 0) {
            string childDir;
            iss >> childDir >> childDir;
            childDir = directoryName + "/" + childDir;
            parent[childDir] = directoryName;
            fileTree[directoryName].push_back(childDir);

            if (fileTree.find(childDir) != fileTree.end()) {
                fileTree[childDir] = {};
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
    auto remainingCapacity = 70000000 - dirSizes["/"];
    int score = 0;
    auto minSize = ULLONG_MAX;
    string part2 = "";
    for (auto e : dirSizes) {
        if (e.second <= 100000) score += e.second;
        if (remainingCapacity + e.second >= 30000000) minSize = min(minSize, (unsigned long long) e.second);
    }
    cout << "part 1 score " << score <<  " part 2 answer " << minSize << endl;
    return 0;
}


