//
//  MineCustomerListCell.m
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MineCustomerListCell.h"

@implementation MineCustomerListCell


- (void)initSubView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.typeImgv = [UIImageView new];
    [self.contentView addSubview:self.typeImgv];
    self.typeImgv.image = IMG(@"customer_0");
    [self.typeImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(30));
        make.left.equalTo(self.contentView.mas_left).offset(12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    self.nameLab  =[UILabel lableWithText:@"普通会员:  张三" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeImgv.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.equalTo(@(12));
    }];
    
    self.numberLab = [UILabel lableWithText:@"电话:  18236365252" Font:FONT_Helvetica(12) TextColor:[UIColor Grey_WordColor]];
    [self.contentView addSubview:self.numberLab];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeImgv.mas_right).offset(10);
        make.height.equalTo(@(12));
        make.top.equalTo(self.nameLab.mas_bottom).offset(5);
    }];
    
    self.timeLab = [UILabel lableWithText:@"日期:  2017-06-21" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeImgv.mas_right).offset(10);
        make.height.equalTo(@(12));
        make.top.equalTo(self.numberLab.mas_bottom).offset(5);
    }];
    
    self.typeTitle = [UILabel lableWithText:@"认证:  已认证" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [self.contentView addSubview:self.typeTitle];
    [self.typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.left.equalTo(self.typeImgv.mas_right).offset(10);
        make.top.equalTo(self.timeLab.mas_bottom).offset(5);
    }];
    
    self.statusBtn = [UIButton buttonWithTitle:@"联系TA" andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor mianColor:1] andHighlightedTitle:[UIColor mianColor:1] andNormaImage:nil andHighlightedImage:nil];
    [self.contentView addSubview:self.statusBtn];
    self.statusBtn.layer.borderColor = [UIColor mianColor:1].CGColor;
    self.statusBtn.layer.borderWidth = 1;
    self.statusBtn.clipsToBounds = YES;
    self.statusBtn.layer.cornerRadius = 5;
    [self.statusBtn addTarget:self action:@selector(contactAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.statusBtn setImage:IMG(@"login_check_y") forState:UIControlStateNormal];
//    self.statusBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, -10.0, 0.0, 0.0);
//    self.statusBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(25));
        make.width.equalTo(@(63));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
}

- (void)contactAction:(UIButton *)sender {
    _clikBlock(@"1");
}


+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 85;
}


- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
    _clikBlock = clue;
    
    
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
