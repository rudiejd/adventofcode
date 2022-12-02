#include<fstream>
#include<string>
#include<iostream>

using namespace std;
int main(int argc, char** argv) {
    ifstream stream(argv[1]);
    unsigned int currentCalories = 0, firstMaxCalories = 0, secondMaxCalories = 0, thirdMaxCalories = 0;
    for (string s; getline(stream, s);) {
        if (s.empty()) {
            if (currentCalories >= firstMaxCalories) {
                secondMaxCalories = firstMaxCalories;
                firstMaxCalories = currentCalories;
            } else if (currentCalories >= secondMaxCalories) {
                thirdMaxCalories = secondMaxCalories;
                secondMaxCalories = currentCalories;
            } else if (currentCalories >= thirdMaxCalories) {
                thirdMaxCalories = currentCalories;
            }
            currentCalories = 0;
        } else {
            currentCalories += stoi(s);
        }
    }
    cout << firstMaxCalories << " " << secondMaxCalories << " " << thirdMaxCalories << endl;
    cout << firstMaxCalories + secondMaxCalories + thirdMaxCalories << endl;
}
