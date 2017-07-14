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
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initSubView];
    }
    return self;
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
