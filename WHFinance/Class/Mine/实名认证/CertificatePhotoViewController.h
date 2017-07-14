//
//  CertificatePhotoViewController.h
//  WHFinance
//
//  Created by 赵越 on 2017/7/2.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseViewController.h"

@interface CertificatePhotoViewController : BaseViewController
@property (nonatomic, strong) NSString *fromController;

@property (nonatomic, copy) void(^ReturnPhotoBlock)(NSMutableArray *photoArr);
@end
