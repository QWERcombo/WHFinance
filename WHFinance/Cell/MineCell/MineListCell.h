//
//  MineListCell.h
//  WHFinance
//
//  Created by wanhong on 2017/6/27.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@interface MineListCell : BaseCell

@property (nonatomic, strong) UIImageView *typeImgv;
@property (nonatomic, strong) UILabel *typeTitle;
@property (nonatomic, strong) UILabel *rightLab;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;

@end
