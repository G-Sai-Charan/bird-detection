// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WikipediaExplorer extends StatefulWidget {
//   const WikipediaExplorer({Key? key,required this.name}) : super(key: key);
//   final String name;
//   @override
//   WikiState createState() => WikiState();
// }
//
// class WikiState extends State<WikipediaExplorer> {
//   late WebViewController _controller;
//   late String something = 'https://en.wikipedia.org/wiki/' + widget.name;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Birds Information"),
//         ),
//         body: Center(
//           child: WebView(
//             initialUrl: something,
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController webViewController) {
//               _controller = webViewController;
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:bird_detection/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WikipediaExplorer extends StatefulWidget {


  const WikipediaExplorer({Key? key,required this.name,required this.email}) :super(key:key);
  final String name;
  final String email;
  @override
  _WikipediaExplorerState createState() => _WikipediaExplorerState();
}

class _WikipediaExplorerState extends State<WikipediaExplorer> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  //final Set<String> _favorites = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Explorer'),

          leading: GestureDetector(
            child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage(email:widget.email)),
              );
            } ,
          ) ,
        //This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          NavigationControls(_controller.future),
          //Menu(_controller.future, () => _favorites),
        ],
      ),
      body: WebView(
        initialUrl: 'https://en.wikipedia.org/wiki/${widget.name}',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      floatingActionButton: _bookmarkButton(),
    );
  }

  _bookmarkButton() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          // return FloatingActionButton(
          //   onPressed: () async {
          //     var url = await controller.data.currentUrl();
          //     _favorites.add(url);
          //     Scaffold.of(context).showSnackBar(
          //       SnackBar(content: Text('Saved $url for later reading.')),
          //     );
          //   },
          //   child: Icon(Icons.favorite),
          // );
        }
        return Container();
      },
    );
  }
}
class NavigationControls extends StatelessWidget {
  const NavigationControls(this._controller);
  final Future<WebViewController> _controller;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controller,
        builder: (context,snapshot) {
        final webIsReady = snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return webIsReady
       ? Row(
          children: [
            IconButton(
              onPressed: () async {
                final  bool goBack = await controller!.canGoBack();
                if(goBack)
                  {
                    await controller.goBack();
                  }
                else {
                  //prompt a msg
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Can\'t go back'))
                  );
                }
              },
              icon: Icon(Icons.arrow_back),
            ),
            IconButton(
              onPressed: () async {
                final  bool goForword = await controller!.canGoForward();
                if(goForword)
                {
                  await controller.goForward();
                }
                else {
                  //prompt a msg
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Can\'t go forword'))
                  );
                }
              },
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ): SizedBox();
    },
    );
  }
}

