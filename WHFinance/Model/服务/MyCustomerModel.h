//
//  MyCustomerModel.h
//  WHFinance
//
//  Created by wanhong on 2017/7/20.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

@interface MyCustomerModel : BaseModel

@property (nonatomic, strong) NSString *agent;

@property (nonatomic, strong) NSString *agentId;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *firstCus;

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *isPartner;

@property (nonatomic, strong) NSString *mobileNumber;

@property (nonatomic, strong) NSString *modifyTime;

@property (nonatomic, strong) NSString *partner;

@property (nonatomic, strong) NSString *platformId;

@property (nonatomic, strong) NSString *readName;

@property (nonatomic, strong) NSString *secondCus;

@property (nonatomic, strong) NSString *thridCus;

@property (nonatomic, strong) NSString *todayFirstCust;

@property (nonatomic, strong) NSString *todaySecondCust;

@property (nonatomic, strong) NSString *todayThridCust;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *userReadNameFlag;

@property (nonatomic, strong) NSString *userLeveCn;//客户角色

@end
