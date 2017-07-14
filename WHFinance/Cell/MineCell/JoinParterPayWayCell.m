//
//  JoinParterPayWayCell.m
//  WHFinance
//
//  Created by wanhong on 2017/7/10.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "JoinParterPayWayCell.h"

@implementation JoinParterPayWayCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.typeImgv = [UIImageView new];
        [self.contentView addSubview:self.typeImgv];
        self.typeImgv.image = IMG(@"login_check");
        [self.typeImgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(20));
            make.left.equalTo(self.contentView.mas_left);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        self.nameLab = [UILabel lableWithText:@"" Font:FONT_ArialMT(10) TextColor:[UIColor mianColor:2]];
        [self.contentView addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeImgv.mas_right).offset(3);
            make.height.equalTo(@(20));
            make.right.equalTo(self.contentView.mas_right);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        
        
    }
    return self;
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
    _clikBlock = clue;
    NSString *sss = (NSString *)model;
    self.nameLab.text = sss;
    
}

@end
