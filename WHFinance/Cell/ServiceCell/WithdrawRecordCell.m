//
//  WithdrawRecordCell.m
//  WHFinance
//
//  Created by wanhong on 2017/6/27.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "WithdrawRecordCell.h"

@implementation WithdrawRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)initSubView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor Grey_LineColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@(1));
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    self.bankImgv = [UIImageView new];
    [self.contentView addSubview:self.bankImgv];
    self.bankImgv.image = IMG(@"");
    self.bankImgv.layer.cornerRadius = 35/2;
    self.bankImgv.clipsToBounds = YES;
    self.bankImgv.backgroundColor = COLOR_TEMP;
    [self.bankImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(35));
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    self.nameLab = [YXPUtil creatUILable:@"招商银行   尾号0025" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankImgv.mas_right).offset(15);
        make.height.equalTo(@(15));
        make.top.equalTo(self.contentView.mas_top).offset(13);
    }];
    
    self.timeLab = [YXPUtil creatUILable:@"2017-02-25 10:25" Font:FONT_Helvetica(11) TextColor:[UIColor Grey_BackColor]];
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankImgv.mas_right).offset(15);
        make.top.equalTo(self.nameLab.mas_bottom).offset(10);
        make.height.equalTo(@(12));
    }];
    
    self.MoneyLab = [YXPUtil creatUILable:@"￥20.00" Font:FONT_ArialMT(14) TextColor:[UIColor Black_WordColor]];
    [self.contentView addSubview:self.MoneyLab];
    [self.MoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 57;
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
