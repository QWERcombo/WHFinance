//
//  BankSearchViewController.h
//  WHFinance
//
//  Created by wanhong on 2017/7/11.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseViewController.h"

@interface BankSearchViewController : BaseViewController
@property (nonatomic, copy) void(^PassBankNameBlock)(BankModel *bank);
@end
