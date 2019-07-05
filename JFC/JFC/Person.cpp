
class Person{
public:
    int age;
    char name[50];
    char address[200];
    int length;
    double getMyMoney();
    void setMyAge(int age);
    void setMyName(char* n);
    void setMyAddress(char* addr);
    int getMyAge();
    char *getMyName();
    char *getMyAddress();
    Person();   // 构造函数
    Person(double m); // 带参构造函数
    Person(const Person &person);   // 拷贝构造函数
    ~Person();  // 析构函数
    
    void introduce(Person p);
    
    Person operator+(const Person &p);
private:
    double money;
    int *ptr;
};


