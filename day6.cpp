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
    unordered_set<char> window;
    unsigned long long distinctSize = atoi(argv[2]);
    unsigned long long maxWindowSize = 0;
    for (string line; getline(stream, line);) {
	   for (int i = 0; i < line.size(); i++) {
		   for (int j = i; j < i + distinctSize; j++) {
		   	window.insert(line[j]);
		   }
		   if (window.size() == distinctSize) {
			   cout << "first after " << i + distinctSize << endl;
			   break;
		   }
		   window.clear();
	   }

    }
    return 0;
}


