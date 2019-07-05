//
//  TestC.cpp
//  JFC
//
//  Created by 黄鹏飞 on 2019/7/3.
//  Copyright © 2019 com.hpf. All rights reserved.
//
#include <iostream>
#include <stdio.h>
#include <cstring>

using namespace std;
struct BOOK{
    
    char name[50];
    char author[50];
    int version;
    int book_id;
};

void testBook(){
    
    BOOK book1;
    strcpy(book1.name, "C语言程序设计");
    strcpy(book1.author, "smartJeff");
    book1.version = 1;
    book1.book_id = 1;
    
    cout << "书名：" << book1.name << "\t 作者：" << book1.author << "\t 版本：" << book1.version << "\t 编号：" << book1.book_id << endl;
}
