import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WeebViewWidget extends StatefulWidget {
  final String url;
  final String title;

  const WeebViewWidget({required this.url, required this.title});

  @override
  WeebViewWidgetState createState() => WeebViewWidgetState();
}

class WeebViewWidgetState extends State<WeebViewWidget> {
  double _progress = 0;
  late InAppWebViewController webViewController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        key: scaffoldKey,
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0.5,
          ),
          body: Builder(builder: (_){
            if(widget.url.isEmpty){
              return Center(child: Text('Homepage is Empty'),);
            }
            return Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webViewController = controller;
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                ),
                _progress < 1 ? SizedBox(height: 3,
                  child: LinearProgressIndicator(
                    value: _progress,backgroundColor: Colors.blue.withOpacity(0.2),),) : SizedBox(),
              ],
            );
          })
      );
    });
  }
}
