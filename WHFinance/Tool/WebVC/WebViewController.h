//
//  WebViewController.h
//  XiYouPartner
//
//  Created by 265G on 15/8/11.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)NSString *urlStr;

@end
