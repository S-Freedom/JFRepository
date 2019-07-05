//
//  AppDelegate.swift
//  JFMacDemo
//
//  Created by 黄鹏飞 on 2019/6/17.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window = NSWindow()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        self.window = NSApp.windows.first!;
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        print("click X 彻底杀掉程序")
//        return true;
        return false
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        
        if flag == false {
            self.window.makeKeyAndOrderFront(self)
        }
        return true
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        
    }


}

