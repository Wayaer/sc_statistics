import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class SCStatistics {
  factory SCStatistics() => _singleton ??= SCStatistics._();

  SCStatistics._();

  static SCStatistics? _singleton;

  final MethodChannel _channel = const MethodChannel('sc_statistics');

  bool isInitialize = false;

  /// app 启动后初始化调用
  Future<bool> setup(SCInitialOptions options) async {
    if (!_supportPlatform && isInitialize) return false;
    final bool? state =
        await _channel.invokeMethod<bool?>('setup', options.toMap());
    if (state == true) isInitialize = state!;
    return state ?? false;
  }

  /// 设置网络状态
  /// [netType] 2G、3G、4G、5G、WiFi
  Future<bool> setNetType(String netType) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state =
        await _channel.invokeMethod<bool>('setNetType', netType);
    return state ?? false;
  }

  /// 设置用户信息
  Future<bool> setUser(SCUserInfoModel user) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state =
        await _channel.invokeMethod<bool>('setUser', user.toMap());
    return state ?? false;
  }

  /// app启动
  /// [channel] – 渠道名称 ： huawei、baidu、xiaomi  ios 等
  Future<bool> appStart(String channel) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state = await _channel.invokeMethod<bool>('appStart', channel);
    return state ?? false;
  }

  /// app退出
  /// [startTime] 启动时间,时间戳 单位秒
  /// [timeLength] 访问时长
  Future<bool> appStop(int startTime, int timeLength) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'appStop', {'startTime': startTime, 'timeLength': timeLength});
    return state ?? false;
  }

  /// 用户登录或退出
  /// [userId] 用户名（也可以是手机号）
  /// [operateType] // 1登录,2退出
  Future<bool> login(String userId, LoginType operateType) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'login', {'userId': userId, 'operateType': operateType.index + 1});
    return state ?? false;
  }

  /// 资源访问
  /// [action] 页面动作
  Future<bool> accessSource(SCAccessSourceModel model) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state =
        await _channel.invokeMethod<bool>('accessSource', model.toMap());
    return state ?? false;
  }

  /// 进入或退出页面
  /// [action] 页面动作
  Future<bool> accessPage(SCAccessPageModel model) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state =
        await _channel.invokeMethod<bool>('accessPage', model.toMap());
    return state ?? false;
  }

  /// 收藏
  /// [isCollect]  收藏为true，取消收藏为false
  Future<bool> collect({
    required SCSourceModel source,
    required SourceType sourceType,
    required bool isCollect,
  }) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'collect',
        source.toMap().addAllT(
            {'sourceType': sourceType.index, 'operationType': isCollect}));
    return state ?? false;
  }

  /// 评论
  /// [content] 评论内容
  Future<bool> comment({
    required SCSourceModel source,
    required String content,
    required SourceType sourceType,
  }) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'comment',
        source
            .toMap()
            .addAllT({'content': content, 'sourceType': sourceType.index}));
    return state ?? false;
  }

  /// 转发
  /// [shareType] 分享类型
  Future<bool> forward({
    required SCSourceModel source,
    required ShareType shareType,
    required SourceType sourceType,
  }) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'forward',
        source.toMap().addAllT(
            {'shareType': shareType.index, 'sourceType': sourceType.index}));
    return state ?? false;
  }

  /// 点赞
  /// [isStar] 是否点赞. 点赞为true，取消点赞为false
  Future<bool> thumbsUp({
    required SCSourceModel source,
    required bool isStar,
    required SourceType sourceType,
  }) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'thumbsUp',
        source.toMap().addAllT(
            {'operationType': isStar, 'sourceType': sourceType.index}));
    return state ?? false;
  }

  /// 活动直播 播放心跳
  /// [heartbeatLength] 心跳时间，第一次开启直播统计直播事件时心跳值为0，之后每次调用值为60；即每隔60秒上传一次直播日志
  Future<bool> livePlay(SCSourceModel source, int heartbeatLength) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state = await _channel.invokeMethod<bool>('livePlay',
        source.toMap().addAllT({'heartbeatLength': heartbeatLength}));
    return state ?? false;
  }

  /// 搜索
  /// [content] 搜索内容
  Future<bool> search(String userId, String content) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state = await _channel
        .invokeMethod<bool>('search', {'userId': userId, 'content': content});
    return state ?? false;
  }

  /// 新闻 视频播放
  /// [contentLength] 视频时长（无时长可传0）
  /// [isComplete] 是否播放完
  Future<bool> videoPlay(
      {required SCSourceModel source,
      required int contentLength,
      required bool isComplete}) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'videoPlay',
        source.toMap().addAllT(
            {'contentLength': contentLength, 'isComplete': isComplete}));
    return state ?? false;
  }

  /// 发布爆料
  Future<bool> report(SCReportModel source) async {
    if (!_supportPlatform && !isInitialize) return false;
    final bool? state =
        await _channel.invokeMethod<bool>('report', source.toMap());
    return state ?? false;
  }

  /// 电视频道 播放心跳 仅支持 android
  /// [heartbeatLength] 心跳时间，第一次开启直播统计直播事件时心跳值为0，之后每次调用值为60；即每隔60秒上传一次直播日志
  Future<bool> tvPlay({
    required SCSourceModel source,
    required int heartbeatLength,
    required LiveType liveType,
  }) async {
    if (!_isAndroid && !isInitialize) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'tvPlay',
        source.toMap().addAllT(
            {'heartbeatLength': heartbeatLength, 'liveType': liveType.index}));
    return state ?? false;
  }
}

enum NetType {
  /// wifi
  wifi,

  /// 蜂窝网络
  cellular
}

enum LoginType {
  /// 登录
  login,

  /// 退出
  logout
}

/// 资源类型
enum SourceType {
  /// 0、新闻点播（视频）
  newsVideo,

  /// 1、专题，
  subject,

  /// 2、直播/频道（互动直播），
  liveStream,

  /// 3、电视直播
  tvLive,

  /// 4、资讯（稿件）
  manuscript,

  /// 5、广播电台
  broadcastingStation,

  /// 6、爆料
  announce,

  /// 7、问政
  askAboutPolitics,

  /// 8、积分商城
  store,

  /// 9、微头条
  headlineNews,

  /// 10、社交
  socialContact,

  /// 11、广告
  advertising,

  /// 12、其他
  other
}

/// 分享类型
enum ShareType {
  /// 微信
  weiXin,

  /// 微博
  weiBo,

  /// QQ
  qq,

  /// 其他
  other
}

class SCLivePlayModel extends SCSourceModel {
  SCLivePlayModel({
    required super.userId,
    required super.sourceId,
    required super.sourceName,
    required this.heartbeatLength,
    required this.liveType,
    required this.totalTime,
    required this.offTime,
  });

  /// 心跳
  final int heartbeatLength;

  /// 直播总时长，单位秒（普通直播、互动直播使用）
  final int totalTime;

  /// 退出时间，格式时间戳
  final int offTime;

  /// 1、普通直播 2、互动直播、3、电台直播、4、电视直播、5、慢直播、
  final LiveType liveType;

  @override
  Map<String, dynamic> toMap() => super.toMap().addAllT({
        'liveType': liveType.index,
        'heartbeatLength': heartbeatLength,
        'offTime': offTime,
        'totalTime': totalTime,
      });
}

enum LiveType {
  /// 1、普通直播
  normal,

  /// 2、互动直播
  interaction,

  /// 3、电台直播
  radioBroadcast,

  /// 4、电视直播
  tv,

  /// 5、慢直播
  slow
}

class SCAccessPageModel extends SCSourceModel {
  SCAccessPageModel({
    required super.userId,
    required super.sourceId,
    required super.sourceName,
    required this.sourceType,
    required this.action,
    required this.channelId,
    required this.timeLength,
    this.operateType = OperateType.foreground,
    this.sourcePage = '',
    this.isHome = false,
  });

  /// 是否是进入页面. 0进入页面，1退出页面
  final AccessAction action;

  /// 所属栏目 ID
  final String channelId;

  /// 访问时长 单位S
  final int timeLength;

  final SourceType sourceType;

  /// 前台访问  或  后台访问
  final OperateType operateType;

  /// 进入页面ID，从A页面跳转到当前页面B，这个地方填A的ID，如果没有则空
  final String sourcePage;

  /// 是否首页,true 是, false 不是
  final bool isHome;

  @override
  Map<String, dynamic> toMap() => super.toMap().addAllT({
        'action': action.index,
        'channelId': channelId,
        'timeLength': timeLength,
        'sourceType': sourceType.index,
        'operateType': operateType.index + 1,
        'sourcePage': sourcePage,
        'isHome': isHome
      });
}

class SCReportModel extends SCSourceModel {
  SCReportModel({
    required this.sourceContent,
    required this.title,
    required this.sourceType,
    required super.userId,
    required super.sourceId,
  }) : super(sourceName: '');

  /// 内容
  final String sourceContent;

  /// 标题
  final String title;

  /// 类型
  final SourceType sourceType;

  @override
  Map<String, dynamic> toMap() => super.toMap().addAllT({
        'sourceContent': sourceContent,
        'title': title,
        'sourceType': sourceType.index,
      });
}

class SCSourceModel {
  SCSourceModel({
    required this.userId,
    required this.sourceId,
    required this.sourceName,
  });

  /// 用户手机号或者用户唯一id（未登录时可传""）
  late String userId;

  /// 内容id
  late String sourceId;

  /// 内容 标题
  late String sourceName;

  Map<String, dynamic> toMap() =>
      {'userId': userId, 'sourceId': sourceId, 'sourceName': sourceName};
}

enum OperateType {
  /// 前台访问
  foreground,

  /// 后台访问
  background
}

enum AccessAction {
  /// 进入
  entry,

  /// 退出
  exit
}

class SCAccessSourceModel extends SCSourceModel {
  SCAccessSourceModel(
      {required super.userId,
      required super.sourceId,
      required super.sourceName,
      required this.action,
      required this.channelId,
      required this.timeLength,
      required this.sourceType,
      this.offTime,
      this.path,
      this.summary,
      this.sourceTag});

  /// 是否是进入页面. 0进入页面，1退出页面
  final AccessAction action;

  /// 频道/栏目ID
  final String channelId;

  /// 访问时长 单位S
  final int timeLength;

  final SourceType sourceType;

  /// 退出时间，格式时间戳，退出类型的时候使用
  final String? offTime;

  /// 访问路径
  final String? path;

  /// 摘要
  final String? summary;

  /// ***** 以下仅支持 android ***** ///
  /// 新闻标签(经济｜军事｜历史等)
  final String? sourceTag;

  @override
  Map<String, dynamic> toMap() => super.toMap().addAllT({
        'action': action.index,
        'channelId': channelId,
        'timeLength': timeLength,
        'sourceType': sourceType.index,
        'offTime': offTime,
        'path': path,
        'summary': summary,
        'sourceTag': sourceTag
      });
}

class SCUserInfoModel {
  SCUserInfoModel(
      {required this.appId,
      required this.userCode,
      required this.userName,
      required this.realName,
      required this.status,
      required this.email,
      required this.tel,
      required this.mobile,
      required this.headPic,
      required this.origin,
      required this.sex,
      required this.age,
      required this.tag,
      required this.other,
      required this.createTime,
      required this.extend,
      required this.deleted});

  /// 区分app的app id
  final String appId;

  /// 用户code,member id
  final String userCode;

  /// 用户名称
  final String userName;

  /// 用户真实姓名
  final String realName;

  /// 状态
  final String status;

  /// 邮箱
  final String email;

  /// 电话-座机
  final String tel;

  /// 手机
  final String mobile;

  /// 头像
  final String headPic;

  /// 来源
  final String origin;

  /// 1是男  2是女
  final int sex;

  /// 年龄
  final int age;

  /// 标签,时政,视频
  final String tag;

  /// 扩展字段,用来扩展额外的信息
  final String other;

  /// 创建时间,年月日2020/2/13
  final String createTime;

  /// ***** 以下仅支持 android ***** ///

  /// 扩展字段
  final String extend;

  /// 是否已经删除.
  final String deleted;

  Map<String, dynamic> toMap() => {
        'appId': appId,
        'userCode': userCode,
        'userName': userName,
        'realName': realName,
        'status': status,
        'email': email,
        'tel': tel,
        'mobile': mobile,
        'headPic': headPic,
        'origin': origin,
        'sex': sex,
        'age': age,
        'tag': tag,
        'other': other,
        'createTime': createTime,
        'extend': extend,
        'deleted': deleted
      };
}

class SCInitialOptions {
  SCInitialOptions({
    required this.appId,
    required this.appVersion,
    required this.areaId,
    required this.deviceId,
    required this.netType,
    this.channel = '',
    this.gaodeApiKey = '',
    this.enableLog = true,
    this.startType = '直接打开',
  });

  /// appId
  final String appId;

  /// 区域id
  final String areaId;

  /// app版本号
  final String appVersion;

  /// 当前网络类型
  final NetType netType;

  /// 渠道
  final String channel;

  /// ***** 以下仅支持 ios ***** ///

  /// 设备唯一标识
  final String deviceId;

  /// 高德 apiKey
  final String gaodeApiKey;

  /// 是否开始日志
  final bool enableLog;

  /// app 启动来源，分三种：直接打开、push唤醒、app调起，默认为直接打开
  final String startType;

  Map<String, dynamic> toMap() => {
        'appId': appId,
        'areaId': areaId,
        'appVersion': appVersion,
        'netType': (netType.index + 1).toString(),
        'channel': channel,
        'deviceId': deviceId,
        'gaodeApiKey': gaodeApiKey,
        'enableLog': enableLog,
        'startType': startType,
      };
}

extension ExtensionMap<K, V> on Map<K, V> {
  Map<K, V> addAllT(Map<K, V> map) {
    addAll(map);
    return this;
  }
}

bool get _supportPlatform {
  if (!kIsWeb && (_isAndroid || _isIOS)) return true;
  debugPrint('Not support platform for $defaultTargetPlatform');
  return false;
}

bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;

bool get _isIOS => defaultTargetPlatform == TargetPlatform.iOS;
