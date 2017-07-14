//
//  PlistManager.h
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef enum
//{
//    keyType_integer = 0,
//    keyType_float   = 1,
//    keyType_double  = 2,
//    keyType_bool    = 3,
//    keyType_url     = 4,
//    keyType_rest    = 5
//}
//KEY_TYPES;

@interface PlistManager : NSObject

AS_SINGLETON(PlistManager);

-(void)fetchObjectForPlist:(NSString*)plistname WithKey:(NSString*)key andObject:(id)object;//添加

-(id)getObjectFormPlist:(NSString*)plistname WithKey:(NSString*)key;//获取

-(void)removeThePlist:(NSString *)name;//删除name.plist

-(void)clearAllUserDefaultsData;//清除所有的存储本地的数据



//+(void)storageUserDefaultsWithValue:(id)value key:(NSString *)key type:(KEY_TYPES)type;//存
//
//+(id)fetchDefaultsWithKey:(NSString *)key;//取
@end
