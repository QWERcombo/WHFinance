//
//  DataForFMDB.m
//  WHFinance
//
//  Created by wanhong on 2017/7/10.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "DataForFMDB.h"

@implementation DataForFMDB


static DataForFMDB *theData = nil;

+(instancetype)sharedDataBase{
    @synchronized(self) {
        if(!theData) {
            
            theData= [[DataForFMDB alloc] init];
            
            [theData initDataBase];
            
        } }
    return theData;
}

- (void)initDataBase {
    //获得Documents目录路径
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    //文件路径
    
    NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"message_%@.db", [UserData currentUser].uid]];
    
    //实例化FMDataBase对象
    
    NSLog(@"---path:%@",filePath);
    
    fmdb= [FMDatabase databaseWithPath:filePath];
    
    if([fmdb open]) {
        
        //初始化数据表
        
        [self addMessageTable];
//
//        [self addClassTable];
        
        [fmdb close];
        
    }else{
        
        NSLog(@"数据库打开失败---%@", fmdb.lastErrorMessage);
        
    }
    
}


-(void)addMessageTable{
    
    NSString *meaageSQL =[NSString stringWithFormat:@"create table if not exists message_%@ (context text, createAgentId text, createTime text, tid text, messageType text, status text, title text)",[UserData currentUser].uid];
    
    BOOL studentSuccess = [fmdb executeUpdate:meaageSQL];
    
    if(!studentSuccess) {
        
        NSLog(@"messageTable创建失败---%@",fmdb.lastErrorMessage);
        
    } else {
        
        NSLog(@"messageTable创建成功");
        
    }
    
}
-(NSMutableArray*)getAllMessage{
    
    [fmdb open];
    
    NSMutableArray*array = [NSMutableArray new];
    
    FMResultSet*result = [fmdb executeQuery:[NSString stringWithFormat:@"select * from message_%@", [UserData currentUser].uid]];
    
    while([result next]) {
        
        MessageModel *student = [[MessageModel alloc] init];
        
        student.context= [result stringForColumn:@"context"];
        
        student.createAgentId= [result stringForColumn:@"createAgentId"];
        
        student.createTime= [result stringForColumn:@"createTime"];
        
        student.tid= [result stringForColumn:@"tid"];
        
        student.messageType= [result stringForColumn:@"messageType"];
        
        student.status= [result stringForColumn:@"status"];
        
        student.title= [result stringForColumn:@"title"];
        
        [array addObject:student];
        
    }
    
    [fmdb close];
    
    return array;
    
}

-(void)addStudent:(MessageModel *)student{
    
    [fmdb open];
    
    NSString*SQL = [NSString stringWithFormat:@"insert into message_%@(context,createAgentId,createTime,tid,messageType,status,title) values(?,?,?,?,?,?,?)", [UserData currentUser].uid];
    
    BOOL isAddSuccess = [fmdb executeUpdate:SQL,student.context,student.createAgentId,student.createTime,student.tid,student.messageType,student.status,student.title];
    
    if(!isAddSuccess) {
        
        NSLog(@"studentTable插入信息失败--%@",fmdb.lastErrorMessage);
        
    } else {
        
        NSLog(@"插入成功");
        
    }
    
    [fmdb close];
    
}

-(void)deleteStudent:(MessageModel*)student{
    
    [fmdb open];
    
    NSString*SQL = [NSString stringWithFormat:@"delete from message_%@ where tid = ?",[UserData currentUser].uid];
    
    BOOL isDeleteSuccess = [fmdb executeUpdate:SQL,student.tid];
    
    if(!isDeleteSuccess) {
        
        NSLog(@"studentTable删除某一信息失败--%@",fmdb.lastErrorMessage);
        
    } else {
        NSLog(@"删除成功");
    }
    
    [fmdb close];
    
}

-(void)deleteAllStudent{
    
    [fmdb open];
    
    NSString*SQL = [NSString stringWithFormat:@"delete from message_%@", [UserData currentUser].uid];
    
    BOOL isSuccess = [fmdb executeUpdate:SQL];
    
    if(!isSuccess) {
        
        NSLog(@"studentTable全部删除失败--%@",fmdb.lastErrorMessage);
        
    } else {
        NSLog(@"删除表成功");
    }
    
    //student表删除以后，对应的class也要删除
//    [self deleteAllClass];
    
    [fmdb close];
    
}




@end
