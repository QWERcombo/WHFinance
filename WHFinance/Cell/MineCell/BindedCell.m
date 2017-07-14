//
//  BindedCell.m
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BindedCell.h"

@implementation BindedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initSubView {
    self.contentView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *content = [UIView new];
    [self.contentView addSubview:content];
    content.backgroundColor = [UIColor whiteColor];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    self.typeImgv = [UIImageView new];
    [content addSubview:self.typeImgv];
    self.typeImgv.layer.cornerRadius = 33/2;
    self.typeImgv.clipsToBounds = YES;
    self.typeImgv.backgroundColor = COLOR_TEMP;
    [self.typeImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(33));
        make.centerY.equalTo(content.mas_centerY);
        make.left.equalTo(content.mas_left).offset(15);
    }];
    
    self.deleBtn = [UIButton buttonWithTitle:@"解绑" andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor mianColor:1] andHighlightedTitle:[UIColor mianColor:1] andNormaImage:nil andHighlightedImage:nil];
    [content addSubview:self.deleBtn];
    self.deleBtn.layer.borderColor = [UIColor mianColor:1].CGColor;
    self.deleBtn.layer.borderWidth = 1;
    self.deleBtn.layer.cornerRadius = 5;
    self.deleBtn.clipsToBounds = YES;
    [self.deleBtn setImage:IMG(@"login_check_y") forState:UIControlStateNormal];
    self.deleBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, -10.0, 0.0, 0.0);
    self.deleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.deleBtn addTarget:self action:@selector(deleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(25));
        make.width.equalTo(@(65));
        make.centerY.equalTo(content.mas_centerY);
        make.right.equalTo(content.mas_right).offset(-10);
    }];
    
    self.bankNameLab = [UILabel lableWithText:@"招商银行" Font:FONT_ArialMT(15) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:self.bankNameLab];
    [self.bankNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.left.equalTo(self.typeImgv.mas_right).offset(15);
        make.top.equalTo(content.mas_top).offset(12);
    }];
    
    
    self.cardTypeLab = [UILabel lableWithText:@"信用卡" Font:FONT_ArialMT(11) TextColor:[UIColor Grey_BackColor]];
    [content addSubview:self.cardTypeLab];
    [self.cardTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(11));
        make.top.equalTo(self.bankNameLab.mas_bottom).offset(15/2);
        make.left.equalTo(self.typeImgv.mas_right).offset(15);
    }];
    
    
    self.carNumberLab = [UILabel lableWithText:@"4563*** ***89989" Font:FONT_Helvetica(18) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:self.carNumberLab];
    [self.carNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(18));
        make.left.equalTo(self.typeImgv.mas_right).offset(15);
        make.top.equalTo(self.cardTypeLab.mas_bottom).offset(10);
    }];
    
    
}

- (void)deleBtnAction:(UIButton *)sender {
    _clikBlock(@"0");
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 90;
}


- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
    _clikBlock = clue;
    
    
    
}
@end
