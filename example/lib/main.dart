import 'package:flutter/material.dart';
import 'package:sc_statistics/sc_statistics.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
        appBar: AppBar(title: const Text('四川省平台信息集成模块')),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: HomePage(),
        ))),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '未初始化';
  SourceModel sourceModel =
      SourceModel(userId: '1000000', sourceId: '1111111', sourceName: '标题或内容');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(text),
          const SizedBox(width: double.infinity, height: 15),
          ElevatedText(
              onPressed: () async {
                final InitModel model = InitModel(
                    appVersion: '1.0.0',
                    areaId: '0100',
                    deviceId: '41fa37dd389a58c213d061db63b749a4ce9ca8f2',
                    ip: '1.1.1.1.1',
                    netType: NetType.wifi,
                    location: '成都市|武侯区');
                final bool data = await SCStatistics().init(model);
                text = 'init: $data';
                setState(() {});
              },
              text: '初始化'),
          Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                ElevatedText(
                    onPressed: () async {
                      final bool data = await SCStatistics().appLogin('userId');
                      text = 'appLogin: $data';
                      setState(() {});
                    },
                    text: 'appLogin'),
                ElevatedText(
                    onPressed: () async {
                      final bool data = await SCStatistics().appStop();
                      text = 'appStop: $data';
                      setState(() {});
                    },
                    text: 'appStop'),
                ElevatedText(
                    onPressed: () async {
                      final bool data = await SCStatistics()
                          .pageAction(sourceModel, PageAction.start);
                      text = 'pageAction - start: $data';
                      setState(() {});
                    },
                    text: 'pageAction - start'),
                ElevatedText(
                    onPressed: () async {
                      final bool data = await SCStatistics()
                          .pageAction(sourceModel, PageAction.end);
                      text = 'pageAction - end: $data';
                      setState(() {});
                    },
                    text: 'pageAction - end'),
                ElevatedText(
                    onPressed: () async {
                      final bool data = await SCStatistics()
                          .collect(sourceModel, CollectType.news);
                      text = 'collect: $data';
                      setState(() {});
                    },
                    text: 'collect'),
                ElevatedText(
                    onPressed: () async {
                      final bool data =
                          await SCStatistics().comment(sourceModel, 'content');
                      text = 'comment: $data';
                      setState(() {});
                    },
                    text: 'comment'),
                ElevatedText(
                    onPressed: () async {
                      final bool data =
                          await SCStatistics().share(sourceModel, ShareType.wx);
                      text = 'comment: $data';
                      setState(() {});
                    },
                    text: 'share'),
                ElevatedText(
                    onPressed: () async {
                      final bool data =
                          await SCStatistics().thumbsUp(sourceModel, true);
                      text = 'thumbsUp: $data';
                      setState(() {});
                    },
                    text: 'thumbsUp'),
                ElevatedText(
                    onPressed: () async {
                      final bool data = await SCStatistics()
                          .search(sourceModel.userId, sourceModel.sourceName);
                      text = 'search: $data';
                      setState(() {});
                    },
                    text: 'search'),
                ElevatedText(
                    onPressed: () async {
                      final bool data =
                          await SCStatistics().newsPlay(sourceModel, 60, false);
                      text = 'newsPlay: $data';
                      setState(() {});
                    },
                    text: 'newsPlay'),
                ElevatedText(
                    onPressed: () async {
                      final bool data =
                          await SCStatistics().tvPlay(sourceModel, 60);
                      text = 'tvPlay: $data';
                      setState(() {});
                    },
                    text: 'tvPlay'),
                ElevatedText(
                    onPressed: () async {
                      final bool data =
                          await SCStatistics().livePlay(sourceModel, 60);
                      text = 'livePlay: $data';
                      setState(() {});
                    },
                    text: 'livePlay'),
                ElevatedText(
                    onPressed: () async {
                      final bool data =
                          await SCStatistics().report(sourceModel);
                      text = 'report: $data';
                      setState(() {});
                    },
                    text: 'report'),
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
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
