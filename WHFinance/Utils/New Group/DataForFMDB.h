//
//  DataForFMDB.h
//  WHFinance
//
//  Created by wanhong on 2017/7/10.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MessageModel;
@interface DataForFMDB : NSObject{
    FMDatabase *fmdb;
}

+(instancetype)sharedDataBase;

-(void)deleteStudent:(MessageModel*)student;

-(void)addStudent:(MessageModel *)student;

-(NSMutableArray*)getAllMessage;
@end
