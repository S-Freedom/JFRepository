//
//  JRNetworking.m
//  MasonryLast
//
//  Created by ma qianli on 2018/9/18.
//  Copyright © 2018年 ma qianli. All rights reserved.
//

#import "JRNetworking.h"
#import <Foundation/Foundation.h>
#import "JFUtils.h"

@interface JRNetworking ()


@end

@implementation JRNetworking

/**
 精锐网络请求单例
 @return 精锐网络请求单例
 */
+(instancetype)sharedInstance{
    static JRNetworking *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [JRNetworking new];
    });
    
    return instance;
}

//MARK: AFHTTPSessionManager对外请求接口
//

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(id)parameters
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    return [manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
    
    #pragma clang diagnostic pop
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(id)parameters
                              progress:(void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    return [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull progress) {
        downloadProgress(progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(id)parameters
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    manager.requestSerializer = requestSerializer;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    return [manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
    
    #pragma clang diagnostic pop
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(id)parameters
                               progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer new];
    
    return [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull progress) {
        uploadProgress(progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(id)parameters
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer new];
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    return [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
    
    #pragma clang diagnostic pop
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(id)parameters
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                               progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer new];
    
    return [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
    } progress:^(NSProgress * _Nonnull progress) {
        uploadProgress(progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
  
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
}

//MARK: AFURLSessionManager对外请求接口
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:(void (^)(NSURLResponse *response, id responseObject,  NSError * error))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [manager dataTaskWithRequest:request completionHandler:completionHandler];
    #pragma clang diagnostic pop
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                                       params:(NSDictionary *)params
                                       header:(NSDictionary *)header
                            completionHandler:(void (^)(NSURLResponse *response, id responseObject,  NSError * error))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    __block NSMutableString *queryString = [NSMutableString new];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *value = [JFUtils URLEncodedString:obj];
        [queryString appendFormat:@"%@=%@&", key, value];
    }];
    //删除最后一个“&”
    if(queryString.length > 0){
        [queryString deleteCharactersInRange:NSMakeRange(queryString.length - 1, 1)];
    }
    NSMutableURLRequest *mRequest = [request mutableCopy];
    mRequest.HTTPMethod = @"POST";
    mRequest.HTTPBody = [queryString dataUsingEncoding:NSUTF8StringEncoding];
    [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [mRequest setValue:obj forHTTPHeaderField:key];
    }];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    request = [mRequest copy];
    return [manager dataTaskWithRequest:request completionHandler:completionHandler];
    #pragma clang diagnostic pop
}



- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                               uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                             downloadProgress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                            completionHandler:(void (^)(NSURLResponse *response, id responseObject,  NSError *error))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    return [manager dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:completionHandler];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
                                         fromFile:(NSURL *)fileURL
                                         progress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                                completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError  * error))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    return [manager uploadTaskWithRequest:request fromFile:fileURL progress:uploadProgressBlock completionHandler:completionHandler];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
                                         fromData:(NSData *)bodyData
                                         progress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                                completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError * error))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    return [manager uploadTaskWithRequest:request fromData:bodyData progress:uploadProgressBlock completionHandler:completionHandler];
}

- (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request
                                                 progress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                                        completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    return [manager uploadTaskWithStreamedRequest:request progress:uploadProgressBlock completionHandler:completionHandler];
}

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                          destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    return [manager downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
}

- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData
                                                progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                             destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                       completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    return [manager downloadTaskWithResumeData:resumeData progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
}





























@end
