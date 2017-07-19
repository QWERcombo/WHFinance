//
//  BottomArticleView.m
//  GoGoTree
//
//  Created by youqin on 16/8/16.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import "BottomArticleView.h"
//#import "EditorTopicViewController.h"
//#import "ShareSheetView.h"
//#import "SYFavoriteButton.h"
//#import "DetailsModel.h"
//#import "TopicDetailViewController.h"
//#import "PostsDetailViewController.h"
//#import "DetailsViewController.h"
//#import "CircleEntryView.h"
//#import "WalletViewController.h"

@interface BottomArticleView()
@property(nonatomic,strong) UILabel *praiseNumLab;
@property(nonatomic,strong) UILabel *commentNumLab;
@property(nonatomic,strong) NSString *abID;
//@property(nonatomic,strong) DetailsModel *detailsModel;
@property (nonatomic, strong) UIButton *goBtn;
@property (nonatomic, strong) UIButton * shareBtn;
@property (nonatomic, strong) UIButton * commentBtn;
@property (nonatomic, strong) UIButton * rewardBtn;
@property (nonatomic, strong) UIButton * collection;
@end

@implementation BottomArticleView

- (id)initWithData:(BaseModel *)date {
    if(self=[super init])
    {
//        DetailsModel *detailsM = (DetailsModel *)date;
//        self.detailsModel = detailsM;
//        self.abID = SINT(detailsM.data.iid);
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.height.equalTo(@0.5);
        }];
        
        self.goBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.goBtn setBackgroundImage:IMG(@"Mark_D") forState:UIControlStateNormal];
        [self.goBtn addTarget:self action:@selector(goBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.goBtn];
        [self.goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.left.equalTo(self.mas_left).offset(20);
            make.width.equalTo(@18);
            make.height.equalTo(@30);
        }];
        
//        self.commentBtn = [UIButton buttonWithTitle:nil andtitleNormaColor:nil andHighlightedTitle:nil andNormaImage:IMG(@"comments_D") andHighlightedImage:IMG(@"comments_D")];
        [self.commentBtn addTarget:self action:@selector(commentBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.commentBtn];
        
        self.commentNumLab = [UILabel lableWithText:@"" Font:FONT_ArialMT(11) TextColor:[UIColor whiteColor]];
//        self.commentNumLab.text = [NSString stringWithFormat:@" %@ ",[SINT(detailsM.data.remarkCount) configeMiriade]];
        self.commentNumLab.backgroundColor = [UIColor mianColor:2];
        [self.commentNumLab setCheekWithColor:nil borderWidth:0 roundedRect:12/2];
        [self addSubview:self.commentNumLab];

            float w_h = 25;
            self.rewardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.rewardBtn setTitle:@"¥" forState:UIControlStateNormal];
            [self.rewardBtn setCheekWithColor:nil borderWidth:0 roundedRect:w_h/2];
            if ([detailsM.data.isPay integerValue] > 0) {
                self.rewardBtn.selected = YES;
                self.rewardBtn.backgroundColor =  [UIColor mianColor:2];
            }else{
                self.rewardBtn.selected = NO;
                self.rewardBtn.backgroundColor = [UIColor colorWithR:197 G:197 B:217 A:1];
            }
            
            [self.rewardBtn addTarget:self action:@selector(praiseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.rewardBtn];
        
        self.collection = [UIButton buttonWithTitle:nil andtitleNormaColor:nil andHighlightedTitle:nil andNormaImage:nil andHighlightedImage:nil];
        if ([detailsM.data.isCollect integerValue] > 0) {
            self.collection.selected = YES;
            [self.collection setBackgroundImage:IMG(@"collection_H") forState:UIControlStateNormal];
            [self.collection setBackgroundImage:IMG(@"collection_H") forState:UIControlStateHighlighted];
        }else{
            self.collection.selected = NO;
            [self.collection setBackgroundImage:IMG(@"collection_D") forState:UIControlStateNormal];
            [self.collection setBackgroundImage:IMG(@"collection_D") forState:UIControlStateHighlighted];
        }
        [self addSubview:self.collection];
        [self.collection addTarget:self action:@selector(collectionBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        self.shareBtn = [UIButton buttonWithTitle:nil andtitleNormaColor:nil andHighlightedTitle:nil andNormaImage:IMG(@"more_D") andHighlightedImage:IMG(@"more_D")];
        [self addSubview:self.shareBtn];
        [self.shareBtn addTarget:self action:@selector(shareBtnAct:) forControlEvents:UIControlEventTouchUpInside];

        if (detailsM.data.openPay > 0 &&detailsM.data.openPay > 0) {//打赏+评论
            [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT/5 + 30);
                make.width.equalTo(@26);
                make.height.equalTo(@25);
            }];
            [self.commentNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.commentBtn.mas_top).offset(0);
                make.left.equalTo(self.commentBtn.mas_right).offset(-2);
                make.height.equalTo(@12);
            }];
            
            [self.rewardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT*2/5+30);
                make.width.equalTo(@(w_h));
                make.height.equalTo(@(w_h));
            }];
            [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT*3/5 + 30);
                make.width.equalTo(@22);
                make.height.equalTo(@27);
            }];

            [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT*4/5 + 30);
                make.width.equalTo(@25);
                make.height.equalTo(@5);
            }];
        }else if (detailsM.data.openPay > 0  && detailsM.data.openPay == 0){//打赏
            self.commentBtn.hidden = YES;
            self.commentNumLab.hidden = YES;
            [self.rewardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT/4+30);
                make.width.equalTo(@(w_h));
                make.height.equalTo(@(w_h));
            }];
            [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT/2 + 30);
                make.width.equalTo(@22);
                make.height.equalTo(@27);
            }];
            
            [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT*3/4 + 30);
                make.width.equalTo(@25);
                make.height.equalTo(@5);
            }];

        }else if (detailsM.data.openPay == 0  && detailsM.data.openPay > 0){//评论
            self.rewardBtn.hidden = YES;
            [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT/4 + 30);
                make.width.equalTo(@26);
                make.height.equalTo(@25);
            }];
            [self.commentNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.commentBtn.mas_top).offset(0);
                make.left.equalTo(self.commentBtn.mas_right).offset(-2);
                make.height.equalTo(@12);
            }];
            [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT/2 + 30);
                make.width.equalTo(@22);
                make.height.equalTo(@27);
            }];
            
            [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT*3/4 + 30);
                make.width.equalTo(@25);
                make.height.equalTo(@5);
            }];
        }else{//非打赏评论
            [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT/3 + 30);
                make.width.equalTo(@22);
                make.height.equalTo(@27);
            }];
            
            [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.mas_left).offset(SCREEN_WIGHT*2/3 + 30);
                make.width.equalTo(@25);
                make.height.equalTo(@5);
            }];
        }
        
    }
    return self;
}

//-(void)commentsLabCliker:(UIButton *)btn{
//    if ([UserData currentUser].nickname.length == 0) {
//        [[UtilsData sharedInstance]  loginPlan:nil success:^(UserData *user) {
//        } failure:^(UserData *user) {
//        }];
//    } else {
//        if ([self.cName isEqualToString:@"TopicDetailViewController"]) {
//            EditorTopicViewController *editor = [[EditorTopicViewController alloc] init];
//            editor.iid = self.abID;
//            editor.ttitle = self.detailsModel.data.title;
//            TBNavigationController *navi = [[TBNavigationController alloc] initWithRootViewController:editor];
//            [MY_WINDOW.rootViewController presentViewController:navi animated:YES completion:nil];
//        } else {
//            [KeyTextView showKeyTextView:nil delegate:self.deleagte];//。。。。。。。。。。。。。。。。。。。
//        }
//    }
//}

//返回
-(void)goBtn:(UIButton *)btn{
    _dismiss(@"0");
}
//评论
- (void)commentBtnAction:(UIButton *)btn{
    _dismiss(@"1");
}
//打赏
-(void)praiseBtnAction:(UIButton *)btn{
    _dismiss(@"2");
    MoneyPopView *money = [[MoneyPopView alloc] initWithFrame:MY_WINDOW.bounds];
    [money loadDataWith:self.detailsModel andClue:^(NSString *clueStr) {
//        NSLog(@"%@", clueStr);
        if ([clueStr isEqualToString:@"0"]) {
            _dismiss(@"5");
        }
        else if ([clueStr isEqualToString:@"1"]) {
            _dismiss(@"6");
        }
        else if ([clueStr isEqualToString:@"打赏成功"]) {
            [[UtilsData sharedInstance] showAlertTitle:nil detailsText:clueStr time:2 aboutType:MBProgressHUDModeCustomView state:YES];
        }
        else {
            [[UtilsData sharedInstance] showAlertTitle:nil detailsText:clueStr time:2 aboutType:MBProgressHUDModeCustomView state:NO];
        }
        [money removeFromSuperview];
    }];
    [MY_WINDOW addSubview:money];
}
//收藏
- (void)collectionBtnAct:(UIButton *)btn{
    //    _dismiss(@"3");
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self resultWithCollection:@"1"];
        
    }else{
        [self resultWithCollection:@"-1"];
    }
}
//更多
- (void)shareBtnAct:(UIButton *)btn{
    _dismiss(@"4");
    [ShareSheetView showShareSheetView:_detailsModel delegate:_deleagte andCliker:^(NSString *clueStr) {
        
    }];
    
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:APP_ID forKey:@"appId"];
//    NSString *typeStr = [NSString stringWithFormat:@"app/news?id=%@",self.abID];
//    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:typeStr andCookie:[NSString stringWithFormat:@"JSESSIONID=%@",[UserData currentUser].sessionid] showAnimation:YES success:^(NSDictionary *resultDic,NSString *msg) {
//        //NSLog(@"%@", resultDic);
//        DetailsModel *model = [[DetailsModel alloc] initWithDictionary:resultDic error:nil];
//        
//    } failure:^(NSString *error, NSInteger errorCode) {
//        if (errorCode == 2000) {
//            [[UtilsData sharedInstance]  loginPlan:nil success:^(UserData *user) {
//            } failure:^(UserData *user) {
//            }];
//        }
//    }];
}
//收藏,post请求
- (void)resultWithCollection:(NSString *)collection {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:APP_ID forKey:@"appId"];
    [dict setObject:self.abID forKey:@"id"];
    [dict setObject:self.detailsModel.data.type forKey:@"type"];
    [dict setObject:collection forKey:@"status"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"app/collect" andCookie:[NSString stringWithFormat:@"JSESSIONID=%@",[UserData currentUser].sessionid] showAnimation:YES success:^(NSDictionary *resultDic,NSString *msg) {
        //NSLog(@"-----%@", resultDic);
        if ([collection isEqualToString:@"1"]) {
            [[UtilsData sharedInstance]showAlertTitle:@"收藏成功" detailsText:nil time:1.5 aboutType:MBProgressHUDModeCustomView state:YES];
            [self.collection setBackgroundImage:IMG(@"collection_H") forState:UIControlStateNormal];
            [self.collection setBackgroundImage:IMG(@"collection_H") forState:UIControlStateHighlighted];
        }else{
            [[UtilsData sharedInstance]showAlertTitle:@"取消收藏" detailsText:nil time:1.5 aboutType:MBProgressHUDModeCustomView state:NO];
            [self.collection setBackgroundImage:IMG(@"collection_D") forState:UIControlStateNormal];
            [self.collection setBackgroundImage:IMG(@"collection_D") forState:UIControlStateHighlighted];
        }
        
    } failure:^(NSString *error, NSInteger code) {
        if (code == 2000) {
            [[UtilsData sharedInstance]  loginPlan:nil success:^(UserData *user) {
            } failure:^(UserData *user) {
            }];
        }
    }];
}
//点赞,post请求
-(void)resultWithPraise:(NSString *)praise
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:APP_ID forKey:@"appId"];
    [dict setObject:self.abID forKey:@"id"];
    [dict setObject:self.detailsModel.data.type forKey:@"type"];
    [dict setObject:praise forKey:@"status"];
    
    PostsDetailViewController *post = (PostsDetailViewController *)_deleagte;
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"app/like" andCookie:[NSString stringWithFormat:@"JSESSIONID=%@",[UserData currentUser].sessionid] showAnimation:YES success:^(NSDictionary *resultDic,NSString *msg) {
        NSInteger jj = [self.detailsModel.data.isLike integerValue] > 0 ? self.detailsModel.data.likeCount - 1:self.detailsModel.data.likeCount;
        
        if ([praise isEqualToString:@"1"]) {
            [[UtilsData sharedInstance]showAlertTitle:@"点赞成功" detailsText:nil time:1.5 aboutType:MBProgressHUDModeCustomView state:YES];
            self.praiseNumLab.text = SINT(jj +1);
            if ([self.deleagte isKindOfClass:[PostsDetailViewController class]]) {
                post.myBlock(@"zan");
            }
        }else{
            [[UtilsData sharedInstance]showAlertTitle:@"取消点赞" detailsText:nil time:1.5 aboutType:MBProgressHUDModeCustomView state:NO];
            self.praiseNumLab.text = SINT(jj);
            if ([self.deleagte isKindOfClass:[PostsDetailViewController class]]) {
                post.myBlock(@"no_zan");
            }
        }
        
    } failure:^(NSString *error, NSInteger code) {
        if (code == 2000) {
            [[UtilsData sharedInstance]  loginPlan:nil success:^(UserData *user) {
                
            } failure:^(UserData *user) {
                
            }];
        }
    }];
}

+ (void)hideBottomArticleView{
    for (UIView *view in MY_WINDOW.subviews ) {
        if ([view isKindOfClass:[BottomArticleView class]]) {
            [view removeFromSuperview];
            break;
        }
    }
}

+ (void)showBottomArticleView:(BaseModel *)date delegate:(UIViewController *)deleGate controllerName:(NSString *)cName andCliker:(dismissBlock)clue{
    for (UIView *view in deleGate.view.subviews ) {
        if ([view isKindOfClass:[BottomArticleView class]]) {
            [view removeFromSuperview];
            break;
        }
    }
    BottomArticleView *articleView = [[BottomArticleView alloc] initWithData:date];
    articleView.dismiss = clue;
    articleView.deleagte = deleGate;
    articleView.detailsModel = (DetailsModel *)date;
    [deleGate.view addSubview:articleView];
    [articleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(deleGate.view.mas_bottom).with.offset(0);
        make.left.equalTo(deleGate.view.mas_left).with.offset(0);
        make.right.equalTo(deleGate.view.mas_right).with.offset(0);
        make.height.equalTo(@50);
    }];
}


@end
