//
//  LineView.m
//  WHFinance
//
//  Created by wanhong on 2017/7/12.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arr = @[@"交易成功",@"银行处理中",@"结算到账"];
        
        UIView *lastView = nil;
        for (NSInteger i=0; i<3; i++) {
            UIView *blank = [UIView new];
            [self addSubview:blank];
            [blank mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                if (lastView) {
                    make.top.equalTo(lastView.mas_bottom);
                } else {
                    make.top.equalTo(self.mas_top);
                }
                make.right.equalTo(self.mas_right);
                if (i==2) {
                    make.height.equalTo(@(16));
                } else {
                    make.height.equalTo(@(47));
                }
            }];
            
            UIImageView *imgv = [UIImageView new];
            imgv.tag = 110+i;
            [blank addSubview:imgv];
            imgv.image = IMG(@"status_yes");
            [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.equalTo(@(16));
                make.left.top.equalTo(blank);
            }];
            
            UILabel *status = [UILabel lableWithText:[arr objectAtIndex:i] Font:FONT_ArialMT(11) TextColor:[UIColor mianColor:1]];
            status.tag = 100+i;
            [blank addSubview:status];
            [status mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imgv.mas_right).offset(5);
                make.centerY.equalTo(imgv.mas_centerY);
                make.height.equalTo(@(11));
            }];
            
            UILabel *des = [UILabel lableWithText:@"" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
            des.numberOfLines = 0;
            [blank addSubview:des];
            des.tag = 120+i;
            [des mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(status.mas_left).offset(80);
                make.top.equalTo(status.mas_top);
                if (i==1) {
                    make.height.equalTo(@(30));
                } else {
                    make.height.equalTo(@(12));
                }
                make.right.equalTo(self.mas_right);
            }];
            
            
            lastView = blank;
        }
        UIImageView *line_1 = [UIImageView new];
        [self addSubview:line_1];
        line_1.image = IMG(@"line_yes");
        [line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(1));
            make.height.equalTo(@(31));
            make.left.equalTo(self.mas_left).offset(8);
            make.top.equalTo(self.mas_top).offset(16);
        }];
        _line_2 = [UIImageView new];
        [self addSubview:_line_2];
        _line_2.image = IMG(@"line_yes");
        [_line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(1));
            make.height.equalTo(@(31));
            make.left.equalTo(self.mas_left).offset(8);
            make.top.equalTo(self.mas_top).offset(63);
        }];
        
        
    }
    return self;
}

+ (UIView *)addLineViewWithStatus:(NSString *)status andTime:(NSString *)time {
    LineView *mainview = [[LineView alloc] initWithFrame:CGRectMake(0, 0, 150, 110)];
    mainview.creatTime = time;
    
    NSLog(@"****///**%@", status);
    if ([status integerValue]!=2) {
        UILabel *lastlab = [mainview viewWithTag:102];
        lastlab.textColor = [UIColor mianColor:2];
        UIImageView *imgv = [mainview viewWithTag:112];
        imgv.image = IMG(@"status_no");
        mainview.line_2.image = IMG(@"line_no");
    }
    UILabel *des = [mainview viewWithTag:120];
    des.text = time;
    UILabel *hint = [mainview viewWithTag:121];
    hint.text = @"正在出款\n请求成功";
    
    
    return mainview;
}

@end
