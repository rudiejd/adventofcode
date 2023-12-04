#include <fstream>
#include <iostream>
#include <unordered_map>

using namespace std;

const unordered_map<string, string> strToDigit = {
    {"one", "1"}, {"two", "2"},   {"three", "3"}, {"four", "4"}, {"five", "5"},
    {"six", "6"}, {"seven", "7"}, {"eight", "8"}, {"nine", "9"},
};

tuple<string, string> getFirstLastDigit(const string &str) {

  string firstDigit = "";
  auto i = 0;
  while (firstDigit.empty() && i < str.size()) {
      if (isdigit(str[i])) {
          firstDigit += str[i];
          break;
      }
      for (auto e : strToDigit) {
        size_t j = 0, k = i;
        auto numberName = e.first;
        while (j < numberName.size() && numberName[j] == str[k]) {
          j++;
          k++;
        }
        if (j >= numberName.size() - 1) {
            firstDigit = e.second;
            break;
        }
      }
      i++;
  }

  string lastDigit = "";
  auto l = str.size() - 1;
  while (lastDigit.empty() && l >= 0) {
      if (isdigit(str[l])) {
          lastDigit += str[l]; 
          break;
      }
      for (auto e : strToDigit) {
        auto numberName = e.first;
        int j = numberName.size() - 1;
        int k = l;
        while (j >= 0 && numberName[j] == str[k]) {
          j--;
          k--;
        }
        if (j <= 0) {
            lastDigit = e.second;
            break;
        }
      }
      l--;
  }

  return make_tuple(firstDigit, lastDigit);
}

int main(int argc, char **argv) {
  ifstream ifs(argv[1]);

  string line;

  auto acc = 0;
  while (getline(ifs, line)) {
    cout << line << endl;
    auto [firstDigit, lastDigit] = getFirstLastDigit(line);
    auto sum = stoi(firstDigit + lastDigit);
    cout << sum << endl;
    acc += sum;
  }
  cout << acc << endl;
}
