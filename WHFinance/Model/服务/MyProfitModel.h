//
//  MyProfitModel.h
//  WHFinance
//
//  Created by wanhong on 2017/7/14.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

@interface MyProfitModel : BaseModel

@property (nonatomic, strong) NSString *accountId;

@property (nonatomic, strong) NSString *detailType;

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *tid;

@property (nonatomic, strong) NSString *transAmount;

@property (nonatomic, strong) NSString *transDesc;

@property (nonatomic, strong) NSString *orderCreateTimeCn;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *week;

@end
