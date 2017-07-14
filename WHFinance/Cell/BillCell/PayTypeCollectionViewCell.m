//
//  PayTypeCollectionViewCell.m
//  WHFinance
//
//  Created by wanhong on 2017/6/30.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "PayTypeCollectionViewCell.h"

@implementation PayTypeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView *content = [UIView new];
        content.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
        
        self.payImgv = [UIImageView new];
        [content addSubview:self.payImgv];
        [self.payImgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(35));
            make.centerX.equalTo(content.mas_centerX);
            make.top.equalTo(content.mas_top);
        }];
        
        
        self.payName = [UILabel lableWithText:@"" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
        [content addSubview:self.payName];
        [self.payName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(12));
            make.centerX.equalTo(self.payImgv.mas_centerX);
            make.top.equalTo(self.payImgv.mas_bottom).offset(5);
            make.bottom.equalTo(content.mas_bottom);
        }];
        
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor Grey_BackColor1];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(1));
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(1);
        }];
        
    }
    return self;
}
@end
