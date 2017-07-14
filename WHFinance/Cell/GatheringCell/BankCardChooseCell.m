//
//  BankCardChooseCell.m
//  WHFinance
//
//  Created by wanhong on 2017/7/8.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BankCardChooseCell.h"

@implementation BankCardChooseCell


- (void)initSubView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.bankImgv = [UIImageView new];
//    self.bankImgv.backgroundColor = [UIColor colorWithR:2 G:116 B:124 A:1];
    [self.contentView addSubview:self.bankImgv];
    self.bankImgv.layer.cornerRadius = 5;
    self.bankImgv.clipsToBounds = YES;
    [self.bankImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-17.5);
    }];
    
    self.bankLab = [UILabel lableWithText:@"建设银行" Font:FONT_ArialMT(14) TextColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.bankLab];
    [self.bankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.left.equalTo(self.contentView.mas_left).offset(45);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    self.userLab = [UILabel lableWithText:@"张三" Font:FONT_ArialMT(13) TextColor:[UIColor colorWithR:255 G:255 B:255 A:1]];
    [self.contentView addSubview:self.userLab];
    [self.userLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(13));
        make.left.equalTo(self.bankLab.mas_left);
        make.top.equalTo(self.bankLab.mas_bottom).offset(5);
    }];
    
    self.selectBtn = [UIButton buttonWithTitle:nil andFont:nil andtitleNormaColor:nil andHighlightedTitle:nil andNormaImage:IMG(@"bankcard_no") andHighlightedImage:IMG(@"bankcard_yes")];
    [self.contentView addSubview:self.selectBtn];
    self.selectBtn.backgroundColor = [UIColor whiteColor];
    self.selectBtn.layer.borderColor = [UIColor Grey_WordColor].CGColor;
    self.selectBtn.layer.borderWidth = 0.5;
    self.selectBtn.layer.cornerRadius = 2;
    self.selectBtn.clipsToBounds = YES;
    [self.selectBtn addTarget:self action:@selector(selecAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(17));
        make.top.equalTo(self.contentView.mas_top).offset(3);
        make.right.equalTo(self.contentView.mas_right).offset(-3);
    }];
    
    
    self.cardLab = [UILabel lableWithText:@"" Font:FONT_ArialMT(15) TextColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.cardLab];
    [self.cardLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.right.equalTo(self.selectBtn.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-40);
    }];
    
    
    
    
}


- (void)selecAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setBackgroundImage:IMG(@"bankcard_yes") forState:UIControlStateNormal];
        _clikBlock(@"1");
    } else {
        [sender setBackgroundImage:IMG(@"bankcard_no") forState:UIControlStateNormal];
    }
}



+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 97.5;
}

- (void)loadData:(NSObject *)model index:(NSString *)index andCliker:(ClikBlock)clue {
    BankCardModel *data = (BankCardModel *)model;
    _clikBlock = clue;
    switch ([index integerValue]%3) {
        case 0:
            self.bankImgv.image = IMG(@"card_0");
            break;
        case 1:
            self.bankImgv.image = IMG(@"card_1");
            break;
        case 2:
            self.bankImgv.image = IMG(@"card_2");
            break;
        default:
            
            break;
    }
    self.bankLab.text = data.cardBankName;
    self.cardLab.text = data.cardNo;
    self.userLab.text = data.cardHolderName;
    if (data.isSelectedCard) {
        [self.selectBtn setBackgroundImage:IMG(@"bankcard_yes") forState:UIControlStateNormal];
    } else {
        [self.selectBtn setBackgroundImage:IMG(@"bankcard_no") forState:UIControlStateNormal];
    }
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
