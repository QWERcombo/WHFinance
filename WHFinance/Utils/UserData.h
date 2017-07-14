//
//  UserData.h
//  XiYouPartner
//
//  Created by 265G on 15/8/19.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : BaseModel

@property (nonatomic,strong)NSString        *uid;//用户ID
@property (nonatomic,strong)NSString        *bindTime;//绑定时间
@property (nonatomic,strong)NSString        *createTime;//创建时间
@property (nonatomic,strong)NSString        *mobileNumber;//手机号
@property (nonatomic,strong)NSString        *modifyTime;//修改时间
@property (nonatomic,strong)NSString        *option;//设置
@property (nonatomic,strong)NSString        *password;//密码
@property (nonatomic,strong)NSString        *readName;//实名认证
@property (nonatomic,strong)NSString        *userName;//用户名
@property (nonatomic,strong)NSString        *userReadNameFlag;//实名认证状态  0审核中1审核通过
@property (nonatomic,strong)NSString        *userStatus;//
@property (nonatomic,strong)NSString        *userToken;//Token
@property (nonatomic,strong)NSString        *agentId;//
@property (nonatomic,strong)NSString        *referenceId;//
@property (nonatomic,strong)NSString        *isPartner;//是否是合伙人


//赋值
-(void)giveData:(NSDictionary *)dic;
//保存用户数据
- (void)saveMe;
//删除用户数据
- (void)removeMe;

+ (UserData *)currentUser;

@end
