//
//  TradeResultViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/8.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "TradeResultViewController.h"
#import "TradeDetailViewController.h"

@interface TradeResultViewController ()

@end

@implementation TradeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付提示";
    
    [self setUpSubviews];
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.size.height;
}

- (UIView *)createMainView  {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 155)];
    content.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:content];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIGHT-20, 1)];
    line.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line];
    
    UIImageView *imgv = [UIImageView new];
    [content addSubview:imgv];
    imgv.image = IMG(@"Success_Out");
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.left.equalTo(content.mas_left).offset(13);
        make.top.equalTo(content.mas_top).offset(15);
    }];
    UILabel *label = [UILabel lableWithText:@"交易成功" Font:FONT_ArialMT(18) TextColor:[UIColor mianColor:1]];
    [content addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgv.mas_centerY);
        make.left.equalTo(imgv.mas_right).offset(10);
        make.height.equalTo(@(18));
    }];
    
    UILabel *hint = [UILabel lableWithText:[NSString stringWithFormat:@"已成功收款%@元", self.cashStr] Font:FONT_ArialMT(13) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_bottom);
        make.left.equalTo(label.mas_right).offset(18);
        make.height.equalTo(@(13));
    }];
    hint.attributedText = [UILabel labGetAttributedStringFrom:hint.text.length-self.cashStr.length-1 toEnd:self.cashStr.length WithColor:[UIColor Grey_OrangeColor] andFont:FONT_ArialMT(13) allFullText:hint.text];
    
    
    NSArray *hintArr = @[@"交易单号",@"交易方式",@"手续费",@"交易时间"];
    NSArray *tempArr = @[@"JIHUHUGYFYT2546987",@"微信支付",@"￥200.00",@"2017-06-21  18:18:18"];
    for (NSInteger i=0; i<4; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(15, 60+22*i, SCREEN_WIGHT-25, 12)];
        UILabel *titleLab = [UILabel lableWithText:[hintArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
        [blank addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blank.mas_left);
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
        }];
        
        UILabel *desLab = [UILabel lableWithText:[tempArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        
        [blank addSubview:desLab];
        [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(blank.mas_right);
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
            make.width.equalTo(@(150));
        }];
        
        if (i==2) {
            desLab.textColor = [UIColor Grey_OrangeColor];
        }
        
        [content addSubview:blank];
    }
    
    
    
    
    
    
    
    UIButton *leftBtn = [UIButton buttonWithTitle:@"查看结算详情" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [mainView addSubview:leftBtn];
    leftBtn.backgroundColor = [UIColor mianColor:1];
    leftBtn.layer.cornerRadius = 5;
    leftBtn.clipsToBounds = YES;
    [leftBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.mas_left).offset(15);
        make.top.equalTo(content.mas_bottom).offset(25);
        make.height.equalTo(@(40));
        make.width.equalTo(@((SCREEN_WIGHT-40)/2));
    }];
    UIButton *rightBtn = [UIButton buttonWithTitle:@"返回收款页" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor mianColor:1] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [mainView addSubview:rightBtn];
    rightBtn.backgroundColor = [UIColor whiteColor];
    rightBtn.layer.cornerRadius = 5;
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.borderColor = [UIColor mianColor:1].CGColor;
    rightBtn.clipsToBounds = YES;
    [rightBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mainView.mas_right).offset(-15);
        make.top.equalTo(content.mas_bottom).offset(25);
        make.height.equalTo(@(40));
        make.width.equalTo(@((SCREEN_WIGHT-40)/2));
    }];
    
    return mainView;
}


- (void)buttonClick:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"查看结算详情"]) {
        TradeDetailViewController *deta = [TradeDetailViewController new];
        deta.cashStr = self.cashStr;
        deta.orderID = self.orderID;
        [self.navigationController pushViewController:deta animated:YES];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
