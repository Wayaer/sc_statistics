//
//  SCDataStatisticsEventObject.h
//  SCDataStatisticsSDK
//
//  Created by wangm on 2020/2/10.
//  Copyright © 2020 wangm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SCStatisticsCollectSourceType) {
    SCStatisticsCollectSourceTypeNews,    //新闻
    SCStatisticsCollectSourceTypeSpecial, //专题
    SCStatisticsCollectSourceTypeLive,    //直播 或 频道
    SCStatisticsCollectSourceTypeOther,   //其他
};

typedef NS_ENUM(NSUInteger, SCStatisticsForwoardType) {
    SCStatisticsForwoardTypeWeiXin, //微信
    SCStatisticsForwoardTypeWeiBo,  //微博
    SCStatisticsForwoardTypeQQ,     //QQ
    SCStatisticsForwoardTypeOther,  //其他
};

//所有事件的父类
@interface SCDataStatisticsEventObject : NSObject

@end

/**
 登录事件对象
 */
@interface SCDataStatisticsLoginEvent : SCDataStatisticsEventObject

@property (nonatomic, copy) NSString *userId; //用户名（也可以是手机号）

@end

/**
 页面访问事件对象
 */
@interface SCDataStatisticsAccessPageEvent : SCDataStatisticsEventObject

@property (nonatomic, copy) NSString *userId; //用户名（非必传）

@property (nonatomic, copy) NSString *sourceName; //资源名称（例如访问新闻则是新闻标题，或是进入页面的名称）

@property (nonatomic, copy) NSString *sourceId; //资源id

@property (nonatomic, assign) BOOL isAccess; //是否是进入页面. 进入页面为YES，退出页面为NO

@end

/**
 收藏事件对象
 */
@interface SCDataStatisticsCollectEvent : SCDataStatisticsEventObject

@property (nonatomic, copy) NSString *userId; //用户名（非必传）

@property (nonatomic, copy) NSString *sourceName; //资源名称

@property (nonatomic, copy) NSString *sourceId; //资源名称

@property (nonatomic, assign) SCStatisticsCollectSourceType sourceType; //资源类型

@end

/**
 评论事件对象
 */
@interface SCDataStatisticsCommentEvent : SCDataStatisticsEventObject

@property (nonatomic, copy) NSString *userId; //用户名（非必传）

@property (nonatomic, copy) NSString *sourceName; //资源名称（例如访问新闻则是新闻标题，或是进入页面的名称）

@property (nonatomic, copy) NSString *sourceId; //资源id

@property (nonatomic, copy) NSString *commentDetail; //评论内容

@end

/**
 转发事件对象
 */
@interface SCDataStatisticsForwoardEvent : SCDataStatisticsEventObject

@property (nonatomic, copy) NSString *userId; //用户名（非必传）

@property (nonatomic, copy) NSString *sourceName; //资源名称（例如访问新闻则是新闻标题，或是进入页面的名称）

@property (nonatomic, copy) NSString *sourceId; //资源id

@property (nonatomic, assign) SCStatisticsForwoardType shareType; //分享渠道

@end

/**
 点赞事件对象
 */
@interface SCDataStatisticsThumbsUpEvent : SCDataStatisticsEventObject

@property (nonatomic, copy) NSString *userId; //用户名（非必传）

@property (nonatomic, copy) NSString *sourceName; //资源名称（例如访问新闻则是新闻标题，或是进入页面的名称）

@property (nonatomic, copy) NSString *sourceId; //资源id

@property (nonatomic, assign) BOOL isLike; //是否点赞. 点赞为YES，取消点赞为NO

@end

/**
 直播事件对象
 */
@interface SCDataStatisticsLiveEvent : SCDataStatisticsEventObject

@property (nonatomic, copy) NSString *userId; //用户名（非必传）

@property (nonatomic, copy) NSString *sourceName; //资源名称（例如访问新闻则是新闻标题，或是进入页面的名称）

@property (nonatomic, copy) NSString *sourceId; //资源id

@property (nonatomic, assign) NSInteger heartbeatLength; //心跳

@end


/**
 搜索事件对象
 */
@interface SCDataStatisticsSearchEvent : SCDataStatisticsEventObject

@property (nonatomic, copy) NSString *userId; //用户名（非必传）

@property (nonatomic, copy) NSString *content; //搜索内容

@end

/**
 视频事件对象
 */
@interface SCDataStatisticsVedioEvent : SCDataStatisticsEventObject

@property (nonatomic, copy) NSString *userId; //用户名（非必传）

@property (nonatomic, copy) NSString *sourceName; //资源名称（例如访问新闻则是新闻标题，或是进入页面的名称）

@property (nonatomic, copy) NSString *sourceId; //资源id

@property (nonatomic, assign) NSInteger contentLength; //视频时长（单位：秒）

@property (nonatomic, assign) BOOL isComplete; //是否播放完成

@end

/**
 app退出事件对象
 */
@interface SCDataStatisticsAppTerminateEvent : SCDataStatisticsEventObject

@end

/**
 app发布爆料事件对象
 */
@interface SCDataStatisticsReportEvent : SCDataStatisticsEventObject

@property (nonatomic, copy) NSString *userId; //用户名（非必传）

@property (nonatomic, copy) NSString *sourceContent; //爆料内容详情

@property (nonatomic, copy) NSString *sourceId; //发表内容id

@end


NS_ASSUME_NONNULL_END
