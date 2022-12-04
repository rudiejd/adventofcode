#include<iostream>
#include<fstream>
#include<sstream>
#include<unordered_set>
#include<vector>

using namespace std;
struct Range {
    int hi;
    int lo;
    Range(int high, int low) : hi(high), lo(low){}
    bool contains(const Range& other) {
       return hi >= other.hi && lo <= other.lo;
    }
};

vector<Range> parseRanges(string input) {
    istringstream ss(input);
    char delim;
    int hi, lo;
    vector<Range> ret;
    while (ss >> hi >> delim >> lo) {
        ret.push_back(Range(hi, lo));
        if (ss.good()) ss >> delim;
    }
    return ret;
}

int main(int argc, char** argv) {
    ifstream stream(argv[1]);
    int score = 0;
    for (string line; getline(stream, line);) {
        auto vec = parseRanges(line);
        cout << "ranges: " << endl;
        for (auto range : vec) {
            cout << range.lo << " " << range.hi << endl;
        }
        if (vec[0].contains(vec[1]) || vec[1].contains(vec[0])) {
            score++;
        }
    }
    cout << score << endl;
    return 0;
}


