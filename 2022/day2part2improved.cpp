#include<iostream>
#include<fstream>

// A = 1 B = 2 C = 3
using namespace std;
int main(int argc, char** argv) {
    ifstream stream(argv[1]);
    int score = 0;
    for (string line; getline(stream, line);) {
        char need = line[2], opp = line[0];
        if (need == 'Z') {
            score += 6 + ((opp - 'A' + 1)  % 3) + 1 ;
        } else if (need == 'X') {
            score += ((opp - 'A' + 2) % 3) + 1;
        } else {
            score += 3 + (opp - 'A') + 1;
        }
    }
    cout << score << endl;
    return 0;
}


