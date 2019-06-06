//
//  JFimageUtils.m
//  JROpenCVLearning
//
//  Created by 黄鹏飞 on 2019/6/6.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFImageUtils.h"

@implementation JFImageUtils

+ (UIImage *)opcvImage:(UIImage *)image level:(int)level{
    
    // 1. 将IOS图片转换为openCV图片（Mat矩阵）
    Mat mat_image_src;
    UIImageToMat(image, mat_image_src);
    
    // 2. 确定宽高
    int width = mat_image_src.cols;
    int height = mat_image_src.rows;
    
    // opcv只支持对RGB的处理，如果是图片ARGB，则将ARGB转换成RGB
    Mat mat_image_dst;
    cvtColor(mat_image_src, mat_image_dst, CV_RGBA2RGB, 3);
    
    Mat mat_image_clone = mat_image_dst.clone();
    // 马赛克处理
    int x = width - level;
    int y = height - level;
    
    for (int i=0; i<y; i+=level){
        for(int j=0; j<x; j+=level){
            // 创建一个矩形区域
            Rect2i rect = Rect2i(j, i, level, level);
            
            // 给矩形区域填充数据
            Mat roi = mat_image_dst(rect);
            Scalar scalar = Scalar(mat_image_clone.at<Vec3b>(i,j)[0],
                                   mat_image_clone.at<Vec3b>(i,j)[1],
                                   mat_image_clone.at<Vec3b>(i,j)[2]);
            
            //将处理好矩形区域->数据->拷贝到图片上面去->修改后的数据
            //CV_8UC3解释一下->后面也会讲到
            //CV_:表示框架命名空间
            //8表示：32位色->ARGB->8位 = 1字节 -> 4个字节
            //U分析
            //两种类型：有符号类型(Sign->有正负->简写"S")、无符号类型(Unsign->正数->"U")
            //无符号类型：0-255(通常情况)
            //有符号类型：-128-127
            //C分析：char类型
            //3表示：3个通道->RGB
            Mat roiCopy = Mat(rect.size(), CV_8UC3, scalar);
            roiCopy.copyTo(roi);
        }
    }
    //第四步：将OpenCV图片->iOS图片
    return MatToUIImage(mat_image_dst);
}
@end
