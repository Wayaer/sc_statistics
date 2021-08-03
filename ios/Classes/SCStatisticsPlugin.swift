import Flutter
import SCDataStatisticsSDK
import UIKit

public class SCStatisticsPlugin: NSObject, FlutterPlugin {
    var channel: FlutterMethodChannel?

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
        print(call.arguments as Any)
        switch call.method {
        case "init":
            let arguments = call.arguments as! [String: Any?]
            let config = SCDataStatisticsLaunchConfig.init()
            config.appVersion = arguments["appVersion"] as! String
            config.areaId = arguments["areaId"] as! String
            config.deviceId = arguments["deviceId"] as! String
            config.ipAddress = arguments["ip"] as! String
            config.location = arguments["location"] as! String
            config.netType = arguments["netType"] as! String
            SCDataStatisticsService.shareInstance().setup(with: config)
            result(true)
        case "appStop":
            SCDataStatisticsService.shareInstance().addEventLog(SCDataStatisticsAppTerminateEvent())
            result(true)
        case "appLogin":
            SCDataStatisticsService.shareInstance().addLoginEventLog(call.arguments as! String)
            result(true)
        case "pageAction":
            let arguments = call.arguments as! [String: Any?]
            let config = SCDataStatisticsAccessPageEvent()
            config.sourceId = arguments["sourceId"] as! String
            config.sourceName = arguments["sourceName"] as! String
            config.userId = arguments["userId"] as! String
            config.isAccess = (arguments["action"] as! String) == "0"
            SCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "collect":
            let arguments = call.arguments as! [String: Any?]
            let config = SCDataStatisticsCollectEvent()
            config.sourceId = arguments["sourceId"] as! String
            config.sourceName = arguments["sourceName"] as! String
            config.userId = arguments["userId"] as! String
            config.sourceType = SCStatisticsCollectSourceType(rawValue: UInt(arguments["type"] as! Int))!
            SCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "comment":
            let arguments = call.arguments as! [String: Any?]
            let config = SCDataStatisticsCommentEvent()
            config.sourceId = arguments["sourceId"] as! String
            config.sourceName = arguments["sourceName"] as! String
            config.userId = arguments["userId"] as! String
            config.commentDetail = arguments["content"] as! String
            SCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "share":
            let arguments = call.arguments as! [String: Any?]
            let config = SCDataStatisticsForwoardEvent()
            config.sourceId = arguments["sourceId"] as! String
            config.sourceName = arguments["sourceName"] as! String
            config.userId = arguments["userId"] as! String
            config.shareType = SCStatisticsForwoardType(rawValue: UInt(arguments["shareType"] as! Int))!
            SCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "thumbsUp":
            let arguments = call.arguments as! [String: Any?]
            let config = SCDataStatisticsThumbsUpEvent()
            config.sourceId = arguments["sourceId"] as! String
            config.sourceName = arguments["sourceName"] as! String
            config.userId = arguments["userId"] as! String
            config.isLike = (arguments["isLike"] as! Int) == 1
            SCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "search":
            let arguments = call.arguments as! [String: Any?]
            let config = SCDataStatisticsSearchEvent()
            config.content = arguments["content"] as! String
            config.userId = arguments["userId"] as! String
            SCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "newsPlay":
            let arguments = call.arguments as! [String: Any?]
            let config = SCDataStatisticsVedioEvent()
            config.sourceId = arguments["sourceId"] as! String
            config.sourceName = arguments["sourceName"] as! String
            config.userId = arguments["userId"] as! String
            config.contentLength = arguments["contentLength"] as! Int
            config.isComplete = (arguments["isComplete"] as! Int) == 1
            SCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "tvPlay":
            result(true)
        case "livePlay":
            let arguments = call.arguments as! [String: Any?]
            let config = SCDataStatisticsLiveEvent()
            config.sourceId = arguments["sourceId"] as! String
            config.sourceName = arguments["sourceName"] as! String
            config.userId = arguments["userId"] as! String
            config.heartbeatLength = arguments["heartbeatLength"] as! Int
            SCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        case "report":
            let arguments = call.arguments as! [String: Any?]
            let config = SCDataStatisticsReportEvent()
            config.sourceId = arguments["sourceId"] as! String
            config.sourceContent = arguments["sourceName"] as! String
            config.userId = arguments["userId"] as! String
            SCDataStatisticsService.shareInstance().addEventLog(config)
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        channel?.setMethodCallHandler(nil)
    }
}
