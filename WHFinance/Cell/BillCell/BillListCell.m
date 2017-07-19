//
//  BillListCell.m
//  WHFinance
//
//  Created by wanhong on 2017/6/27.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BillListCell.h"

#define Color_Fault [UIColor colorWithR:235 G:51 B:15 A:1]

@implementation BillListCell

- (void)initSubView {
    self.backgroundColor = [UIColor whiteColor];
    
    self.timeLab = [UILabel lableWithText:@"周五\n06-30" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    self.timeLab.numberOfLines = 0;
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(18);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    
    self.payImgv = [UIImageView new];
    [self.contentView addSubview:self.payImgv];
    [self.payImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(20));
        make.left.equalTo(self.timeLab.mas_right).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    self.MoneyLab = [UILabel lableWithText:@"6.5" Font:FONT_Helvetica(14) TextColor:[UIColor Grey_OrangeColor]];
    [self.contentView addSubview:self.MoneyLab];
    [self.MoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.payImgv.mas_right).offset(10);
    }];
    
    self.status = [UIImageView new];
    [self.contentView addSubview:self.status];
    self.status.image = IMG(@"");
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(15));
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.timeLab.mas_top);
    }];
    
    
    self.detailLab = [UILabel lableWithText:@"交易收款  交易成功" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_BackColor]];
    [self.contentView addSubview:self.detailLab];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.status.mas_left).offset(-5);
        make.height.equalTo(@(12));
        make.top.equalTo(self.timeLab.mas_top);
    }];
    
    UILabel *label = [UILabel lableWithText:@"交易详情" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.bottom.equalTo(self.timeLab.mas_bottom);
    }];
    UIImageView *imgv = [UIImageView new];
    [self.contentView addSubview:imgv];
    imgv.image = IMG(@"right_more");
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(15));
        make.left.equalTo(label.mas_right).offset(5);
        make.centerY.equalTo(label.mas_centerY);
    }];
    
    
    
}


+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 55;
}


- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
//    NSLog(@"---%@", model);
    //status  0等待支付 1支付中 2支付成功 3支付失败
    BillModel *dataModel = (BillModel *)model;
    self.timeLab.text = [NSString stringWithFormat:@"%@\n%@", dataModel.week, dataModel.orderCreateTimeCn];
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 5;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.timeLab.text];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.timeLab.text.length)];
    self.timeLab.attributedText = attributedText;
    
    NSString *type = [dataModel.orderType substringToIndex:2];
    if ([type isEqualToString:@"00"]) {//微信
        self.payImgv.image = IMG(@"bill_way_0");
    }
    if ([type isEqualToString:@"01"]) {//QQ
        self.payImgv.image = IMG(@"bill_way_1");
    }
    if ([type isEqualToString:@"02"]) {//支付宝
        self.payImgv.image = IMG(@"bill_way_2");
    }
    if ([type isEqualToString:@"80"]) {//银联
        self.payImgv.image = IMG(@"bill_way_3");
    }
    if ([type isEqualToString:@"FF"]) {//提现
        self.payImgv.image = IMG(@"bill_way_4");
    }
    
    if ([dataModel.orderStatus integerValue]==2) {
        self.status.image = IMG(@"bill_success");
    } else if ([dataModel.orderStatus integerValue]==3) {
        self.status.image = IMG(@"bill_wrong");
    } else if ([dataModel.orderStatus integerValue]==1) {
        self.status.image = IMG(@"bill_wait");
    } else {
        self.status.image = IMG(@"bill_wait");
    }
    
    self.MoneyLab.text = [dataModel.orderAmount handleDataSourceTail];
    if (dataModel.orderStatusCn.length>3) {
        self.detailLab.text = [NSString stringWithFormat:@"交易收款  %@", dataModel.orderStatusCn];
    } else {
        self.detailLab.text = [NSString stringWithFormat:@"交易收款      %@", dataModel.orderStatusCn];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
