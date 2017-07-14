//
//  JoinParterPayWayCell.h
//  WHFinance
//
//  Created by wanhong on 2017/7/10.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinParterPayWayCell : UICollectionViewCell
@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, strong) UIImageView *typeImgv;
@property (nonatomic, strong) UILabel *nameLab;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue;

@end
