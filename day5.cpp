#include <iostream>
#include <fstream>
#include <sstream>
#include <unordered_set>
#include <vector>
#include <unordered_map>
#include <stack>
#include <deque>

using namespace std;

unordered_map<int, deque<char>> crateStacks;

int main(int argc, char** argv) {
    ifstream stream(argv[1]);
    int stackCount = 0;
    for (string line; getline(stream, line);) {
        if (line.substr(0, 4) == "move") {
            istringstream iss(line);
            string filler;
            int count, stackOne, stackTwo;
            iss >> filler >> count >> filler >> stackOne >> filler >> stackTwo;
            stack<char> holding;
            for (int i = 0; i < count; i++) {
                auto crate = crateStacks[stackOne].back();
                holding.push(crate);
                crateStacks[stackOne].pop_back();
            }
            while (!holding.empty()) {
                crateStacks[stackTwo].push_back(holding.top());
                holding.pop();
            }
        } else {
            if (stackCount == 0) stackCount = line.size() / 4;
            for (int i = 0; i < line.size(); i++) {
                if (isalpha(line[i])) {
                    crateStacks[i / 4 + 1].push_front(line[i]);
                }
            }
        }
    }
    for (int i = 1; i <= 9; i++) {
        cout << crateStacks[i].back();
    }
    cout << endl;
    return 0;
}


