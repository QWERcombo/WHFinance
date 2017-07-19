//
//  RealCertificateModel.h
//  WHFinance
//
//  Created by wanhong on 2017/7/17.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

@interface RealCertificateModel : BaseModel

@property (nonatomic, strong) NSString *bankCardNo;

@property (nonatomic, strong) NSString *bankName;

@property (nonatomic, strong) NSString *bankNo;

@property (nonatomic, strong) NSString *bankNoId;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *tid;

@property (nonatomic, strong) NSString *identityCardNo;

@property (nonatomic, strong) NSString *modifyTime;

@property (nonatomic, strong) NSString *realName;

@property (nonatomic, strong) NSString *status;//  0待审核 1成功(无图) 2成功(有图)

@end
