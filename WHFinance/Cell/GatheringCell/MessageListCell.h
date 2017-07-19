//
//  MessageListCell.h
//  WHFinance
//
//  Created by 赵越 on 2017/6/26.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@interface MessageListCell : BaseCell

@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, strong) UIImageView *nameLab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *detailLab;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;

@end
