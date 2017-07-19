//
//  PayWaysViewController.h
//  WHFinance
//
//  Created by 赵越 on 2017/7/2.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseViewController.h"

@interface PayWaysViewController : BaseViewController
@property (nonatomic, strong) UIColor *mainColor;//主颜色
@property (nonatomic, strong) NSString *moneyStr;//金额
@property (nonatomic, strong) NSString *proudctDetailId;//支付方式的id
@property (nonatomic, strong) NSString *payWay;//支付方式 0微信1QQ2支付宝3银联
@property (nonatomic, strong) NSString *isParter;

@end
