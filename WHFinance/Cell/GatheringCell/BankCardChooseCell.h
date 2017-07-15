//
//  BankCardChooseCell.h
//  WHFinance
//
//  Created by wanhong on 2017/7/8.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseCell.h"

@protocol RadioSelectDelegate;

@interface BankCardChooseCell : BaseCell
@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, strong) UIImageView *bankImgv;
@property (nonatomic, strong) UILabel *bankLab;
@property (nonatomic, strong) UILabel *userLab;
@property (nonatomic, strong) UILabel *cardLab;
@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) id <RadioSelectDelegate> delegate;

- (void)loadData:(NSObject *)model index:(NSString *)index andCliker:(ClikBlock)clue;
@end

@protocol RadioSelectDelegate <NSObject>

- (void)radioSelectedWithIndexPath:(NSIndexPath *)indexPath;

@end
