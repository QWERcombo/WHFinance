//
//  MineCustomerCell.h
//  WHFinance
//
//  Created by wanhong on 2017/6/28.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@interface MineCustomerCell : BaseCell
@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, strong) UIImageView *typeImgv;
@property (nonatomic, strong) UILabel *typeTitle;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *newsCountLab;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;

@end
