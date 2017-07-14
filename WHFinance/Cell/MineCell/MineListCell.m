//
//  MineListCell.m
//  WHFinance
//
//  Created by wanhong on 2017/6/27.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MineListCell.h"

@implementation MineListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initSubView {
    UIView *content = [UIView new];
    [self.contentView addSubview:content];
    content.backgroundColor = [UIColor whiteColor];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self.contentView);
        make.right.equalTo(self.mas_right).offset(50);
    }];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor Grey_LineColor];
    [self.contentView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    self.typeImgv = [UIImageView new];
    [content addSubview:self.typeImgv];
//    self.typeImgv.backgroundColor = COLOR_TEMP;
    [self.typeImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    self.typeTitle = [UILabel lableWithText:@"" Font:FONT_ArialMT(15) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:self.typeTitle];
    [self.typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeImgv);
        make.height.equalTo(@(20));
        make.left.equalTo(self.typeImgv.mas_right).offset(10);
    }];
    
    
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 45;
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
    NSArray *str = (NSArray *)model;
    self.typeTitle.text = [str lastObject];
    self.typeImgv.image = IMG([str firstObject]);
    
}

@end
