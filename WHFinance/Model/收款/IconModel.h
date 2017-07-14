//
//  IconModel.h
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

@interface IconModel : BaseModel
@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) NSString *iconSelected;

@property (nonatomic, strong) NSString *productName;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *tid;
@end
