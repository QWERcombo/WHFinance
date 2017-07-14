//
//  WithdrawRecordCell.h
//  WHFinance
//
//  Created by wanhong on 2017/6/27.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@interface WithdrawRecordCell : BaseCell

@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIImageView *bankImgv;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *MoneyLab;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;

@end
