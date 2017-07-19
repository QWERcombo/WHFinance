//
//  WithdrawCell.h
//  WHFinance
//
//  Created by wanhong on 2017/6/30.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@interface WithdrawCell : BaseCell
@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, strong) UIImageView *payImgv;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *numLab;


- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;
@end
