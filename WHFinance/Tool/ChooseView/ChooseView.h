//
//  ChooseView.h
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseView : UIView

@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, assign) NSInteger tradeNum, typeNum;
@property (nonatomic, strong) NSString *tradeStr, *typeStr;

+ (void)showChooseView:(BaseModel *)model WithBlock:(ClikBlock)clik inRootViewController:(BaseViewController *)delegate;

@end
