//
//  MessageModel.h
//  WHFinance
//
//  Created by wanhong on 2017/7/6.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

 /**消息类型注册*/
//public static final byte MESSAGE_TYPE_REGIN     = 0x0000;
/**消息类型交易*/
//public static final byte MESSAGE_TYPE_TRANS     = 0x0001;
/**消息类型系统*/
//public static final byte MESSAGE_TYPE_SYSTEM    = 0x0002;
/**消息类型结算*/
//public static final byte MESSAGE_TYPE_SETTL     = 0x0004;


@property (nonatomic, strong) NSString *context;

@property (nonatomic, strong) NSString *createAgentId;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *tid;

@property (nonatomic, strong) NSString *messageType;//0

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *title;


@end
