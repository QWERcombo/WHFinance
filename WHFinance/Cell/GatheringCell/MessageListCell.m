//
//  MessageListCell.m
//  WHFinance
//
//  Created by 赵越 on 2017/6/26.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MessageListCell.h"

@implementation MessageListCell

- (void)initSubView {
    self.contentView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *contentView = [[UIView alloc] init];
    [self.contentView addSubview:contentView];
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    self.nameLab = [UIImageView new];
    [contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(30));
        make.centerY.equalTo(contentView.mas_centerY);
        make.left.equalTo(contentView.mas_left).offset(15);
    }];
    
    
    self.titleLab = [YXPUtil creatUILable:@"系统通知" Font:FONT_ArialMT(15) TextColor:[UIColor Grey_WordColor]];
    [contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.left.equalTo(self.nameLab.mas_right).offset(15);
        make.top.equalTo(self.nameLab.mas_top).offset(0);
    }];
    
    self.timeLab = [YXPUtil creatUILable:@"2017-02-25 10:25" Font:FONT_Helvetica(12) TextColor:[UIColor Grey_BackColor]];
    [contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_right).offset(10);
        make.bottom.equalTo(self.titleLab.mas_bottom);
        make.height.equalTo(@(12));
    }];
    
    self.detailLab = [YXPUtil creatUILable:@"武汉万洪APP系统升级······" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_BackColor]];
    [contentView addSubview:self.detailLab];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).offset(15);
        make.top.equalTo(self.titleLab.mas_bottom).offset(5);
        make.height.equalTo(@(12));
        make.right.equalTo(contentView.mas_right).offset(-30);
    }];
    
    
    self.line = [UIView new];
    [contentView addSubview:self.line];
    self.line.backgroundColor = [UIColor Grey_LineColor];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.bottom.equalTo(contentView.mas_bottom);
        make.width.equalTo(@(SCREEN_WIGHT-10));
        make.centerX.equalTo(contentView.mas_centerX);
    }];
    
}


+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 60;
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)clue {
    MessageModel *dataSource = (MessageModel *)model;
    self.detailLab.text = dataSource.context;
    self.titleLab.text = dataSource.title;
    self.timeLab.text = dataSource.createTime;
    if ([dataSource.messageType isEqualToString:@"0"]) {//注册
        self.nameLab.image = IMG(@"message_1");
    } else {
        self.nameLab.image = IMG(@"message_0");
    }
    
}
/**消息类型注册*/
//public static final byte MESSAGE_TYPE_REGIN     = 0x0000;
/**消息类型交易*/
//public static final byte MESSAGE_TYPE_TRANS     = 0x0001;
/**消息类型系统*/
//public static final byte MESSAGE_TYPE_SYSTEM    = 0x0002;
/**消息类型结算*/
//public static final byte MESSAGE_TYPE_SETTL     = 0x0004;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
