//
//  MineCustomerListViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MineCustomerListViewController.h"

@interface MineCustomerListViewController (){
    
}

@end

@implementation MineCustomerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"一级客户";
    for (NSInteger i=0; i<10; i++) {
        [self.dataMuArr addObject:@"1"];
    }
    
    [self setupSubViews];
}


- (void)setupSubViews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        return self.dataMuArr.count;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"MineCustomerListCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
        if ([clueDic[@"clueStr"] isEqualToString:@"1"]) {
            [[UtilsData sharedInstance] showAlertControllerWithTitle:@"18285856363" detail:@"" doneTitle:@"呼叫" cancelTitle:@"取消" haveCancel:YES doneAction:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://10086"]]];
            } controller:self];
        }
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"MineCustomerListCell" data:nil model:nil indexPath:indexPath];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [self createMainViewWithSection:section];
    } else {
        if (self.dataMuArr.count) {
            return nil;
        } else {
            return [UIView showNothingViewWith:1];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 70;
    } else {
        if (self.dataMuArr.count) {
            return 0;
        } else {
            return self.view.size.height-70;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UIView *)createMainViewWithSection:(NSInteger)section {
    UIView *main = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 70)];
    main.backgroundColor = [UIColor whiteColor];
    
    NSInteger margin = (SCREEN_WIGHT-270)/2;
    for (NSInteger i=0; i<3; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake((90+margin)*i, 0, 90, 50)];
        blank.tag = 1000+i;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 48, 90, 2)];
        line.tag = 2000+i;
        if (i==0) {
            line.backgroundColor = [UIColor mianColor:1];
        } else {
            line.backgroundColor = [UIColor clearColor];
        }
        [blank addSubview:line];
        
        NSArray *arr = @[@"全部",@"已认证",@"未认证"];
        UILabel *titleLab = [UILabel lableWithText:[arr objectAtIndex:i] Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:2]];
        titleLab.tag = 3000+i;
        if (i==0) {
            titleLab.textColor = [UIColor mianColor:1];
        }
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.frame = CGRectMake(22.5, 17, 45, 14);
        [blank addSubview:titleLab];
        
        
        
        
        
        UITapGestureRecognizer *vvtt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewAction:)];
        [blank addGestureRecognizer:vvtt];
        [main addSubview:blank];
    }
    
    UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIGHT, 20)];
    vvv.backgroundColor = [UIColor Grey_BackColor1];
    [main addSubview:vvv];
    
    
    
    return main;
}

- (void)viewAction:(UITapGestureRecognizer *)sender {
    [self.dataMuArr removeAllObjects];
    if (sender.view.tag==1000) {
        UIView *line1 = [self.view viewWithTag:2000];
        line1.backgroundColor = [UIColor mianColor:1];
        UILabel *titleLab1 = [self.view viewWithTag:3000];
        titleLab1.textColor = [UIColor mianColor:1];
        
        UIView *line2 = [self.view viewWithTag:2001];
        line2.backgroundColor = [UIColor clearColor];
        UILabel *titleLab2 = [self.view viewWithTag:3001];
        titleLab2.textColor = [UIColor mianColor:2];
        
        UIView *line3 = [self.view viewWithTag:2002];
        line3.backgroundColor = [UIColor clearColor];
        UILabel *titleLab3 = [self.view viewWithTag:3002];
        titleLab3.textColor = [UIColor mianColor:2];
        for (NSInteger i=0; i<10; i++) {
            [self.dataMuArr addObject:@"1"];
        }
    } else if (sender.view.tag==1001) {
        UIView *line1 = [self.view viewWithTag:2000];
        line1.backgroundColor = [UIColor clearColor];
        UILabel *titleLab1 = [self.view viewWithTag:3000];
        titleLab1.textColor = [UIColor mianColor:2];
        
        UIView *line2 = [self.view viewWithTag:2001];
        line2.backgroundColor = [UIColor mianColor:1];
        UILabel *titleLab2 = [self.view viewWithTag:3001];
        titleLab2.textColor = [UIColor mianColor:1];
        
        UIView *line3 = [self.view viewWithTag:2002];
        line3.backgroundColor = [UIColor clearColor];
        UILabel *titleLab3 = [self.view viewWithTag:3002];
        titleLab3.textColor = [UIColor mianColor:2];
        for (NSInteger i=0; i<5; i++) {
            [self.dataMuArr addObject:@"1"];
        }
    } else {
        UIView *line1 = [self.view viewWithTag:2000];
        line1.backgroundColor = [UIColor clearColor];
        UILabel *titleLab1 = [self.view viewWithTag:3000];
        titleLab1.textColor = [UIColor mianColor:2];
        
        UIView *line2 = [self.view viewWithTag:2001];
        line2.backgroundColor = [UIColor clearColor];
        UILabel *titleLab2 = [self.view viewWithTag:3001];
        titleLab2.textColor = [UIColor mianColor:2];
        
        UIView *line3 = [self.view viewWithTag:2002];
        line3.backgroundColor = [UIColor mianColor:1];
        UILabel *titleLab3 = [self.view viewWithTag:3002];
        titleLab3.textColor = [UIColor mianColor:1];
    }
    
    [self.tabView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
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
