//
//  BaseCell.h
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseCell : UITableViewCell

@property(nonatomic,strong)NSString *typess;//type	类型 1新闻2视频3话题4帖子

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath;


@end
