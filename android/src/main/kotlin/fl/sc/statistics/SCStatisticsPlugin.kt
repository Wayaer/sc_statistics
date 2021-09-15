package fl.sc.statistics

import androidx.annotation.NonNull
import com.example.sdk.statisticssdk.StatisticsMainInit
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class SCStatisticsPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "sc_statistics")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        @NonNull call: MethodCall,
        @NonNull result: Result
    ) {
        when (call.method) {
            "init" -> {
                StatisticsMainInit.SDKInit(
                    call.argument("areaId"),
                    call.argument("deviceId"),
                    call.argument("appVersion"),
                    call.argument("ip"),
                    call.argument("netType")
                )
                result.success(
                    StatisticsMainInit.appStart(
                        call.argument("channelName"),
                        call.argument("address")
                    )
                )
            }
            "appStop" -> result.success(StatisticsMainInit.appStop())
            "appLogin" -> result.success(StatisticsMainInit.appLogin(call.arguments as String))
            "pageAction" -> {
                result.success(
                    StatisticsMainInit.newsInfoVisit(
                        call.argument("userId"),
                        call.argument("sourceId"),
                        call.argument("sourceName"),
                        call.argument("sourceTag"),
                        call.argument("action")
                    )
                )
            }
            "collect" -> {
                result.success(
                    StatisticsMainInit.newsInfoCollect(
                        call.argument("userId"),
                        call.argument("sourceId"),
                        call.argument("sourceName"),
                        call.argument("type")
                    )
                )
            }
            "comment" -> {
                result.success(
                    StatisticsMainInit.commentaryLog(
                        call.argument("userId"),
                        call.argument("sourceId"),
                        call.argument("sourceName"),
                        call.argument("content")
                    )
                )
            }
            "share" -> {
                result.success(
                    StatisticsMainInit.shareLog(
                        call.argument("userId"),
                        call.argument("sourceId"),
                        call.argument("sourceName"),
                        call.argument<Int>("shareType")!!
                    )
                )
            }
            "thumbsUp" -> {
                result.success(
                    StatisticsMainInit.thumbsUpLog(
                        call.argument("userId"),
                        call.argument("sourceId"),
                        call.argument("sourceName"),
                        call.argument<Int>("isLike")!!
                    )
                )
            }
            "search" -> {
                result.success(
                    StatisticsMainInit.searchLog(
                        call.argument("userId"),
                        call.argument("content"),
                    )
                )
            }
            "newsPlay" -> {
                result.success(
                    StatisticsMainInit.newsVideoPlay(
                        call.argument("userId"),
                        call.argument("sourceId"),
                        call.argument("sourceName"),
                        call.argument<Int>("contentLength")!!,
                        call.argument<Int>("isComplete")!!,
                    )
                )
            }
            "tvPlay" -> {
                result.success(
                    StatisticsMainInit.tvPlay(
                        call.argument("userId"),
                        call.argument("sourceId"),
                        call.argument("sourceName"),
                        call.argument<Int>("heartbeatLength")!!,
                    )
                )
            }
            "livePlay" -> {
                result.success(
                    StatisticsMainInit.livePlay(
                        call.argument("userId"),
                        call.argument("sourceId"),
                        call.argument("sourceName"),
                        call.argument<Int>("heartbeatLength")!!,
                    )
                )
            }
            "report" -> {
                result.success(
                    StatisticsMainInit.reportLog(
                        call.argument("userId"),
                        call.argument("sourceId"),
                        call.argument("sourceName"),
                    )
                )
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
