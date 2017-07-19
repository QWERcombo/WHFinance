//
//  BaseCell.m
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.line = [UIView new];
        _line.backgroundColor = [UIColor Grey_LineColor];
        [self.contentView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(1));
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(@(SCREEN_WIGHT-25));
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];
        
        [self initSubView];
    }
    return self;
}

- (void)setHidenLine:(BOOL)hidenLine{
    _hidenLine= hidenLine;
    self.line.hidden= hidenLine;
}

- (void)initSubView{
    
    
    
}

+(float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath;
{
    return SCREEN_WIGHT*9/16+10;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
