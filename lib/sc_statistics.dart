import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ScStatistics {
  factory ScStatistics() => _getInstance();

  ScStatistics._internal();

  static ScStatistics get instance => _getInstance();
  static ScStatistics? _instance;

  static ScStatistics _getInstance() {
    _instance ??= ScStatistics._internal();
    return _instance!;
  }

  final MethodChannel _channel = const MethodChannel('sc_statistics');

  /// app 启动后初始化调用
  /// 调用初始化后 会自动调用appStart
  Future<bool> init(InitModel model) async {
    if (!_supportPlatform) return false;
    print(model.toMap());
    final bool? state =
        await _channel.invokeMethod<bool?>('init', model.toMap());
    return state ?? false;
  }

  /// app登录
  Future<bool> appLogin(String userId) async {
    if (!_supportPlatform) return false;
    final bool? state = await _channel.invokeMethod<bool>('appLogin', userId);
    return state ?? false;
  }

  /// app退出
  Future<bool> appStop() async {
    if (!_supportPlatform) return false;
    final bool? state = await _channel.invokeMethod<bool>('appStop');
    return state ?? false;
  }

  /// 进入或退出页面
  /// [action] 页面动作
  Future<bool> pageAction(
    SourceModel sourceModel,
    PageAction action, {
    String? sourceTag,
  }) async {
    if (!_supportPlatform) return false;
    final Map<String, dynamic> map = sourceModel.toMap();
    final bool? state = await _channel.invokeMethod<bool>(
        'pageAction',
        map.addAllT(<String, dynamic>{
          'action': (PageAction.values.indexOf(action)).toString(),
          'sourceTag': sourceTag ?? '',
        }));
    return state ?? false;
  }

  /// 收藏
  /// [type] 收藏类型
  Future<bool> collect(SourceModel sourceModel, CollectType type) async {
    if (!_supportPlatform) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'collect',
        sourceModel.toMap().addAllT(
            <String, dynamic>{'type': CollectType.values.indexOf(type)}));
    return state ?? false;
  }

  /// 评论
  /// [content] 评论内容
  Future<bool> comment(SourceModel sourceModel, String content) async {
    if (!_supportPlatform) return false;
    final bool? state = await _channel.invokeMethod<bool>('comment',
        sourceModel.toMap().addAllT(<String, dynamic>{'content': content}));
    return state ?? false;
  }

  /// 分享
  /// [shareType] 分享类型
  Future<bool> share(SourceModel sourceModel, ShareType shareType) async {
    if (!_supportPlatform) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'share',
        sourceModel.toMap().addAllT(<String, dynamic>{
          'shareType': ShareType.values.indexOf(shareType)
        }));
    return state ?? false;
  }

  /// 点赞
  /// [star] 是否点赞
  Future<bool> thumbsUp(SourceModel sourceModel, bool isLike) async {
    if (!_supportPlatform) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'thumbsUp',
        sourceModel
            .toMap()
            .addAllT(<String, dynamic>{'isLike': isLike ? 1 : 2}));
    return state ?? false;
  }

  /// 搜索
  /// [content] 搜索内容
  Future<bool> search(String userId, String content) async {
    if (!_supportPlatform) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'search', <String, dynamic>{'userId': userId, 'content': content});
    return state ?? false;
  }

  /// 新闻 视频播放
  /// [contentLength] 视频时长（无时长可传0）
  /// [isComplete] 是否播放完
  Future<bool> newsPlay(
      SourceModel sourceModel, int contentLength, bool isComplete) async {
    if (!_supportPlatform) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'newsPlay',
        sourceModel.toMap().addAllT(<String, dynamic>{
          'contentLength': contentLength,
          'isComplete': isComplete ? 1 : 0
        }));
    return state ?? false;
  }

  /// 活动直播 播放心跳
  /// [heartbeatLength] 心跳时间，第一次开启直播统计直播事件时心跳值为0，之后每次调用值为60；即每隔60秒上传一次直播日志
  Future<bool> livePlay(SourceModel sourceModel, int heartbeatLength) async {
    if (!_supportPlatform) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'livePlay',
        sourceModel
            .toMap()
            .addAllT(<String, dynamic>{'heartbeatLength': heartbeatLength}));
    return state ?? false;
  }

  /// 发布爆料
  /// [sourceName] 爆料内容详情
  /// [sourceId] 发表内容id
  Future<bool> report(SourceModel sourceModel) async {
    if (!_supportPlatform) return false;
    final bool? state =
        await _channel.invokeMethod<bool>('livePlay', sourceModel.toMap());
    return state ?? false;
  }

  /// 电视频道播放
  /// [heartbeatLength] 心跳时间，第一次开启直播统计直播事件时心跳值为0，之后每次调用值为60；即每隔60秒上传一次直播日志
  Future<bool> tvPlay(SourceModel sourceModel, int heartbeatLength) async {
    if (!_isAndroid) return false;
    final bool? state = await _channel.invokeMethod<bool>(
        'tvPlay',
        sourceModel
            .toMap()
            .addAllT(<String, dynamic>{'heartbeatLength': heartbeatLength}));
    return state ?? false;
  }
}

enum NetType {
  /// wifi
  wifi,

  /// 蜂窝网络
  cellular
}

/// 收藏类型
enum CollectType {
  /// 新闻
  news,

  /// 专题
  subject,

  /// 直播或频道
  liveOrTV,

  /// 频道
  other
}

/// 分享类型
enum ShareType {
  /// 微信
  wx,

  /// 微博
  wb,

  /// QQ
  qq,

  /// 其他
  other
}

enum PageAction {
  /// 开始进入页面
  start,

  /// 退出页面
  end,
}

class SourceModel {
  SourceModel({
    required this.userId,
    required this.sourceId,
    required this.sourceName,
  });

  /// 用户id
  late String userId;

  /// 内容id
  late String sourceId;

  /// 内容 标题 或者 详情
  late String sourceName;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'userId': userId,
        'sourceId': sourceId,
        'sourceName': sourceName
      };
}

class InitModel {
  InitModel({
    required this.appVersion,
    required this.areaId,
    required this.deviceId,
    required this.ip,
    required this.netType,
    required this.location,
  });

  /// 区域id
  late String areaId;

  /// 设备唯一标识
  late String deviceId;

  /// app版本号
  late String appVersion;

  /// ip 地址
  late String ip;

  /// 当前网络类型
  late NetType netType;

  /// 当前登录位置
  late String location;

  Map<String, String> toMap() => <String, String>{
        'areaId': areaId,
        'deviceId': deviceId,
        'appVersion': appVersion,
        'ip': ip,
        'netType': (NetType.values.indexOf(netType) + 1).toString(),
        'location': location,
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
  print('Not support platform for $defaultTargetPlatform');
  return false;
}

bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;

bool get _isIOS => defaultTargetPlatform == TargetPlatform.iOS;
