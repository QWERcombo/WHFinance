//
//  ZZPhotoBrowerViewController.m
//  ZZPhotoKit
//
//  Created by 袁亮 on 16/5/27.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ZZPhotoBrowerViewController.h"
#import "ZZPhotoBrowerCell.h"
#import "ZZPageControl.h"
#import "ZZPhoto.h"
#import "ZZCamera.h"

@interface ZZPhotoBrowerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UIButton *back_btn;
}

@property (nonatomic, strong) UICollectionView *picBrowse;
@property (nonatomic, assign) NSInteger        numberOfItems;
@property (nonatomic, strong) UIBarButtonItem  *backBarButton;
@property (nonatomic, strong) UIButton  *checkBtn;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, assign) BOOL isFirst;
@end

@implementation ZZPhotoBrowerViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    if (self.isScan) {
        
        if (_ReturnArrBlock) {
            
            _ReturnArrBlock(self.selectArray);
        }
    }
    if (self.isAllScan) {
        
        if (_ReturnArrBlock) {
            
            _ReturnArrBlock(self.selectArray);
        }
        
    }
    
    for (UIView *vieww in MY_WINDOW.subviews) {
        if ([vieww isKindOfClass:[UIPageControl class]]) {
            [vieww removeFromSuperview];
        }
    }
}
//-(UIBarButtonItem *)backBarButton
//{
//    if (!_backBarButton) {
//        UIButton *back_btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 44)];
//        [back_btn setImage:[UIImage imageNamed:@"MGoBack"] forState:UIControlStateNormal];
//        [back_btn setImage:[UIImage imageNamed:@"MGoBack"] forState:UIControlStateHighlighted];
//        back_btn.frame = CGRectMake(0, 0, 45, 44);
//        [back_btn addTarget:self action:@selector(backItemMethod) forControlEvents:UIControlEventTouchUpInside];
//        
//        _backBarButton = [[UIBarButtonItem alloc] initWithCustomView:back_btn];
//    }
//    return _backBarButton;
//}
- (NSMutableArray *)photoData {
    if (!_photoData) {
        _photoData = [NSMutableArray array];
    }
    return _photoData;
}
-(void)backItemMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) makeCollectionViewUI
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    /*
     *   创建核心内容 UICollectionView
     */
    self.view.backgroundColor = [UIColor blackColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = (CGSize){self.view.frame.size.width,self.view.frame.size.height-64};
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _picBrowse = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _picBrowse.backgroundColor = [UIColor clearColor];
    _picBrowse.pagingEnabled = YES;
    
    _picBrowse.showsHorizontalScrollIndicator = NO;
    _picBrowse.showsVerticalScrollIndicator = NO;
    [_picBrowse registerClass:[ZZPhotoBrowerCell class] forCellWithReuseIdentifier:NSStringFromClass([ZZPhotoBrowerCell class])];
    _picBrowse.dataSource = self;
    _picBrowse.delegate = self;
    _picBrowse.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_picBrowse];
    
    NSLayoutConstraint *list_top = [NSLayoutConstraint constraintWithItem:_picBrowse attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *list_bottom = [NSLayoutConstraint constraintWithItem:_picBrowse attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *list_left = [NSLayoutConstraint constraintWithItem:_picBrowse attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *list_right = [NSLayoutConstraint constraintWithItem:_picBrowse attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0.0f];
    
    [self.view addConstraints:@[list_top,list_bottom,list_left,list_right]];
    
}

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.title = @"预览";
//    self.navigationItem.leftBarButtonItem = self.backBarButton;
    [self initPageControl];
    [self makeCollectionViewUI];
    
    if (self.hasDelete) {
//        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        deleteBtn.frame = CGRectMake(0, 0, 20, 20);
//        [deleteBtn addTarget:self action:@selector(deleAction:) forControlEvents:UIControlEventTouchUpInside];
//        [deleteBtn setBackgroundImage:IMG(@"delete_s") forState:UIControlStateNormal];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    }
    if (self.hasCheck) {
        back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        back_btn.frame = CGRectMake(0, 0, 25, 25);
        [back_btn setBackgroundImage:IMG(@"check_n") forState:UIControlStateNormal];
        [back_btn addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back_btn];
    }
    
    if (self.isScan||self.isAllScan) {
        for (ZZPhoto *ppp in self.photoData) {
            if (ppp.isSelect) {
                [self.selectArray addObject:ppp];
            }
        }
    }
}
/*
- (void)deleAction:(UIButton *)sender {
    [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"是否确定删除" haveCancel:YES doneAction:^{
        if ([[_photoData objectAtIndex:0] isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            NSDictionary *diction = [self.photoData objectAtIndex:self.pageControl.currentPage];
            [dict setObject:diction[@"pid"] forKey:@"id"];
            [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"photo/delete" andCookie:[NSString stringWithFormat:@"JSESSIONID=%@",[UserData currentUser].sessionid] showAnimation:NO success:^(NSDictionary *resultDic,NSString *msg) {
                //NSLog(@"+++++%@", resultDic);
                if ([resultDic[@"code"] isEqualToNumber:@1000]) {
                    [[UtilsData sharedInstance] showAlertTitle:nil detailsText:@"删除成功" time:2 aboutType:MBProgressHUDModeCustomView state:YES];
                    [self.photoData removeObject:diction];
                    [self initPageControl];
                    [self.picBrowse reloadData];
                }
            } failure:^(NSString *error, NSInteger code) {
                if (code == 2000) {
                    [[UtilsData sharedInstance]  loginPlan:nil success:^(UserData *user) {
                    } failure:^(UserData *user) {
                    }];
                }
            }];
            
        } else {
            _clikBlock(SINT(self.pageControl.currentPage));
            [self.photoData removeObjectAtIndex:self.pageControl.currentPage];
            [self initPageControl];
            [self.picBrowse reloadData];
        }
    } controller:self];
}
*/

- (void)initPageControl {
    if (self.photoData.count==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (self.hasPageControl) {
        for (UIView *sub in MY_WINDOW.subviews) {
            if ([sub isKindOfClass:[UIPageControl class]]) {
                [sub removeFromSuperview];
            }
        }
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = self.photoData.count;
        _pageControl.currentPage = self.scrollIndex;
        [MY_WINDOW addSubview:self.pageControl];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(100));
            make.height.equalTo(@(20));
            make.centerX.equalTo(MY_WINDOW.mas_centerX);
            make.bottom.equalTo(MY_WINDOW.mas_bottom).offset(-20);
        }];
    } else {
        [self.pageControl removeFromSuperview];
    }
}
-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //滚动到指定位置
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f) {
        
        [_picBrowse scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_scrollIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        
    } else {
        if (!_isFirst) {
            [_picBrowse scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_scrollIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
            _isFirst = YES;
        }
        
    }
    
    if (self.hasCheck) {
        
        ZZPhoto *photo = [self.photoData objectAtIndex:_scrollIndex];
        if (photo.isSelect) {
            [back_btn setBackgroundImage:[UIImage imageMaskedWithColor:[UIColor Grey_PurColor] strokeColor:nil andImageName:@"check_h"] forState:UIControlStateNormal];
        } else {
            [back_btn setBackgroundImage:IMG(@"check_n") forState:UIControlStateNormal];
        }
    }
}

#pragma mark --- UICollectionviewDelegate or dataSource
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photoData.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZPhotoBrowerCell *browerCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZZPhotoBrowerCell class]) forIndexPath:indexPath];
    
    browerCell.clikBlock = ^(NSString *cli){
        if ([cli isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:YES];
        };
    };
    
    if ([[_photoData objectAtIndex:indexPath.row] isKindOfClass:[ZZPhoto class]]) {
        //加载相册中的数据时实用
        ZZPhoto *photo = [_photoData objectAtIndex:indexPath.row];
        [browerCell loadPHAssetItemForPics:photo.asset];
    }
    if ([[_photoData objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        browerCell.imgurl = [_photoData objectAtIndex:indexPath.row];
        [browerCell.photo_image_view sd_setImageWithURL:URL_STRING([_photoData objectAtIndex:indexPath.row])];
    }
    if ([[_photoData objectAtIndex:indexPath.row] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = [_photoData objectAtIndex:indexPath.row];
        browerCell.imgurl = dic[@"img"];
        [browerCell.photo_image_view sd_setImageWithURL:URL_STRING(dic[@"img"])];
    }
    if ([[_photoData objectAtIndex:indexPath.row] isKindOfClass:[ZZCamera class]]) {
        ZZCamera *camera = [_photoData objectAtIndex:indexPath.row];
        browerCell.photo_image_view.image = camera.image;
    }
    return browerCell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[ZZPhotoBrowerCell class]]) {
        [(ZZPhotoBrowerCell *)cell recoverSubview];
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[ZZPhotoBrowerCell class]]) {
        [(ZZPhotoBrowerCell *)cell recoverSubview];
    }
}

-(void) showIn:(UIViewController *)controller with:(ClikBlock)club
{
    _clikBlock = club;
    [controller.navigationController pushViewController:self animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _scrollIndex = self.picBrowse.contentOffset.x/SCREEN_WIGHT;
    self.pageControl.currentPage = self.picBrowse.contentOffset.x/SCREEN_WIGHT;
    
    if (self.hasCheck) {
        ZZPhoto *photo = [self.photoData objectAtIndex:_scrollIndex];
        if (photo.isSelect) {
            [back_btn setBackgroundImage:[UIImage imageMaskedWithColor:[UIColor Grey_PurColor] strokeColor:nil andImageName:@"check_h"] forState:UIControlStateNormal];
        } else {
            [back_btn setBackgroundImage:IMG(@"check_n") forState:UIControlStateNormal];
        }
    }
}
- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

//选中
- (void)check:(UIBarButtonItem *)sender {
//    _ReturnArrBlock(self.photoData);
    ZZPhoto *photo = [self.photoData objectAtIndex:_scrollIndex];
    if (photo != nil) {
        if (photo.isSelect == NO) {
            photo.isSelect = YES;
            [back_btn setBackgroundImage:[UIImage imageMaskedWithColor:[UIColor Grey_PurColor] strokeColor:nil andImageName:@"check_h"] forState:UIControlStateNormal];
//            [self.photoData addObject:photo];
//            _ReturnArrBlock([self.selectArray ]);
            if (self.isScan) {
                
                if (self.selectArray.count>9) {
                    
                    return;
                }
                [self.selectArray addObject:photo];
            }
            if (self.isAllScan) {
                
                if (self.selectArray.count>9) {
                    
                    return;
                }
                [self.selectArray addObject:photo];
            }
            
//            if (self.selectArray.count + 1 > _selectNum) {
//                [self showSelectPhotoAlertView:_selectNum];
//            }else{
//                [[ZZAlumAnimation sharedAnimation] roundAnimation:self.totalRound];
//                
//                if ([self.datas CheckIsiCloudAsset:photo.asset] == YES) {
//                    [[ZZPhotoAlert sharedAlert] showPhotoAlert];
//                }else{
//                    photo.isSelect = YES;
//                    [self changeSelectButtonStateAtIndex:index withPhoto:photo];
//                    [self.selectArray insertObject:[self.photoArray objectAtIndex:index] atIndex:self.selectArray.count];
//                    self.totalRound.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.selectArray.count];
//                }
//            }
        }else{
            photo.isSelect = NO;
            [back_btn setBackgroundImage:IMG(@"check_n") forState:UIControlStateNormal];
            if (self.isScan) {
                [self.selectArray removeObject:photo];
            }
            if (self.isAllScan) {
                [self.selectArray removeObject:photo];
            }
//            [self.selectArray removeObject:photo];
            NSLog(@"**********%@", self.selectArray);
//            [self changeSelectButtonStateAtIndex:index withPhoto:photo];
//            [self.selectArray removeObject:[self.photoArray objectAtIndex:index]];
//            [[ZZAlumAnimation sharedAnimation] roundAnimation:self.totalRound];
//            self.totalRound.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.selectArray.count];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
