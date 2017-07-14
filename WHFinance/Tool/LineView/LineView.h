//
//  LineView.h
//  WHFinance
//
//  Created by wanhong on 2017/7/12.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineView : UIView

@property (nonatomic, strong) NSString *creatTime;

@property (nonatomic, strong) UIImageView *line_2;

+ (UIView *)addLineViewWithStatus:(NSString *)status andTime:(NSString *)time;

@end
