//
//  WithdrawRecordViewController.h
//  WHFinance
//
//  Created by wanhong on 2017/6/27.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseViewController.h"

@interface WithdrawRecordViewController : BaseViewController
@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, strong) NSString *cashStr;
@property (nonatomic, strong) NSString *isPartner;//支付合伙人
@end
