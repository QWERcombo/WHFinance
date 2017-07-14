//
//  TransOrder.h
//  WHFinance
//
//  Created by wanhong on 2017/7/12.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

@interface TransOrder : BaseModel//结算订单

@property (nonatomic, strong) NSString *orderAmount;

@property (nonatomic, strong) NSString *orderCreateTime;

@property (nonatomic, strong) NSString *orderCreateTimeCn;

@property (nonatomic, strong) NSString *orderFee;

@property (nonatomic, strong) NSString *orderNo;

@property (nonatomic, strong) NSString *orderSettlementFee;

@property (nonatomic, strong) NSString *orderStatus;

@property (nonatomic, strong) NSString *orderStatusCn;

@property (nonatomic, strong) NSString *orderType;

@property (nonatomic, strong) NSString *orderTypeCn;

@property (nonatomic, strong) NSString *productDetailId;

@property (nonatomic, strong) NSString *tid;

@property (nonatomic, strong) NSString *week;

@end
