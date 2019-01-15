//
//  JRNetworking.h
//  MasonryLast
//
//  Created by ma qianli on 2018/9/18.
//  Copyright © 2018年 ma qianli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#define JRNetworkingSingleton [JRNetworking sharedInstance]
@interface JRNetworking : NSObject

/**
 精锐网络请求单例
 @return 精锐网络请求单例
 */
+(instancetype)sharedInstance;

//MARK: AFHTTPSessionManager对外请求接口
//

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id XresponseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress *downloadProgress))downloadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//MARK: AFURLSessionManager对外请求接口
//

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:(void (^)(NSURLResponse *response, id responseObject,  NSError * error))completionHandler;

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                                       params:(NSDictionary *)params
                                       header:(NSDictionary *)header
                            completionHandler:(void (^)(NSURLResponse *response, id responseObject,  NSError * error))completionHandler;

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                               uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                             downloadProgress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                            completionHandler:(void (^)(NSURLResponse *response, id responseObject,  NSError *error))completionHandler;

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
                                         fromFile:(NSURL *)fileURL
                                         progress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                                completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError  * error))completionHandler;

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
                                         fromData:(NSData *)bodyData
                                         progress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                                completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError * error))completionHandler;

- (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request
                                                 progress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                                        completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                          destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData
                                                progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                             destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                       completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;




@end
