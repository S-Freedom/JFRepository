#include <iostream>
#include <fstream>
#include <cstring>
#include "Person.cpp"
#include "FirstSpace.cpp"
#include <vector>
#include <stdexcept>
#include <pthread.h>
#include "unistd.h"
using namespace std;
//using namespace first_space;
//using namespace second_space;

//double Person::getMyMoney(){
//    return money;
//}
//void Person::setMyAge(int a){
//    age = a;
//}
//void Person::setMyName(char* n){
//    strcpy(name, n);
//}
//void Person::setMyAddress(char* addr){
//    strcpy(address, addr);
//}
//int Person::getMyAge(){
//
//    return age;
//}
//char *Person::getMyName(){
//    return name;
//}
//char *Person::getMyAddress(){
//    return address;
//}
//
//void Person::introduce(Person p){
//
//    cout << "我是：" << p.getMyName() <<endl;
//}
//
//Person::Person(){
//    cout << "call out 无参构造函数" <<endl;
//}
//
//Person::Person(double m){
//    cout << "call out 带参构造函数" <<endl;
//    money = m;
//}
//
//Person Person::operator+(const Person& p){
//
//    cout << "call out add method" <<endl;
//    Person tempP;
//    tempP.length = this->length + p.length;
//    return tempP;
//}
////必须定义拷贝构造函数的情况：
////
////只包含类类型成员或内置类型（但不是指针类型）成员的类，无须显式地定义拷贝构造函数也可以拷贝；有的类有一个数据成员是指针，或者是有成员表示在构造函数中分配的其他资源，这两种情况下都必须定义拷贝构造函数。
////
////什么情况使用拷贝构造函数：
////
////类的对象需要拷贝时，拷贝构造函数将会被调用。以下情况都会调用拷贝构造函数：
////
////（1）一个对象以值传递的方式传入函数体
////（2）一个对象以值传递的方式从函数返回
////（3）一个对象需要通过另外一个对象进行初始化。
//Person::Person(const Person &person){
//    cout << "call out 拷贝构造函数" <<endl;
//    ptr = new int;
//    *ptr = *person.ptr; // 进行值拷贝
//}
//Person::~Person(){
//    cout << "call out 析构函数" <<endl;
//}
//
//void testPerson(){
//    Person p(12345);
//    p.setMyAge(25);
//    p.setMyName("jack1");
//    p.setMyAddress("beijing1");
//
//
//    cout << "姓名：" << p.getMyName() << endl;
//    cout << "地址：" << p.getMyAddress() << endl;
//    cout << "年龄：" << p.getMyAge() << endl;
//
//    // 对象以值传递的方式传参
//    //    p.introduce(p);
//    // 对象直接复制给新的对象
//    //    Person p1 = p;
//
//    p.length = 100;
//
//    Person p1;
//    p1.length = 200;
//
//    Person p2 = p + p1;
//    cout << "p2 length: " << p2.length <<endl;
//}
//
//void fileOpera(){
//    char data[100];
//    char path[100] = "/Users/huangpengfei/Desktop/C++/tempFile.text";
//    // 以写模式打开文件 ios:app 追加模式
//    ofstream outfile;
//    outfile.open(path, ios::app);
//    cout << "write to the file" << endl;
//    cout << "enter your name:" << endl;
//    cin.getline(data, 100);
//
//    // 向文件写入用户输入的数据
//    outfile << data << endl;
//
//    cout << "enter your age:" <<endl;
//    cin >> data;
//    cin.ignore();
//
//    // 再次写入数据
//    outfile << data << endl;
//    outfile.close();
//
//    // 以读模式打开文件
//    ifstream infile;
//    infile.open(path);
//    cout << "reading from file" <<endl;
//    infile >> data;
//    // 输出数据
//    cout << data <<endl;
//    infile >> data;
//    cout << data << endl;
//    infile.close();
//}
//
//void dynamicMemory(){
//
//        char *name = new char[20];
//        strcpy(name, "jackskjfdkdfj");
//        cout << name << endl;
//
//        delete [] name ;
//        cout << name << endl;
//
//
//        double* val = NULL;
//        val = new double;
//        *val = 123.345;
//        cout << *val << endl;
//        delete val;
//        cout << *val << endl;
//        int count = 10;
//        int size = 20;
//        int **array;
//        array = new int* [count];
//
//        for(int i=0;i<count; i++){
//
//            array[i] = new int[size];
//        }
//
//        // 释放
//        for(int i=0; i<count; i++){
//
//            delete [] array[i];
//        }
//        delete [] array;
//}

namespace first_space {
    
    void func(){
        cout << "inside first_space" << endl;
    }
    namespace first_in_space{
        
        void func(){
            
            cout << "inside first_in_space" << endl;
        }
    }
}

namespace second_space {
    
    void func(){
        cout << "inside second_space" << endl;
    }
}
using namespace first_space;
using namespace second_space;

template <class T>
class Stack {
private:
    vector<T> elems;
    
public:
    void push(T const &);
    void pop();
    T top() const;
    bool empty() const{
        return elems.empty();
    }
};

template <class T>
void Stack<T>::push(T const & elem){
    
    // 追加传入元素的副本
    elems.push_back(elem);
}
template <class T>
void Stack<T>::pop(){
    
    if(elems.empty()){
        throw out_of_range("Stack<T>::pop(): empty stack");
    }
    // 删除最后一个元素
    elems.pop_back();
}

template <class T>
T Stack<T>::top() const{
    
    if(elems.empty()){
        throw out_of_range("Stack<T>::pop(): empty stack");
    }
    // 返回最后一个元素的副本
    return elems.back();
}

void customStackT(){
    try {
        Stack<int> intStack;
        Stack<string> strStack;
        
        intStack.push(10);
        cout << intStack.top() << endl;
        
        strStack.push("jack");
        cout << strStack.top() << endl;
        
        strStack.pop();
        strStack.pop();
        
    } catch (exception const& e) {
        cerr << "Exception:" << e.what() << endl;
    }
}
void customNameSpace(){
        first_space::func();
        first_space::first_in_space::func();
        second_space::func();
}

struct thread_data{

    int thread_id;
    char *message;
};

void *PrintThread(void *thread_arg){

    if(thread_arg == NULL){
        cout << "thread_arg is  NULL" << endl;
        pthread_exit(NULL);
    }else{
        struct thread_data *my_data;
        my_data = (struct thread_data *)thread_arg;
        cout << "ThreadId:" << my_data->thread_id << endl;
        cout << "message:" << my_data->message << "\n" << endl;
        pthread_exit(NULL);
    }
}

void *wait(void *t){
    
    int i;
    int tid;
    tid = (long)t;
    sleep(1);
    cout << "sleeping in thread" << endl;
    cout << "thread with id : " << tid << "...exiting" << endl;
    pthread_exit(NULL);
}


#define ThreadNum 5
void createThread(){
    
    pthread_t tids[ThreadNum];
    struct thread_data my_data[ThreadNum];
    int ret;
    pthread_attr_t attr;
    for (int i=0; i<ThreadNum; i++) {
        
        cout << i << endl;
        my_data[i].thread_id = i;
        my_data[i].message = (char *)"this is message";
        
        pthread_attr_init(&attr);
//        PTHREAD_CREATE_JOINABLE:1 可连接的
        //        PTHREAD_CREATE_DETACHED:2   // 可分离的
        pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
        
//        ret = pthread_create(&tids[i], &attr, PrintThread, (void *)&my_data[i]);
//        if(ret != 0){
//            cout << "Error：unable to create thread" << ret << endl;
//            exit(1);
//        }
    }
    
    void *status;
    pthread_attr_destroy(&attr);
    for (int i =0; i<ThreadNum; i++) {
        ret = pthread_join(tids[i], &status);
        if(ret){
            cout << "error:unable to join, " << ret<< endl;
            exit(1);
        }
        cout << i << endl;
        cout << "exiting with status:" << status << endl;
    }
    
    cout << "Main: program exiting..." << endl;
    
    pthread_exit(NULL);
}

class CMyString
{
    public:
    CMyString(char* pData = nullptr);
    CMyString(const CMyString& str);
    ~CMyString(void);
    
    CMyString& operator = (const CMyString& str);
    
    void Print();
    
    private:
    char* m_pData;
};

CMyString::CMyString(char *pData)
{
    if(pData == nullptr)
    {
        m_pData = new char[1];
        m_pData[0] = '\0';
    }
    else
    {
        int length = strlen(pData);
        m_pData = new char[length + 1];
        strcpy(m_pData, pData);
    }
}

CMyString::CMyString(const CMyString &str)
{
    int length = strlen(str.m_pData);
    m_pData = new char[length + 1];
    strcpy(m_pData, str.m_pData);
}

CMyString::~CMyString()
{
    delete[] m_pData;
}

CMyString& CMyString::operator = (const CMyString& str)
{
    if(this == &str)
    return *this;
    
    delete []m_pData;
    m_pData = nullptr;
    
    m_pData = new char[strlen(str.m_pData) + 1];
    strcpy(m_pData, str.m_pData);
    
    return *this;
}

// ====================≤‚ ‘¥˙¬Î====================
void CMyString::Print()
{
    printf("%s", m_pData);
}

void Test1()
{
    printf("Test1 begins:\n");
    
    char* text = "Hello world";
    
    CMyString str1(text);
    CMyString str2;
    str2 = str1;
    
    printf("The expected result is: %s.\n", text);
    
    printf("The actual result is: ");
    str2.Print();
    printf(".\n");
}

// ∏≥÷µ∏¯◊‘º∫
void Test2()
{
    printf("Test2 begins:\n");
    
    char* text = "Hello world";
    
    CMyString str1(text);
    str1 = str1;
    
    printf("The expected result is: %s.\n", text);
    
    printf("The actual result is: ");
    str1.Print();
    printf(".\n");
}

// ¡¨–¯∏≥÷µ
void Test3()
{
    printf("Test3 begins:\n");
    
    char* text = "Hello world";
    
    CMyString str1(text);
    CMyString str2, str3;
    str3 = str2 = str1;
    
    printf("The expected result is: %s.\n", text);
    
    printf("The actual result is: ");
    str2.Print();
    printf(".\n");
    
    printf("The expected result is: %s.\n", text);
    
    printf("The actual result is: ");
    str3.Print();
    printf(".\n");
}

bool dulplicate(int numbers[], int length, int *duplication){

    if(numbers == nullptr || length <= 0)
    {
        return false;
    }

    for (int i =0; i<length; ++i)
    {
        if(numbers[i] < 0 || numbers[i] > length -1){
            return false;
        }
    }

    for (int i =0; i<length; ++i) {
        cout << "i:" << i << "numbers[i]:" << numbers[i] << endl;
        while (i != numbers[i]) {

            if(numbers[i] == numbers[numbers[i]]){

                *duplication = numbers[i];
                return true;
            }

            int temp = numbers[i];
            numbers[i] = numbers[temp];
            numbers[temp] = temp;
            cout << "交换" << numbers[i] << " 和" << numbers[numbers[i]] << endl;
        }
    }
    return false;
}

int main(int argc, char* argv[])
{
//    Test1();
//    Test2();
//    Test3();
    
    int numbers[] = {2,4,3,2,1,3};
    int results;
    int length = sizeof(numbers)/sizeof(int);
    dulplicate(numbers, length, &results);
    cout << "result" << results << endl;
    return 0;
}
