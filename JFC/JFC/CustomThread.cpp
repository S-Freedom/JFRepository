//
//  CustomThread.cpp
//  JFC
//
//  Created by 黄鹏飞 on 2019/7/5.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#include <stdio.h>
#include <pthread.h>
#include <iostream>

//using namespace std;
//void sayHello(void *args){
//    
//    std::cout << "sayHello" << std::endl;
//}
//
//void creatThread(){
//    
//    int count = 5;
//    pthread_t tids[count];
//    
//    for (int i =0; i<count; i++) {
//      
//        int ret = pthread_create(&tids, NULL, sayHello, NULL);
//        if(ret != 0){
//            cout << "phtread_create error : error_code : " << ret << endl;
//        }
//    }
//    pthread_exit(NULL);
//}
