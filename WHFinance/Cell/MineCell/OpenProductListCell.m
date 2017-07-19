//
//  OpenProductListCell.m
//  WHFinance
//
//  Created by wanhong on 2017/6/28.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "OpenProductListCell.h"

#define Color_ali [UIColor colorWithR:1 G:171 B:240 A:1]
#define Color_weixin [UIColor colorWithR:59 G:177 B:54 A:1]
#define Color_erweima [UIColor colorWithR:28 G:111 B:189 A:1]
#define Color_bank [UIColor colorWithR:0 G:128 B:136 A:1]

@implementation OpenProductListCell

- (void)initSubView {
    self.contentView.backgroundColor = [UIColor Grey_BackColor1];
    UIView *contentView = [UIView new];
    [self.contentView addSubview:contentView];
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    
    self.typeImgv = [UIImageView new];
    [contentView addSubview:self.typeImgv];
    self.typeImgv.layer.cornerRadius = 33/2;
    self.typeImgv.clipsToBounds = YES;
    self.typeImgv.backgroundColor = COLOR_TEMP;
    [self.typeImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(33));
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(contentView.mas_top).offset(17/2);
    }];
    
    self.typeTitle = [UILabel lableWithText:@"支付宝" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:1]];
    [contentView addSubview:self.typeTitle];
    [self.typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeImgv.mas_centerY);
        make.left.equalTo(self.typeImgv.mas_right).offset(10);
        make.height.equalTo(@(15));
    }];
    
    self.leftLab = [UILabel lableWithText:@"T+1费率  0.38%" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_BackColor]];
    [contentView addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(self.line.mas_bottom).offset(9);
    }];
    self.rightLab = [UILabel lableWithText:@"D+1费率  0.38%" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_BackColor]];
    [contentView addSubview:self.rightLab];
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.right.equalTo(contentView.mas_right).offset(-15);
        make.top.equalTo(self.line.mas_bottom).offset(9);
    }];
    
    
}


+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 90;
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
    NSString *sss = (NSString *)model;
    if ([sss integerValue]%4==0) {
        self.typeTitle.text = @"支付宝";
        self.typeTitle.textColor = Color_ali;
    }
    if ([sss integerValue]%4==1) {
        self.typeTitle.text = @"微信";
        self.typeTitle.textColor = Color_weixin;
    }
    if ([sss integerValue]%4==2) {
        self.typeTitle.text = @"二维码";
        self.typeTitle.textColor = Color_erweima;
    }
    if ([sss integerValue]%4==3) {
        self.typeTitle.text = @"银联";
        self.typeTitle.textColor = Color_bank;
    }
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
