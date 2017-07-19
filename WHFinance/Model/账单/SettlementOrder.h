//
//  SettlementOrder.h
//  WHFinance
//
//  Created by wanhong on 2017/7/12.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseModel.h"

/**订单状态 等待支付*/
//public static final byte ORDER_STATUS_WAIT_TO_PAY     = 0;
/**订单状态 支付中*/
//public static final byte ORDER_STATUS_PAYING          = 1;
/**订单状态 支付成功*/
//public static final byte ORDER_STATUS_SUCCESS         = 2;
/**支付失败*/
//public static final byte ORDER_STATUS_FAIL            = 3;
//审核中
//public static final byte ORDER_STATUS_AUDITION        = 4;

@interface SettlementOrder : BaseModel

@property (nonatomic, strong) NSString *agentId;

@property (nonatomic, strong) NSString *channelResultMsg;

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *platformId;

@property (nonatomic, strong) NSString *settleAmount;

@property (nonatomic, strong) NSString *settleChannelId;

@property (nonatomic, strong) NSString *settleFee;

@property (nonatomic, strong) NSString *settleInfoId;

@property (nonatomic, strong) NSString *settleOrderNo;

@property (nonatomic, strong) NSString *settleProductType;

@property (nonatomic, strong) NSString *settleTime;

@property (nonatomic, strong) NSString *settlementCardNo;//结算卡号

@property (nonatomic, strong) NSString *statue;//结算状态 4审核

@property (nonatomic, strong) NSString *statueCn;

@property (nonatomic, strong) NSString *tid;

@property (nonatomic, strong) NSString *userId;

@end
