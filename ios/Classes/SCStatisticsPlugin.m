#import "SCStatisticsPlugin.h"
#import <SCDataStatisticsSDK/SCDataStatisticsSDK.h>

@implementation SCStatisticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
                                     methodChannelWithName:@"sc_statistics"
                                     binaryMessenger:[registrar messenger]];
    SCStatisticsPlugin *instance = [[SCStatisticsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"init"]) {
        SCDataStatisticsLaunchConfig *config = [SCDataStatisticsLaunchConfig new];
        config.appVersion = call.arguments[@"appVersion"];
        config.areaId = call.arguments[@"areaId"];
        config.deviceId = call.arguments[@"deviceId"];
        config.ipAddress = call.arguments[@"ip"];
        config.location = call.arguments[@"location"];
        config.netType = call.arguments[@"netType"];
        [[SCDataStatisticsService shareInstance] setupWithConfig:config];
        result(@(YES));
    } else {
        result(FlutterMethodNotImplemented);
    }
    
    
}

@end
