//
//  BaseViewController.m
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseCell.h"

@interface BaseViewController ()

@property (nonatomic,strong) UISwipeGestureRecognizer *swipe;

@property (nonatomic, strong) UIButton *upBtn;


@end

@implementation BaseViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self customViewDidAppear];
}
-(void)customViewDidAppear
{
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self customViewDidDisappear];

}
-(void)customViewDidDisappear
{
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeNavMianColor];
    [self customViewWillAppear];
}
-(void)customViewWillAppear
{
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self customViewWillDisappear];
}
-(void)customViewWillDisappear
{
    
}
//-(void)nightSwich:(NSNotification*)noti{
//    NSDictionary *dict = noti.userInfo;
//    NSString *str = [dict objectForKey:@"NightSwich"];
//    if ([str integerValue] == 0) {
//        self.tabView.backgroundColor = [UIColor whiteColor];
//
//    }else{
//        self.tabView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
//
//    }
//    [self.tabView reloadData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    self.view.backgroundColor = [UIColor clearColor];
    [self changeNavMianColor];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    if ([self.titleStr length] > 0 ) {
        self.title= self.titleStr;
    }
    
    
    self.dataArr = [NSArray array];
    self.dataMuArr =  [NSMutableArray array];
    
    self.dataDic = [NSDictionary dictionary];
    self.dataMuDic =[NSMutableDictionary dictionary];
    
    self.tabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//    [self.tabView nightModel];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    self.tabView.showsVerticalScrollIndicator = NO;
    self.tabView.showsHorizontalScrollIndicator = NO;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    if (!self.isDirectionRight) {
        self.swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftBtnClick)];
        [self.swipe setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.view addGestureRecognizer:self.swipe];
    }
    
}


-(void)changeNavMianColor{
    
    if (self.navMianColor) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor mianColor:0]] forBarMetrics:UIBarMetricsDefault];
        NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
        barAttrs[NSFontAttributeName] = [UIFont fontWithSize:19];
        barAttrs[NSForegroundColorAttributeName] = [UIColor mianColor:1];
        [self.navigationController.navigationBar setTitleTextAttributes:barAttrs];
        
    }else{
        if (self.navIMG) {
            [self.navigationController.navigationBar setBackgroundImage:self.navIMG forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:self.navIMG];//去导航条黑线
        }else{
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor mianColor:1]] forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];//去导航条黑线
        }
        
        NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
        barAttrs[NSFontAttributeName] = [UIFont fontWithSize:19];
        barAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [self.navigationController.navigationBar setTitleTextAttributes:barAttrs];
    }
}

-(void)clearSwipe
{
    [self.view removeGestureRecognizer:self.swipe];
    [self.swipe removeTarget:self action:@selector(leftBtnClick)];
}

-(void)leftBtnClick
{
//    [DataSend cancelAllRequest];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    //取消表格多余分割线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ((BaseCell *)cell).hidenLine = (indexPath.row==self.dataMuArr.count-1);
}

- (BOOL) isBlankString:(NSString *)string {//判断是否有空字符
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
-(UIView *)createNothingView
{
    UIView *nothingView = [[UIView alloc]init];
    nothingView.backgroundColor = [UIColor redColor];
    return nothingView;
}
-(UIView *)createReloadButton
{
    UIView *btnView = [[UIView alloc]init];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"重新加载..." forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor colorWithRed:((CGFloat)0x25/255.0) green:((CGFloat)0xb6/255.0) blue:((CGFloat)0xed/255.0) alpha:1] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//    [button setCheekWithColor:[UIColor colorWithRed:((CGFloat)0x25/255.0) green:((CGFloat)0xb6/255.0) blue:((CGFloat)0xed/255.0) alpha:1] borderWidth:0.5 roundedRect:5.0];
//    button.titleLabel.font=[UIFont fontWithSize:15.0];
//    [button addTarget:self action:@selector(bunReloadDataAgainCliker:) forControlEvents:UIControlEventTouchUpInside];
//    [btnView addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(btnView.mas_centerX);
//        make.centerY.equalTo(btnView.mas_centerY);
//        make.width.equalTo(@(90));
//        make.height.equalTo(@(40));
//    }];
    
    return btnView;
}

- (void)installMissButton:(NSString *)title
{
    CGFloat width = 25 + [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}].width;
    if(width <40)width = 40;
    if(width >60)width = 60;
    UIButton * button =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    [button setImage:IMG(@"MGoBack") forState:UIControlStateNormal];
    [button setImage:IMG(@"MGoBack") forState:UIControlStateHighlighted];
    if(title) [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:17];
    [button setTitleColor:[UIColor YXPBlueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(missSelf) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * backItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backItem];
}

- (void)missSelf
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)bunReloadDataAgainCliker:(UIButton *)btn
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate{
    
    return NO;
}
-(BOOL)isCurrentViewControllerVisible//判断是否当前显示页面
{
    return (self.isViewLoaded && self.view.window);
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
