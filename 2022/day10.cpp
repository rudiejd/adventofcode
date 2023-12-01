#include <iostream>
#include <queue>
#include <fstream>
#include <sstream>
#include <unordered_set>
#include <vector>
#include <unordered_map>
#include <stack>
#include <deque>
#include <tuple>
#include <algorithm>

using namespace std;

void log(int sum, int cycleCount, int reg) {
    // cout << "cycle count " << cycleCount << ", reg=" << reg << " signal=" << reg * cycleCount << " sum=" << sum << endl;
    if (abs(reg - (cycleCount % 40))  <= 1) {
        cout << "#";
    } else {
        cout << ".";
    }
    if (cycleCount > 0 && !(cycleCount % 40)) cout << endl;
}


void accumulateSpecialVals(int& sum, int cycleCount, int reg) {
    if (cycleCount == 20 || (cycleCount - 20) % 40 == 0) { 
        sum += reg * cycleCount; 
    }
}

// horizontal position = cycleCount % 40
// vertical position = cycleCount / 40
int main(int argc, char** argv) {
    ifstream ifs(argv[1]);
    queue<int> q;
    int cycleCount = 1, reg = 1, sum = 0;
    for (string line; getline(ifs, line);) {
        // add the oldest instruction that was queued
        if (!q.empty()) {
            reg += q.front();
            q.pop();
            log(sum, cycleCount, reg);
            cycleCount++;
            accumulateSpecialVals(sum, cycleCount, reg);
        }

        

        istringstream iss(line);
        string instruction;
        iss >> instruction;
        if (instruction == "addx") {
            int V;
            iss >> V;
            q.push(V);
        }
        log(sum, cycleCount, reg);
        cycleCount++;
        accumulateSpecialVals(sum, cycleCount, reg);
    }

    // do remaining queued instructions
    while (!q.empty()) {
        reg += q.front();
        q.pop();
        cycleCount++;
        accumulateSpecialVals(sum, cycleCount, reg);
    }


    cout << sum << endl;

    return 0;
}


