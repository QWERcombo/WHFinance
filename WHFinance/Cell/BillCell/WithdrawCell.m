//
//  WithdrawCell.m
//  WHFinance
//
//  Created by wanhong on 2017/6/30.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "WithdrawCell.h"

@implementation WithdrawCell

- (void)initSubView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.payImgv = [UIImageView new];
    self.payImgv.backgroundColor = COLOR_TEMP;
    self.payImgv.layer.cornerRadius = 33/2;
    self.payImgv.clipsToBounds = YES;
    [self.contentView addSubview:self.payImgv];
    [self.payImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(33));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(12.5);
    }];
    
    self.titleLab = [UILabel lableWithText:@"招商银行" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payImgv.mas_right).offset(15);
        make.height.equalTo(@(14));
        make.top.equalTo(self.payImgv.mas_top).offset(0);
    }];
    
    
    self.numLab = [UILabel lableWithText:@"4521 4521 4521 4521 4521" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_BackColor]];
    [self.contentView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payImgv.mas_right).offset(15);
        make.height.equalTo(@(12));
        make.bottom.equalTo(self.payImgv.mas_bottom).offset(0);
    }];
    
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 55;
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
    
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
