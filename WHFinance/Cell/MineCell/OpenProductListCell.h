//
//  OpenProductListCell.h
//  WHFinance
//
//  Created by wanhong on 2017/6/28.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@interface OpenProductListCell : BaseCell
@property (nonatomic, strong) UIImageView *typeImgv;
@property (nonatomic, strong) UILabel *typeTitle;
@property (nonatomic, strong) UILabel *leftLab, *rightLab;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;

@end
