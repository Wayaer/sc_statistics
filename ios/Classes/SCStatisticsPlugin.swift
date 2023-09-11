import FCDataStatisticsSDK
import FCMobStat
import Flutter
import UIKit

public class SCStatisticsPlugin: NSObject, FlutterPlugin {
    var channel: FlutterMethodChannel

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "sc_statistics", binaryMessenger: registrar.messenger())
        let instance = SCStatisticsPlugin(channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    init(_ _channel: FlutterMethodChannel) {
        channel = _channel
        super.init()
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setup":
            let args = call.arguments as! [String: Any]
            let mobTracker = FCMobTracker.default()
            let gaodeApiKey = args["gaodeApiKey"] as? String
            if gaodeApiKey != nil {
                mobTracker.gaodeApiKey = gaodeApiKey!
            }
            mobTracker.enableGps = gaodeApiKey != nil
            mobTracker.enableLog = args["enableLog"] as! Bool
            mobTracker.start_type = args["startType"] as! String
            FCMobTracker.start(withAppId: args["appId"] as! String)
            let config = FCDataStatisticsLaunchConfig()
            let appVersion = args["appVersion"] as! String
            config.appVersion = appVersion
            mobTracker.app_version = appVersion
            let channel = args["channel"] as! String
            config.channelName = channel
            mobTracker.app_channel = channel
            config.areaId = args["areaId"] as! String
            config.netType = (args["netType"] as! String) == "1" ? "WiFi" : "移动网络"
            FCDataStatisticsService.shareInstance().setup(with: config)
            FCDataStatisticsService.shareInstance().setDebug(mobTracker.enableLog)
            result(true)
        case "setNetType":
            FCDataStatisticsService.shareInstance().reSetNetType(call.arguments as! String)
            result(true)
        case "setUser":
            let args = call.arguments as! [String: Any]
            let user = FCMobUserModel()
            user.user_code = args["userCode"] as! String
            user.user_name = args["userName"] as! String
            user.real_name = args["realName"] as! String
            user.status = args["status"] as! String
            user.email = args["email"] as! String
            user.tel = args["tel"] as! String
            user.mobile = args["mobile"] as! String
            user.create_time = args["createTime"] as! String
            user.origin = args["origin"] as! String
            user.head_pic = args["headPic"] as! String
            user.other = args["other"] as! String
            user.tag = args["tag"] as! String
            user.sex = (args["sex"] as! NSNumber).int32Value
            user.age = (args["age"] as! NSNumber).int32Value
            FCMobTracker.setUserModel(user)
            result(true)
        case "appStart":
            FCDataStatisticsService.shareInstance().addLoginEventLog(call.arguments as! String)
            result(true)
        case "appStop":
            let args = call.arguments as! [String: Any]
            let event = FCDataStatisticsAppTerminateEvent()
            event.startTime = (args["startTime"] as! NSNumber).int32Value
            event.timeLength = (args["timeLength"] as! NSNumber).int32Value
            FCDataStatisticsService.shareInstance().addEventLog(event)
            result(true)
        case "login":
            let args = call.arguments as! [String: Any]
            let event = FCDataStatisticsLoginEvent()
            event.userId = args["userId"] as! String
            event.operateType = Int32(args["operateType"] as! Int)
            FCDataStatisticsService.shareInstance().addEventLog(event)
            result(true)
        case "accessSource":
            let args = call.arguments as! [String: Any?]
            let config = FCDataStatisticsAccessSourceEvent()
            config.userId = args["userId"] as! String
            config.sourceId = args["sourceId"] as! String
            config.sourceName = args["sourceName"] as! String
            config.action = ((args["action"] as! Int) == 0)
            config.channelId = args["channelId"] as! String
            config.sourceType = Int32(args["sourceType"] as! Int)
            config.timeLength = Int32(args["timeLength"] as! Int)
            let offTime = args["offTime"] as? String
            if offTime != nil {
                config.offtime = offTime!
            }
            let path = args["path"] as? String
            if path != nil {
                config.path = path!
            }
            let summary = args["summary"] as? String
            if summary != nil {
                config.summary = summary!
            }
            FCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "accessPage":
            let args = call.arguments as! [String: Any?]
            let config = FCDataStatisticsAccessPageEvent()
            config.sourceId = args["sourceId"] as! String
            config.sourceName = args["sourceName"] as! String
            config.userId = args["userId"] as! String
            config.action = ((args["action"] as! Int) == 0)
            config.timeLength = Int32(args["timeLength"] as! Int)
            config.isHome = (args["isHome"] as! Bool) ? 1 : 0
            config.operateType = Int32(args["operateType"] as! Int)
            config.sourceType = Int32(args["sourceType"] as! Int)
            config.sourcePage = args["sourcePage"] as! String
            config.pChannel = args["channelId"] as! String
            FCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "collect":
            let args = call.arguments as! [String: Any?]
            let config = FCDataStatisticsCollectEvent()
            config.sourceId = args["sourceId"] as! String
            config.sourceName = args["sourceName"] as! String
            config.userId = args["userId"] as! String
            config.operationType = args["operationType"] as! Bool
            config.sourceType = Int32(args["sourceType"] as! Int)
            FCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "comment":
            let args = call.arguments as! [String: Any?]
            let config = FCDataStatisticsCommentEvent()
            config.sourceId = args["sourceId"] as! String
            config.sourceName = args["sourceName"] as! String
            config.userId = args["userId"] as! String
            config.commentDetail = args["content"] as! String
            config.sourceType = Int32(args["sourceType"] as! Int)
            FCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "forward":
            let args = call.arguments as! [String: Any?]
            let config = FCDataStatisticsForwoardEvent()
            config.sourceId = args["sourceId"] as! String
            config.sourceName = args["sourceName"] as! String
            config.userId = args["userId"] as! String
            config.sourceType = Int32(args["sourceType"] as! Int)
            config.shareType = FCDataStatisticsForwoardType(rawValue: UInt(args["shareType"] as! Int))!
            FCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "thumbsUp":
            let args = call.arguments as! [String: Any?]
            let config = FCDataStatisticsThumbsUpEvent()
            config.sourceId = args["sourceId"] as! String
            config.sourceName = args["sourceName"] as! String
            config.userId = args["userId"] as! String
            config.operationType = args["operationType"] as! Bool
            config.sourceType = Int32(args["sourceType"] as! Int)
            FCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "livePlay":
            let args = call.arguments as! [String: Any?]
            let config = FCDataStatisticsLiveEvent()
            config.sourceId = args["sourceId"] as! String
            config.sourceName = args["sourceName"] as! String
            config.userId = args["userId"] as! String
            config.heartbeatLength = args["heartbeatLength"] as! Int
            config.liveType = args["liveType"] as! Int
            config.totalTime = Int32(args["totalTime"] as! Int)
            config.offtime = args["offTime"] as! Int
            FCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "search":
            let args = call.arguments as! [String: Any?]
            let config = FCDataStatisticsSearchEvent()
            config.content = args["content"] as! String
            config.userId = args["userId"] as! String
            FCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "videoPlay":
            let args = call.arguments as! [String: Any?]
            let config = FCDataStatisticsVedioEvent()
            config.sourceId = args["sourceId"] as! String
            config.sourceName = args["sourceName"] as! String
            config.userId = args["userId"] as! String
            config.contentLength = args["contentLength"] as! Int
            config.isComplete = args["isComplete"] as! Bool
            FCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "report":
            let args = call.arguments as! [String: Any?]
            let config = FCDataStatisticsReportEvent()
            config.sourceId = args["sourceId"] as! String
            config.sourceContent = args["sourceContent"] as! String
            config.userId = args["userId"] as! String
            config.blTitle = args["title"] as! String
            config.sourceType = args["sourceType"] as! Int
            FCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        channel.setMethodCallHandler(nil)
    }
}
