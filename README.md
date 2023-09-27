# 四川省平台信息集成模块（sc_statistics）

## 1.0.0

应省平台更新 变更比较大，请直接查看源码
此版本不再需要  `Android 配置项`，请移除 0.1.2 的配置项

## 0.1.2 版本

[四川省平台信息集成模块文档下载中心](http://training.sctvcloud.com)

### Android 配置项

复制 `example/android/scstatistics` 目录至 `your project/android/` 目录下，并在 `your project/android/settings.gradle` 中添加 `include ':scstatistics'`

* 不要修改目录名字

```groovy

include ':app'
/// 需要添加的
include ':scstatistics'

```

## ios 配置
添加一下内容到 `ios/Runner/Info.plist`，以解决依赖库里的http请求正常

```plist
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>appmsapiscxrspt.sctvcloud.com</key>
			<dict>
				<key>NSExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSExceptionMinimumTLSVersion</key>
				<string>TLSv1.2</string>
			</dict>
		</dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
```
