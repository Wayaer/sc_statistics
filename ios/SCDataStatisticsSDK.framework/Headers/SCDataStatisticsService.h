//
//  SCDataStatisticsService.h
//  SCDataStatisticsSDK
//
//  Created by wangm on 2020/2/10.
//  Copyright © 2020 wangm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCDataStatisticsEventObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCDataStatisticsLaunchConfig : NSObject

/* 设备唯一UUID. */
@property (nonatomic, copy) NSString *deviceId;

/* 区域Id，每个区域所分配的Id，根据id区分不同地区的日志内容 */
@property (nonatomic, copy) NSString *areaId;

/* app的版本号. 例如1.0.0 */
@property (nonatomic, copy) NSString *appVersion;

/* 设备ip地址. */
@property (nonatomic, copy) NSString *ipAddress;

/* 定位.（格式：成都市|武侯区） */
@property (nonatomic, copy) NSString *location;

/* 网络.（1、wifi；2、移动网络）*/
@property (nonatomic, copy) NSString *netType;

@end

@interface SCDataStatisticsService : NSObject

/*!
 * @abstract 单例
*/
+ (SCDataStatisticsService *)shareInstance;

/*!
 * @abstract app启动SDK
 *
 * @param config SDK启动相关模型
 */
- (void)setupWithConfig:(SCDataStatisticsLaunchConfig *)config;

/*!
 * @abstract 登录日志
 *
 * @param userId 页面名称
 */
- (void)addLoginEventLog:(NSString *)userId;

/*!
 * @abstract 通用事件日志统计方法
 *
 * @param event 上报事件模型
*/
- (void)addEventLog:(SCDataStatisticsEventObject *)event;

/*!
 * @abstract 是否打印Debug级的log信息, 默认为NO
 *
 * 请在SDK启动后调用本接口，调用本接口可打开日志级别为: Debug，打印调试日志.
 * 请在发布产品时改为NO，避免产生不必要的IO
*/
- (void)setDebug:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
