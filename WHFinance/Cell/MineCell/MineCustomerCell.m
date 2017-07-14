//
//  MineCustomerCell.m
//  WHFinance
//
//  Created by wanhong on 2017/6/28.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MineCustomerCell.h"

@implementation MineCustomerCell

- (void)initSubView {
    self.contentView.backgroundColor = [UIColor Grey_BackColor1];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *content = [UIView new];
    [self.contentView addSubview:content];
    content.backgroundColor = [UIColor whiteColor];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(40);
    }];
    
    
    self.line = [UIView new];
    [content addSubview:self.line];
    self.line.backgroundColor = [UIColor Grey_LineColor];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.equalTo(content.mas_left).offset(15);
        make.right.equalTo(content.mas_right).offset(-20);
        make.bottom.equalTo(content.mas_bottom);
    }];
    
    self.typeImgv = [UIImageView new];
    self.typeImgv.image = IMG(@"customer_level_0");
    [content addSubview:self.typeImgv];
    [self.typeImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.centerY.equalTo(content.mas_centerY);
        make.left.equalTo(content.mas_left).offset(20);
    }];
    self.typeTitle = [UILabel lableWithText:@"一级客户      0" Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:2]];
    self.typeTitle.attributedText = [UILabel labGetAttributedStringFrom:self.typeTitle.text.length-1 toEnd:1 WithColor:[UIColor Grey_WordColor] andFont:FONT_ArialMT(14) allFullText:self.typeTitle.text];
    [content addSubview:self.typeTitle];
    [self.typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeImgv.mas_right).offset(5);
        make.centerY.equalTo(self.typeImgv.mas_centerY);
        make.height.equalTo(@(15));
    }];
    
    
    self.newsCountLab = [UILabel lableWithText:@"今日新增  6" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_BackColor]];
    self.newsCountLab.attributedText = [UILabel labGetAttributedStringFrom:self.newsCountLab.text.length-1 toEnd:1 WithColor:[UIColor colorWithR:243 G:152 B:0 A:1] andFont:FONT_ArialMT(14) allFullText:self.newsCountLab.text];
    [content addSubview:self.newsCountLab];
    [self.newsCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(content.mas_centerY);
        make.right.equalTo(content.mas_right).offset(-40);
        make.height.equalTo(@(14));
    }];
    
    
}


+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    
    return 45;
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
//    [UIColor colorWithR:252 G:153 B:44 A:1] 一级
//    [UIColor colorWithR:235 G:51 B:15 A:1] 二级
    
    
    
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
