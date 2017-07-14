//
//  BankCardModel.h
//  WHFinance
//
//  Created by wanhong on 2017/7/13.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

@interface BankCardModel : BaseModel

@property (nonatomic, strong) NSString *tid;

@property (nonatomic, strong) NSString *cardBankCode;

@property (nonatomic, strong) NSString *cardBankName;

@property (nonatomic, strong) NSString *cardHolderName;

@property (nonatomic, strong) NSString *cardNo;

@end
