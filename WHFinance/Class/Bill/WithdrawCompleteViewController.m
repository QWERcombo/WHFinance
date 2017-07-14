//
//  WithdrawCompleteViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/30.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "WithdrawCompleteViewController.h"

@interface WithdrawCompleteViewController ()
@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) NSArray *tempArr;
@end

@implementation WithdrawCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现完成";
    self.nameArr = @[@"提现金额",@"提现到"];
    self.tempArr = @[self.tempStr, @"招商银行"];
    
    [self setupSubViews];
}

- (void)setupSubViews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
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


- (UIView *)createMainView {
    UIView *mianView = [[UIView alloc] initWithFrame:self.view.bounds];
    mianView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 200)];
    bigView.backgroundColor = [UIColor whiteColor];
    UIImageView *compleImgv = [UIImageView new];
    compleImgv.image = IMG(@"");
    compleImgv.backgroundColor = COLOR_TEMP;
    [bigView addSubview:compleImgv];
    [compleImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(74));
        make.centerX.equalTo(bigView.mas_centerX);
        make.top.equalTo(bigView.mas_top).offset(40);
    }];
    
    UILabel *hint = [UILabel lableWithText:@"提现申请已提交!" Font:FONT_ArialMT(15) TextColor:[UIColor Grey_WordColor]];
    [bigView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bigView.mas_centerX);
        make.height.equalTo(@(15));
        make.top.equalTo(compleImgv.mas_bottom).offset(15);
    }];
    
    
    [mianView addSubview:bigView];
    
    
    UIView *smallView = [[UIView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIGHT, 90)];
    smallView.backgroundColor = [UIColor whiteColor];
    for (NSInteger i=0; i<2; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 45*i, SCREEN_WIGHT, 45)];
        [smallView addSubview:blank];
        
        UILabel *nameLab = [UILabel lableWithText:[self.nameArr objectAtIndex:i] Font:FONT_ArialMT(14) TextColor:[UIColor Grey_BackColor]];
        [blank addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(14));
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left).offset(12.5);
        }];
        
        UILabel *detailLab = [UILabel lableWithText:[self.tempArr objectAtIndex:i] Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
        detailLab.textAlignment = NSTextAlignmentRight;
        [blank addSubview:detailLab];
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(14));
            make.centerY.equalTo(blank.mas_centerY);
            make.right.equalTo(blank.mas_right).offset(-12.5);
            make.left.equalTo(nameLab.mas_right);
        }];
        
        
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12.5, 45, SCREEN_WIGHT-25, 1)];
    line.backgroundColor = [UIColor Grey_LineColor];
    [smallView addSubview:line];
    
    
    [mianView addSubview:smallView];
    
    UIButton *button = [UIButton buttonWithTitle:@"完成" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"register_btn") andHighlightedImage:IMG(@"register_btn")];
    [mianView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.left.equalTo(mianView.mas_left).offset(12.5);
        make.right.equalTo(mianView.mas_right).offset(-12.5);
        make.top.equalTo(smallView.mas_bottom).offset(20);
    }];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return mianView;
}


- (void)buttonAction:(UIButton *)sender {
    NSLog(@"完成");
    [self.navigationController popToRootViewControllerAnimated:YES];
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
