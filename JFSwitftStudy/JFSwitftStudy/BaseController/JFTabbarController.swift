//
//  JFTabbarController.swift
//  JFSwitftStudy
//
//  Created by 黄鹏飞 on 2019/5/31.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import UIKit

class JFTabbarController: UITabBarController  {

    override func viewDidLoad() {
        super.viewDidLoad()

        initWithControllers()
    }
    
    func initWithControllers(){
        
        let homeNavi = self.initController(vc: JFHomeViewController(), title: titles[0], imageDic: images[0])
        let liveNavi = self.initController(vc: JFLiveController(), title: titles[1], imageDic: images[1])
        let studyNavi = self.initController(vc: JFStudyController(), title: titles[2], imageDic: images[2])
        let meNavi = self.initController(vc: JFMeViewController(), title: titles[3], imageDic: images[3])
        self.viewControllers = [homeNavi, liveNavi, studyNavi, meNavi]
        print(self.viewControllers!)
    }
    
    func initController(vc : UIViewController, title: String, imageDic:Dictionary<String,String>)-> UINavigationController{
        
        let navi : UINavigationController = UINavigationController(rootViewController: vc)
        let images = setBottomImages(dic: imageDic)
        navi.tabBarItem = UITabBarItem(title:title , image: images.0, selectedImage: images.1)
        return navi;
    }
    
    func setBottomImages( dic: [String : String]) -> (UIImage, UIImage){
        
        let homeNormalImage = UIImage(named: dic["normal"]!)!
        let homeHighImage = UIImage(named: dic["highlighted"]!)!
        return (homeNormalImage, homeHighImage)
    }
    
    lazy var titles :[String] = {
        
        return ["首页","直播", "学习", "我的"]
    }()
    
    lazy var images : [Dictionary<String, String>] = {
        
        return [[
            "normal":"tabbar_xuanke_normal", "highlighted":"tabbar_xuanke_highlighted"
            ],
                [
                    "normal":"tabbar_xuexi_normal", "highlighted":"tabbar_xuexi_highlighted"
            ],
                [
                    "normal":"tabbar_gouwuche_normal", "highlighted":"tabbar_gouwuche_highlighted"
            ],
                [
                    "normal":"tabbar_personal_normal", "highlighted":"tabbar_personal_highlighted"
            ]]
    }()
}
