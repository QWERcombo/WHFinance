//
//  PayModeModel.h
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

@interface PayModeModel : BaseModel
@property (nonatomic, strong) NSString *agentId;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) NSString *productContext;

@property (nonatomic, strong) NSString *productFee;

@property (nonatomic, strong) NSString *productTitle;

@property (nonatomic, strong) NSString *productType;

@property (nonatomic, strong) NSString *proudctDetailId;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *tid;

@end
