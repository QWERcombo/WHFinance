//
//  DataSend.h
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSend : NSObject

typedef void (^SuccessBlock)(NSDictionary *resultDic,NSString *msg);
typedef void (^FailureBlock)(NSString *error,NSInteger code);

+(NSString *)getPostByWithType:(NSString*)type;

+(NSMutableDictionary *)getPostByParameters:(NSMutableDictionary*)params;//序列

//唤醒握手
+(void)sendPostRequestToHandShakeWithBaseURL:(NSString *)baseUrl Dictionary:(NSMutableDictionary*)dict  WithType:(NSString*)type showAnimation:(BOOL)animation success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)sendPostWastedRequestWithBaseURL:(NSString *)baseUrl valueDictionary:(NSMutableDictionary*)dict imageArray:(NSArray *)imgArr WithType:(NSString*)type andCookie:(NSString *)cookie showAnimation:(BOOL)animation success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)cancelAllRequest;

@end
