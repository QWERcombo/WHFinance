//
//  PlistManager.m
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "PlistManager.h"

@implementation PlistManager
DEF_SINGLETON(PlistManager);

-(id)getObjectFormPlist:(NSString*)plistname WithKey:(NSString*)key
{
    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistname]];
    NSMutableDictionary *configDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    id obj = [configDic objectForKey:key];
    return obj;
}
-(void)fetchObjectForPlist:(NSString*)plistname WithKey:(NSString*)key andObject:(id)object
{
    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistname]];
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    if (!usersDic) {
        usersDic = [NSMutableDictionary new];
    }
    [usersDic setObject:object forKey:key];
    [usersDic writeToFile:plistPath atomically:YES];
}

-(void)createThePlistWithName:(NSString *)name
{
    //获取本地沙盒路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc ] init];
    [usersDic writeToFile:plistPath atomically:YES];
}
-(void)removeThePlist:(NSString *)name
{
    NSFileManager *manager=[NSFileManager defaultManager];
    //文件路径
    NSString *filepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    if ([manager removeItemAtPath:filepath error:nil]) {
        NSLog(@"文件删除成功");
    }
}
- (void)clearAllUserDefaultsData
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}
//+(void)storageUserDefaultsWithValue:(id)value key:(NSString *)key type:(KEY_TYPES)type
//{
//    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
//    if (type == keyType_integer) {
//        [userDefault setInteger:[value integerValue] forKey:key];
//    }
//    else if (type == keyType_float) {
//        [userDefault setFloat:[value floatValue] forKey:key];
//    }
//    else if (type == keyType_double) {
//        [userDefault setDouble:[value doubleValue] forKey:key];
//    }
//    else if (type == keyType_bool) {
//        [userDefault setBool:[value boolValue] forKey:key];
//    }
//    else if (type == keyType_url) {
//        [userDefault setURL:value forKey:key];
//    }
//    else{
//        [userDefault setObject:value forKey:key];
//    }
//    [userDefault synchronize];
//}
//
//+(id)fetchDefaultsWithKey:(NSString *)key
//{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//
//    return [userDefault objectForKey:key];
//}

@end
