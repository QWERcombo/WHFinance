//
//  MyProfitDetailCell.m
//  WHFinance
//
//  Created by wanhong on 2017/7/6.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MyProfitDetailCell.h"

@implementation MyProfitDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initSubView {
    self.backgroundColor = [UIColor whiteColor];
    self.line = [UIView new];
    [self.contentView addSubview:self.line];
    self.line.backgroundColor = [UIColor Grey_LineColor];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    self.timeLab = [UILabel lableWithText:@"周五\n06-30" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    self.timeLab.numberOfLines = 2;
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(18);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    
    self.MoneyLab = [UILabel lableWithText:@"6.5" Font:FONT_Helvetica(14) TextColor:[UIColor Grey_OrangeColor]];
    [self.contentView addSubview:self.MoneyLab];
    [self.MoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.timeLab.mas_right).offset(86);
    }];
    
    self.detailLab = [UILabel lableWithText:@"消费返润    收入" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_BackColor]];
    self.detailLab.attributedText = [UILabel labGetAttributedStringFrom:self.detailLab.text.length-2 toEnd:2 WithColor:[UIColor Grey_OrangeColor] andFont:FONT_ArialMT(12) allFullText:self.detailLab.text];
    [self.contentView addSubview:self.detailLab];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.equalTo(@(12));
        make.top.equalTo(self.timeLab.mas_top).offset(2);
    }];
    
    
    UIImageView *imgv = [UIImageView new];
    [self.contentView addSubview:imgv];
    imgv.image = IMG(@"right_more");
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(16));
        make.bottom.equalTo(self.timeLab.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    UILabel *label = [UILabel lableWithText:@"交易详情" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.right.equalTo(imgv.mas_left).offset(-5);
        make.centerY.equalTo(imgv.mas_centerY);
    }];
    
}



+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 45;
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
    _clikBlock = clue;
    MyProfitModel *dataM = (MyProfitModel *)model;
    self.MoneyLab.text = [[NSString stringWithFormat:@"%@",dataM.transAmount] handleDataSourceTail];
    self.timeLab.text = [NSString stringWithFormat:@"%@\n%@",dataM.week, dataM.orderCreateTimeCn];
    self.detailLab.text = dataM.transDesc;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.timeLab.text];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.timeLab.text.length)];
    self.timeLab.attributedText = attributedText;
    
}

@end
