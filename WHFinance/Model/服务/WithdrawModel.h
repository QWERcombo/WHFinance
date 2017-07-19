//
//  WithdrawModel.h
//  WHFinance
//
//  Created by wanhong on 2017/7/18.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

@interface WithdrawModel : BaseModel

@property (nonatomic, strong) NSString *userLeve;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *withdrawCashAmount;

@property (nonatomic, strong) NSString *withdrawCashBankName;

@property (nonatomic, strong) NSString *withdrawCashBankNo;

@property (nonatomic, strong) NSString *withdrawCashBankSimpleName;

@property (nonatomic, strong) NSString *withdrawCashCard;

@property (nonatomic, strong) NSString *withdrawCashFee;

@end
