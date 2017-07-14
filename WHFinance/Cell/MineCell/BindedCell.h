//
//  BindedCell.h
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@interface BindedCell : BaseCell
@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, strong) UIImageView *typeImgv;
@property (nonatomic, strong) UILabel *carNumberLab;
@property (nonatomic, strong) UIButton *deleBtn;
@property (nonatomic, strong) UILabel *bankNameLab, *cardTypeLab;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;

@end
