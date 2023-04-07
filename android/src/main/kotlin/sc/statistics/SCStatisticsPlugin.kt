package sc.statistics

import android.content.Context
import com.example.sdk2.statisticssdk.Statistics2MainInit
import com.sobey.tmkit.dev.track2.Tracker
import com.sobey.tmkit.dev.track2.model.UserInfo
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class SCStatisticsPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sc_statistics")
        context = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "setup" -> {
                Tracker.init(context, call.argument("appId"))
                Statistics2MainInit.SDKInit(
                    context,
                    call.argument("areaId"),
                    call.argument("appVersion"),
                    call.argument("netType"),
                    call.argument("channel"),
                )
                result.success(true)
            }
            "setNetType" -> {
                Statistics2MainInit.setNetType(call.arguments as String)
                result.success(true)
            }
            "setUser" -> {
                val user = UserInfo()
                user.appId = call.argument<String>("appId")!!
                user.userCode = call.argument<String>("userCode")!!
                user.userName = call.argument<String>("userName")!!
                user.realName = call.argument<String>("realName")!!
                user.status = call.argument<String>("status")!!
                user.email = call.argument<String>("email")!!
                user.tel = call.argument<String>("tel")!!
                user.mobile = call.argument<String>("mobile")!!
                user.headPic = call.argument<String>("headPic")!!
                user.origin = call.argument<String>("origin")!!
                user.deleted = call.argument<String>("deleted")!!
                user.extend = call.argument<String>("extend")!!
                user.tag = call.argument<String>("tag")!!
                user.otherJson = call.argument<String>("other")!!
                user.createTime = call.argument<String>("createTime")!!
                user.age = call.argument<Int>("age")!!
                user.sex = call.argument<Int>("sex")!!
                Tracker.getInstance().user = user
                result.success(true)
            }
            "appStart" -> result.success(Statistics2MainInit.appStart(call.arguments as String))
            "appStop" -> result.success(
                Statistics2MainInit.appStop(
                    call.argument<Int>("startTime")!!, call.argument<Int>("timeLength")!!
                )
            )
            "login" -> result.success(
                Statistics2MainInit.appLogin(
                    call.argument<String>("userId")!!, call.argument<Int>("operateType")!!
                )
            )
            "accessSource" -> result.success(
                Statistics2MainInit.newsInfoVisit(
                    call.argument("userId"),
                    call.argument("sourceId"),
                    call.argument("sourceName"),
                    call.argument("sourceTag"),
                    call.argument<Int>("action").toString(),
                    call.argument("channelId"),
                    call.argument("timeLength")!!,
                    call.argument<Int>("sourceType").toString(),
                    call.argument("offTime"),
                    call.argument("path"),
                    call.argument("summary"),
                )
            )
            "accessPage" -> result.success(
                Statistics2MainInit.pageInfoVisit(
                    call.argument("userId"),
                    call.argument("sourceId"),
                    call.argument("sourceName"),
                    call.argument("timeLength")!!,
                    call.argument("operateType")!!,
                    if (call.argument<Boolean>("isHome")!!) 1 else 0,
                    call.argument<Int>("action").toString(),
                    call.argument<Int>("sourceType").toString(),
                    call.argument("sourcePage"),
                    call.argument("channelId"),
                )
            )

            "collect" -> result.success(
                Statistics2MainInit.newsInfoCollect(
                    call.argument("userId"),
                    call.argument("sourceId"),
                    call.argument("sourceName"),
                    call.argument<Int>("sourceType").toString(),
                    call.argument("operationType")!!
                )
            )
            "comment" -> result.success(
                Statistics2MainInit.commentaryLog(
                    call.argument("userId"),
                    call.argument("sourceId"),
                    call.argument("sourceName"),
                    call.argument("content"),
                    call.argument<Int>("sourceType").toString()
                )
            )
            "forward" -> result.success(
                Statistics2MainInit.shareLog(
                    call.argument("userId"),
                    call.argument("sourceId"),
                    call.argument("sourceName"),
                    call.argument("shareType")!!,
                    call.argument<Int>("sourceType").toString()
                )
            )
            "thumbsUp" -> result.success(
                Statistics2MainInit.thumbsUpLog(
                    call.argument("userId"),
                    call.argument("sourceId"),
                    call.argument("sourceName"),
                    if (call.argument<Boolean>("operationType")!!) 1 else 2,
                    call.argument<Int>("sourceType").toString()
                )
            )
            "livePlay" -> result.success(
                Statistics2MainInit.livePlay(
                    call.argument("userId"),
                    call.argument("sourceId"),
                    call.argument("sourceName"),
                    call.argument("heartbeatLength")!!,
                    call.argument("liveType")!!,
                    call.argument("totalTime")!!,
                    call.argument<Int>("offTime").toString(),
                )
            )
            "search" -> result.success(
                Statistics2MainInit.searchLog(
                    call.argument("userId"), call.argument("content")
                )
            )
            "videoPlay" -> result.success(
                Statistics2MainInit.newsVideoPlay(
                    call.argument("userId"),
                    call.argument("sourceId"),
                    call.argument("sourceName"),
                    call.argument("contentLength")!!,
                    call.argument("isComplete")!!,
                )
            )
            "tvPlay" -> result.success(
                Statistics2MainInit.tvPlay(
                    call.argument("userId"),
                    call.argument("sourceId"),
                    call.argument("sourceName"),
                    call.argument<Int>("heartbeatLength")!!,
                    call.argument<Int>("liveType")!!,
                )
            )
            "report" -> result.success(
                Statistics2MainInit.reportLog(
                    call.argument("userId"),
                    call.argument("sourceId"),
                    call.argument("sourceContent"),
                    call.argument("title"),
                    call.argument<Int>("sourceType").toString(),
                )
            )
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
