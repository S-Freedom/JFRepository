//
//  JFimageUtils.h
//  JROpenCVLearning
//
//  Created by 黄鹏飞 on 2019/6/6.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/highgui.hpp>
#import <opencv2/core/types.hpp>

using namespace cv;

NS_ASSUME_NONNULL_BEGIN

@interface JFImageUtils : NSObject

+ (UIImage *)opcvImage:(UIImage *)image level:(int)level;
@end

NS_ASSUME_NONNULL_END
