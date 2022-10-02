#include <iostream>
#include <sstream>
#include <iomanip>
#include <string>
using namespace std;
int main() {
    string s;
    while (getline(cin, s)) {
        istringstream iss(s);
        string inst;
        iss >> inst >> inst;
        inst.erase(inst.begin(), inst.begin()+2);
        cout << inst << endl;
    }
    return 0;
}