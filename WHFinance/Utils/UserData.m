//
//  UserData.m
//  XiYouPartner
//
//  Created by 265G on 15/8/19.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "UserData.h"

@interface UserData ()

@end
@implementation UserData

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        _uid =[aDecoder decodeObjectForKey:@"uid"];
        _bindTime=[aDecoder decodeObjectForKey:@"bindTime"];
        _createTime=[aDecoder decodeObjectForKey:@"createTime"];
        _mobileNumber=[aDecoder decodeObjectForKey:@"mobileNumber"];
        _modifyTime=[aDecoder decodeObjectForKey:@"modifyTime"];
        _option=[aDecoder decodeObjectForKey:@"option"];
        _password=[aDecoder decodeObjectForKey:@"password"];
        _readName=[aDecoder decodeObjectForKey:@"readName"];
        _userName=[aDecoder decodeObjectForKey:@"userName"];
        _userReadNameFlag=[aDecoder decodeObjectForKey:@"userReadNameFlag"];
        _userStatus=[aDecoder decodeObjectForKey:@"userStatus"];
        _userToken=[aDecoder decodeObjectForKey:@"userToken"];
        _agentId=[aDecoder decodeObjectForKey:@"agentId"];
        _referenceId=[aDecoder decodeObjectForKey:@"referenceId"];
        _isPartner=[aDecoder decodeObjectForKey:@"isPartner"];
        
        
        
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(_uid) [aCoder encodeObject:_uid forKey:@"uid"];
    if(_bindTime) [aCoder encodeObject:_bindTime forKey:@"bindTime"];
    if(_createTime) [aCoder encodeObject:_createTime forKey:@"createTime"];
    if(_mobileNumber) [aCoder encodeObject:_mobileNumber forKey:@"mobileNumber"];
    if(_modifyTime) [aCoder encodeObject:_modifyTime forKey:@"modifyTime"];
    if(_option) [aCoder encodeObject:_option forKey:@"option"];
    if(_password) [aCoder encodeObject:_password forKey:@"password"];
    if(_userName) [aCoder encodeObject:_userName forKey:@"userName"];
    if(_userReadNameFlag) [aCoder encodeObject:_userReadNameFlag forKey:@"userReadNameFlag"];
    if(_userStatus) [aCoder encodeObject:_userStatus forKey:@"userStatus"];
    if(_userToken) [aCoder encodeObject:_userToken forKey:@"userToken"];
    if(_readName) [aCoder encodeObject:_readName forKey:@"readName"];
    if(_agentId) [aCoder encodeObject:_agentId forKey:@"agentId"];
    if(_referenceId) [aCoder encodeObject:_referenceId forKey:@"referenceId"];
    if(_isPartner) [aCoder encodeObject:_isPartner forKey:@"isPartner"];
    
    
    
 }

-(void)giveData:(NSDictionary *)dic{
    UserData *user = [self initWithDictionary:dic error:nil];
    [self removeMe];
    [user saveMe];
}

+ (UserData *)currentUser
{
    if([self conformsToProtocol:@protocol(NSCoding)])
    {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",NSStringFromClass([self class])]];
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (obj) {
            return obj;
        }else{
            return [UserData new];
        }
    }
    return nil;
}

- (void)saveMe
{
    if ([self conformsToProtocol:@protocol(NSCoding)]) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:[NSString stringWithFormat:@"%@",NSStringFromClass([self class])]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)removeMe
{
    NSString *userToken = self.userToken;
//    NSString *version = self.iosVersion;
//    NSString *ggtTel = self.ggtTel;
//    NSString *ggtAboutUrl = self.ggtAboutUrl;
//    NSString *flushLetterTime = self.flushLetterTime;
//    NSString *flushNoticeTime = self.flushNoticeTime;
//    NSString *flushWallTime = self.flushWallTime;
//    NSString *isInner = self.isInner;
//    NSString *name = self.name;
//    NSString *wall = self.wallColumn;
//    NSString *wxName = @"";
//    NSString *address = self.address;
//    NSString *isPay = self.iosPay;
//    NSString *inviteTimeout = self.inviteTimeout;
//    NSString * redTimeout = self.redTimeout;
//    NSArray *giftArr = [NSArray arrayWithArray:self.giftList];
//    NSArray *gift1Arr = [NSArray arrayWithArray:self.gift1List];
//    NSArray *gift2Arr = [NSArray arrayWithArray:self.gift2List];
//    NSArray *gift3Arr = [NSArray arrayWithArray:self.gift3List];
//    NSArray *gift4Arr = [NSArray arrayWithArray:self.gift4List];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@",NSStringFromClass([self class])]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([self conformsToProtocol:@protocol(NSCoding)]) {
        UserData *uData = [UserData new];
        uData.userToken = userToken;
//        uData.gift1List = gift1Arr;
//        uData.gift2List = gift2Arr;
//        uData.gift3List = gift3Arr;
//        uData.gift4List = gift4Arr;
//        uData.iosVersion = version;
//        uData.flushLetterTime = flushLetterTime;
//        uData.flushNoticeTime = flushNoticeTime;
//        uData.flushWallTime   = flushWallTime;
//        uData.ggtTel = ggtTel;
//        uData.ggtAboutUrl = ggtAboutUrl;
//        uData.isInner = isInner;
//        uData.name = name;
//        uData.wallColumn = wall;
//        uData.openWxName = wxName;
//        uData.address = address;
//        uData.iosPay = isPay;
//        uData.inviteTimeout = inviteTimeout;
//        uData.redTimeout =  redTimeout;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:uData];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:[NSString stringWithFormat:@"%@",NSStringFromClass([self class])]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}


@end
