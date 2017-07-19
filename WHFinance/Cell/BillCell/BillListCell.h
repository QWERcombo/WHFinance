//
//  BillListCell.h
//  WHFinance
//
//  Created by wanhong on 2017/6/27.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@interface BillListCell : BaseCell
@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, strong) UIImageView *payImgv;//支付方式
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *MoneyLab;
@property (nonatomic, strong) UIImageView *status;//支付状态


- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;
@end
