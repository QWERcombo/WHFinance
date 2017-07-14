//
//  UtilsMold.m
//  GoGoTree
//
//  Created by youqin on 16/8/11.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import "UtilsMold.h"
@interface UtilsMold ()<SlideSwitchViewDelegate>

@end

@implementation UtilsMold

DEF_SINGLETON(UtilsMold);

+ (UITableViewCell *)creatCell:(NSString *)type  table:(UITableView *)tableView deledate:(UIViewController *)deledate model:(NSObject *)model data:(id)data andCliker:(ShowBlock)clue
{
    
    if ([type isEqualToString:@"MessageListCell"]) {
        static NSString *IDs = @"MessageListCell";
//        WithdrawRecordCell;
        MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[MessageListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"WithdrawRecordCell"]) {
        static NSString *IDs = @"WithdrawRecordCell";
        WithdrawRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[WithdrawRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"BillListCell"]) {
        static NSString *IDs = @"BillListCell";
        BillListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[BillListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"MineListCell"]) {
        static NSString *IDs = @"MineListCell";
        MineListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[MineListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"MineCustomerCell"]) {
        static NSString *IDs = @"MineCustomerCell";
        MineCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[MineCustomerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"MineCustomerListCell"]) {
        static NSString *IDs = @"MineCustomerListCell";
        MineCustomerListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[MineCustomerListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"clueStr":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"OpenProductListCell"]) {
        static NSString *IDs = @"OpenProductListCell";
        OpenProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[OpenProductListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"BindedCell"]) {
        static NSString *IDs = @"BindedCell";
        BindedCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[BindedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"clueStr":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"WithdrawCell"]) {
        static NSString *IDs = @"WithdrawCell";
        WithdrawCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[WithdrawCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"clueStr":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"MyProfitDetailCell"]) {
        static NSString *IDs = @"MyProfitDetailCell";
        MyProfitDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[MyProfitDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"clueStr":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"BankCardChooseCell"]) {
        static NSString *IDs = @"BankCardChooseCell";
        BankCardChooseCell *cell = [tableView cellForRowAtIndexPath:(NSIndexPath *)data];
        if (cell == nil) {
            cell = [[BankCardChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model index:(NSString *)SINT(((NSIndexPath *)data).row) andCliker:^(NSString *clueStr) {
            clue(@{@"clueStr":clueStr});
        }];
        return cell;
    }
    
    
    
    
    
    
    
    
    
    else
    {
        static NSString *IDs = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.imageView.image = IMG(@"userImg_defatule");
        cell.textLabel.text =@"cell";
        return cell;
    }
    
    return nil;
}

+ (float)getCellHight:(NSString *)type data:(id)data model:(NSObject *)model indexPath:(NSIndexPath *)indexpath;
{
    
    if ([type isEqualToString:@"MessageListCell"]) {
        return [MessageListCell getCellHight:data Model:model indexPath:indexpath];
    }
    else if ([type isEqualToString:@"WithdrawRecordCell"]) {
        return [WithdrawRecordCell getCellHight:data Model:model indexPath:indexpath];
    }
    else if ([type isEqualToString:@"BillListCell"]) {
        return [BillListCell getCellHight:data Model:model indexPath:indexpath];
    }
    else if ([type isEqualToString:@"MineListCell"]) {
        return [MineListCell getCellHight:data Model:model indexPath:indexpath];
    }
    else if ([type isEqualToString:@"MineCustomerListCell"]) {
        return [MineCustomerListCell getCellHight:data Model:model indexPath:indexpath];
    }
    else if ([type isEqualToString:@"MineCustomerCell"]) {
        return [MineCustomerCell getCellHight:data Model:model indexPath:indexpath];
    }
    else if ([type isEqualToString:@"OpenProductListCell"]) {
        return [OpenProductListCell getCellHight:data Model:model indexPath:indexpath];
    }
    else if ([type isEqualToString:@"BindedCell"]) {
        return [BindedCell getCellHight:data Model:model indexPath:indexpath];
    }
    else if ([type isEqualToString:@"WithdrawCell"]) {
        return [WithdrawCell getCellHight:data Model:model indexPath:indexpath];
    }
    else if ([type isEqualToString:@"MyProfitDetailCell"]) {
        return [MyProfitDetailCell getCellHight:data Model:model indexPath:indexpath];
    }
    else if ([type isEqualToString:@"BankCardChooseCell"]) {
        return [BankCardChooseCell getCellHight:data Model:model indexPath:indexpath];
    }
    
    
    
    
    
    
    
    
    
    
    else {
        return 44;
    }
    
}

- (UIView *)creatView:(NSString *)type data:(id)data  model:(NSObject *)model deleGate:(id)delegate andCliker:(ShowBlock)clue{
    
    __showBlock = clue;
    
    UIView *backView = [UIView new];
    if ([type isEqualToString:@"ABBannerView"]){
//        NSMutableArray *IMGArr = [NSMutableArray new];
//        NSArray *dataSource = [model mutableCopy];
//        for (int i = 0; i < dataSource.count; i ++) {
//            Adver *adver = [dataSource objectAtIndex:i];
//            [IMGArr addObject:adver.img];
//        }
//
//        ABBannerView *bannerView = [[ABBannerView alloc] initPageViewFrame:CGRectMake(0, 0, SCREEN_WIGHT, SCREEN_WIGHT/16*9) webImageStr:IMGArr titleStr:nil didSelectPageViewAction:^(NSInteger index) {
//            if (dataSource.count) {
//                Adver *adver = [dataSource objectAtIndex:index];
//                [[UIApplication sharedApplication] openURL: [NSURL URLWithString:adver.link]];
//            }
//
//        }];
//
//        bannerView.duration = 3.0;
//        bannerView.selfBackgroundColor = [UIColor whiteColor];
//        bannerView.pageIndicatorTintColor = [UIColor lightGrayColor];
//        bannerView.currentPageColor = [UIColor mianColor:2];
//        [backView addSubview:bannerView];
//
        return backView;
    }
    
    else if ([type isEqualToString:@"SlideSwitchView"]){
        SlideSwitchView *slideView;
//        NSMutableArray *dataAr = [NSMutableArray new];
//        if ([delegate isKindOfClass:[ClubCircleViewController class]]) {//动态
//            for (NSInteger i=0; i<1; i++) {
//                ClubCircleListViewController *circle = [[ClubCircleListViewController alloc] init];
//                circle.delegate = delegate;
//                circle.nameTitle = SINT(i+2);
//                [dataAr addObject:circle];
//            }
//            UIViewController *mViewController = (UIViewController *)delegate;
//            slideView = [[SlideSwitchView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIGHT, mViewController.view.height - 50)];
//            [mViewController.view addSubview:slideView];
//            slideView.tabItemNormalColor = [UIColor lightGrayColor];
//            slideView.tabItemSelectedColor = [UIColor Grey_PurColor];
//            slideView.tabItemBannerNormalColor = [UIColor whiteColor];
//            slideView.tabItemBannerSelectedColor = [UIColor clearColor];
//            [slideView buildUIWithViews:dataAr andClikBlock:^(NSString *clueStr) {
//
//            }];
//            [slideView setHideTopView:YES];
//        }
//        if ([delegate isKindOfClass:[RankViewController class]]) {//排行榜
//            NSString *type = (NSString *)model;
//            for (NSInteger i=0; i<3; i++) {
//                RankListViewController *circle = [[RankListViewController alloc] init];
//                circle.delegate = delegate;
//                circle.nameTitle = SINT(i+1);
//                circle.typeStatus = [type integerValue]==100?@"1":@"2";
//
//                [dataAr addObject:circle];
//            }
//            UIViewController *mViewController = (UIViewController *)delegate;
//            slideView = [[SlideSwitchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, mViewController.view.height)];
//            [mViewController.view addSubview:slideView];
//            slideView.tabItemNormalColor = [UIColor lightGrayColor];
//            slideView.tabItemSelectedColor = [UIColor Grey_PurColor];
//            slideView.tabItemBannerNormalColor = [UIColor whiteColor];
//            slideView.tabItemBannerSelectedColor = [UIColor clearColor];
//            [slideView buildUIWithViews:dataAr andClikBlock:^(NSString *clueStr) {
//
//            }];
//
//
//        }
//          if ([delegate isKindOfClass:[InvitationCardVC class]]) {//邀酒卡
//              InvitationCardVC *mViewController = (InvitationCardVC *)delegate;
//
//              for (NSInteger i=0; i<2; i++) {
//                  MyInvitationCardVC *circle = [[MyInvitationCardVC alloc] init];
//                  circle.delegateVC = mViewController;
//                  circle.theID = SINT(i+1);
//                  [dataAr addObject:circle];
//              }
//              slideView = [[SlideSwitchView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIGHT, mViewController.view.height - 64 )];
//              [mViewController.view addSubview:slideView];
//              [slideView buildUIWithViews:dataAr andClikBlock:^(NSString *clueStr) {
//                  __showBlock(@{@"btnCliker":clueStr});
//              }];
//              [slideView setHideTopView:YES];
//
//          }
        
        return slideView;
    }
    
    else{
        NSLog(@"没有找到所属view");
        return nil;
    }
}


@end
