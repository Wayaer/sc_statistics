import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sc_statistics/sc_statistics.dart';

bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;

bool get _isIOS => defaultTargetPlatform == TargetPlatform.iOS;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
        appBar: AppBar(title: const Text('四川省平台信息集成模块')),
        body: const SingleChildScrollView(
            child: Padding(padding: EdgeInsets.all(15.0), child: HomePage()))),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '未初始化';
  SCSourceModel source =
      SCSourceModel(userId: '100', sourceId: '1111111', sourceName: '标题');
  String appId = 'BED4765794421B7A6B623637F3881381';

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(text),
      const SizedBox(width: double.infinity, height: 15),
      ElevatedText(
          onPressed: () async {
            final SCInitialOptions model = SCInitialOptions(
                appVersion: '1.0.0',
                areaId: '0100',
                deviceId: '41fa37dd389a58c213d061db63b749a4ce9ca8f2',
                appId: appId,
                netType: NetType.wifi);
            final bool data = await SCStatistics().setup(model);
            text = 'setup: $data';
            setState(() {});
          },
          text: 'setup'),
      Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            ElevatedText(
                onPressed: () async {
                  final bool data = await SCStatistics().setNetType('5G');
                  text = 'setNetType: $data';
                  setState(() {});
                },
                text: 'setNetType'),
            ElevatedText(
                onPressed: () async {
                  final user = SCUserInfoModel(
                      appId: appId,
                      userCode: 'userCode',
                      userName: 'userName',
                      realName: 'realName',
                      status: 'status',
                      email: 'email',
                      tel: 'tel',
                      mobile: 'mobile',
                      headPic: 'headPic',
                      origin: 'origin',
                      sex: 1,
                      age: 25,
                      tag: 'tag',
                      other: 'other',
                      createTime: 'createTime',
                      extend: 'extend',
                      deleted: 'deleted');
                  final bool data = await SCStatistics().setUser(user);
                  text = 'setUser: $data';
                  setState(() {});
                },
                text: 'setUser'),
            ElevatedText(
                onPressed: () async {
                  final bool data = await SCStatistics().appStart('flutter');
                  text = 'appStart: $data';
                  setState(() {});
                },
                text: 'appStart'),
            ElevatedText(
                onPressed: () async {
                  final bool data = await SCStatistics()
                      .appStop(DateTime.now().millisecondsSinceEpoch, 1000);
                  text = 'appStop: $data';
                  setState(() {});
                },
                text: 'appStop'),
            ElevatedText(
                onPressed: () async {
                  final bool data =
                      await SCStatistics().login('100', LoginType.login);
                  text = 'login: $data';
                  setState(() {});
                },
                text: 'login'),
            ElevatedText(
                onPressed: () async {
                  final bool data =
                      await SCStatistics().accessSource(SCAccessSourceModel(
                    userId: source.userId,
                    sourceId: source.sourceId,
                    sourceName: source.sourceName,
                    action: AccessAction.entry,
                    channelId: 'channelId',
                    timeLength: 10000,
                    sourceType: SourceType.newsVideo,
                    offTime: DateTime.now().millisecondsSinceEpoch.toString(),
                    path: 'path',
                    summary: 'summary',
                    sourceTag: 'sourceTag',
                  ));
                  text = 'pageAction - end: $data';
                  setState(() {});
                },
                text: 'pageAction - end'),
            ElevatedText(
                onPressed: () async {
                  final bool data =
                      await SCStatistics().accessPage(SCAccessPageModel(
                    userId: source.userId,
                    sourceId: source.sourceId,
                    sourceName: source.sourceName,
                    sourceType: SourceType.newsVideo,
                    action: AccessAction.entry,
                    channelId: 'channelId',
                    timeLength: 10000,
                  ));
                  text = 'accessPage: $data';
                  setState(() {});
                },
                text: 'accessPage'),
            ElevatedText(
                onPressed: () async {
                  final bool data = await SCStatistics().collect(
                      source: source,
                      sourceType: SourceType.newsVideo,
                      isCollect: true);
                  text = 'collect: $data';
                  setState(() {});
                },
                text: 'collect'),
            ElevatedText(
                onPressed: () async {
                  final bool data = await SCStatistics().comment(
                    source: source,
                    content: 'content',
                    sourceType: SourceType.newsVideo,
                  );
                  text = 'comment: $data';
                  setState(() {});
                },
                text: 'comment'),
            ElevatedText(
                onPressed: () async {
                  final bool data = await SCStatistics().forward(
                    source: source,
                    shareType: ShareType.weiBo,
                    sourceType: SourceType.newsVideo,
                  );
                  text = 'forward: $data';
                  setState(() {});
                },
                text: 'forward'),
            ElevatedText(
                onPressed: () async {
                  final bool data = await SCStatistics().thumbsUp(
                    source: source,
                    isStar: true,
                    sourceType: SourceType.newsVideo,
                  );
                  text = 'thumbsUp: $data';
                  setState(() {});
                },
                text: 'thumbsUp'),
            ElevatedText(
                onPressed: () async {
                  final bool data = await SCStatistics()
                      .search(source.userId, source.sourceName);
                  text = 'search: $data';
                  setState(() {});
                },
                text: 'search'),
            ElevatedText(
                onPressed: () async {
                  final bool data = await SCStatistics().videoPlay(
                      source: source, contentLength: 60, isComplete: false);
                  text = 'videoPlay: $data';
                  setState(() {});
                },
                text: 'videoPlay'),
            ElevatedText(
                onPressed: () async {
                  final bool data = await SCStatistics().report(SCReportModel(
                      sourceContent: 'content',
                      title: 'title',
                      sourceType: SourceType.newsVideo,
                      userId: source.userId,
                      sourceId: source.sourceId));
                  text = 'report: $data';
                  setState(() {});
                },
                text: 'report'),
            if (_isAndroid)
              ElevatedText(
                  onPressed: () async {
                    final bool data = await SCStatistics().tvPlay(
                        source: source,
                        heartbeatLength: 60,
                        liveType: LiveType.normal);
                    text = 'tvPlay: $data';
                    setState(() {});
                  },
                  text: 'tvPlay'),
            if (_isIOS)
              ElevatedText(
                  onPressed: () async {
                    final bool data = await SCStatistics().appTerminate(
                        timeLength: 1000,
                        startTime: DateTime.now().millisecondsSinceEpoch);
                    text = 'appTerminate: $data';
                    setState(() {});
                  },
                  text: 'appTerminate'),
          ])
    ]);
  }
}

class ElevatedText extends StatelessWidget {
  const ElevatedText({Key? key, required this.onPressed, required this.text})
      : super(key: key);
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
