//
//  BottomArticleView.h
//  GoGoTree
//
//  Created by youqin on 16/8/16.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyTextView.h"


@interface BottomArticleView : UIView

typedef void (^dismissBlock)(NSString *clueStr);

@property (nonatomic, copy) dismissBlock dismiss;

@property (assign, nonatomic) id deleagte;

+ (void)showBottomArticleView:(BaseModel *)date delegate:(UIViewController *)deleGate controllerName:(NSString *)cName andCliker:(dismissBlock)clue;

+ (void)hideBottomArticleView;

@end
