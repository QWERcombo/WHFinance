//
//  NSMutableDictionary+YXP.h
//  YouXiPartner
//
//  Created by 265G on 15-1-27.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (YXP)

- (void)safeRemoveObjectForKey:(id)aKey;
- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey;
//或许用户基本信息
-(NSMutableDictionary *)getUserTheBasicInformation;
@end
