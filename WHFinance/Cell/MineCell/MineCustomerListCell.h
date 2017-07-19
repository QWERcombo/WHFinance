//
//  MineCustomerListCell.h
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@interface MineCustomerListCell : BaseCell
@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, strong) UIImageView *typeImgv;
@property (nonatomic, strong) UILabel *typeTitle;
@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *statusBtn;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;
@end
