//
//  MyProfitDetailModel.h
//  WHFinance
//
//  Created by wanhong on 2017/7/18.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

@interface MyProfitDetailModel : BaseModel

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *merchantName;

@property (nonatomic, strong) NSString *profitFee;

@property (nonatomic, strong) NSString *transAmount;

@property (nonatomic, strong) NSString *transFee;

@property (nonatomic, strong) NSString *transType;

@property (nonatomic, strong) NSString *transTypeCn;

@end
