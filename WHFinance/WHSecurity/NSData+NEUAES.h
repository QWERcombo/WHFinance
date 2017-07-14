//
//  NSData+AES.h
//  Smile
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (NEUAES)

- (NSData *)AES128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //解密


/**
 * Encrypt NSData using AES256 with a given symmetric encryption key.
 * @param key The symmetric encryption key
 */
- (NSData *)AES256EncryptWithKey:(NSString *)key;

/**
 * Decrypt NSData using AES256 with a given symmetric encryption key.
 * @param key The symmetric encryption key
 */
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
