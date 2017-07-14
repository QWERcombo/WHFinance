//
//  MyProfitDetailCell.h
//  WHFinance
//
//  Created by wanhong on 2017/7/6.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@interface MyProfitDetailCell : BaseCell
@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *MoneyLab;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;
@end
