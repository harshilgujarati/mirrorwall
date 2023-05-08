import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/controllers/providers/internetcheak_provider.dart';
import 'package:provider/provider.dart';

class webpage extends StatefulWidget {
  const webpage({Key? key}) : super(key: key);

  @override
  State<webpage> createState() => _webpageState();
}

class _webpageState extends State<webpage> {
  //variables
  InAppWebViewController? webrefreshthase;
  String Linkofplateform = "";
  PullToRefreshController? refreshscreennuchakdu;
  String choosedOption = "first";
  TextEditingController FindController = TextEditingController();

  //initstate(aama chakda thi refresh thay tena mate shortcuts che je bije use kari sakiye....)
  @override
  void initState() {
    super.initState();
    Provider.of<InternetProvider>(context, listen: false)
        .checkInternetConnectvity();

    refreshscreennuchakdu = PullToRefreshController(
      options: PullToRefreshOptions(),
      onRefresh: () async {
        await webrefreshthase?.reload();
      },
    );
  }

  void showAlertDialog(String first) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text("Search Platefrom"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  title: Text("1.Google"),
                  value: "https://www.google.com/",
                  groupValue: Linkofplateform,
                  onChanged: (val) {
                    setState(() {
                      Linkofplateform = val!;
                    });
                    webrefreshthase!.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(Linkofplateform),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile(
                  title: Text("2.Yahoo"),
                  value: "https://www.yahoo.com/",
                  groupValue: Linkofplateform,
                  onChanged: (val) {
                    setState(() {
                      Linkofplateform = val!;
                    });
                    webrefreshthase!.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(Linkofplateform),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile(
                  title: Text("3.Bing"),
                  value: "https://www.bing.com/",
                  groupValue: Linkofplateform,
                  onChanged: (val) {
                    setState(() {
                      Linkofplateform = val!;
                    });
                    webrefreshthase!.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(Linkofplateform),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile(
                  title: Text("4.Duck Duck Go"),
                  value: "https://duckduckgo.com/",
                  groupValue: Linkofplateform,
                  onChanged: (val) {
                    setState(() {
                      Linkofplateform = val!;
                    });
                    webrefreshthase!.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(Linkofplateform),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void ListOfBooks(String choosedOption) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                        label: Text("Close"),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 530,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Name of platefrom"),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "My Browser",
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "first",
                child: Row(
                  children: [
                    const Icon(Icons.bookmark, color: Colors.black),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    const Text("Total BookMark"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "second",
                child: Row(
                  children: [
                    const Icon(Icons.screen_search_desktop_outlined,
                        color: Colors.black),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    const Text("Search Platefrom"),
                  ],
                ),
              ),
            ],
            onSelected: (choosedOption) {
              setState(() {
                choosedOption = choosedOption;
              });
              if (choosedOption == "first") {
                ListOfBooks(choosedOption);
              } else if (choosedOption == "second") {
                showAlertDialog(choosedOption);
              }
            },
          ),
        ],
      ),
      body: Container(
        height: height * 1,
        child: Column(
          children: [
            Container(
              height: height * 0.74,
              child: InAppWebView(
                pullToRefreshController: refreshscreennuchakdu,
                onWebViewCreated: (controller) {
                  webrefreshthase = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    webrefreshthase = controller;
                  });
                },
                onLoadStop: (controller, uri) async {
                  await refreshscreennuchakdu?.endRefreshing();
                },
                initialUrlRequest: URLRequest(url: Uri.parse(Linkofplateform)),
              ),
            ),
            SizedBox(
              height: height * 0.15,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(6),
                      child: TextField(
                        controller: FindController,
                        decoration: InputDecoration(
                          hintText: "Search or type of web address",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              String newsearch = FindController.text;
                              webrefreshthase?.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(
                                      "https://www.google.com/search?q=$newsearch"),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await webrefreshthase?.loadUrl(
                              urlRequest: URLRequest(
                                url: Uri.parse(Linkofplateform),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.bookmark_add_outlined,
                            size: 38,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (await webrefreshthase!.canGoBack()) {
                              await webrefreshthase?.goBack();
                            }
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_left_outlined,
                            size: 44,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await webrefreshthase?.reload();
                          },
                          icon: Icon(
                            Icons.refresh,
                            size: 38,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (await webrefreshthase!.canGoForward()) {
                              await webrefreshthase?.goForward();
                            }
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 44,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:mirror_wall/controllers/providers/internetcheak_provider.dart';
// import 'package:provider/provider.dart';
//
// class webpage extends StatefulWidget {
//   const webpage({Key? key}) : super(key: key);
//
//   @override
//   State<webpage> createState() => _webpageState();
// }
//
// class _webpageState extends State<webpage> {
//   InAppWebViewController? inAppWebViewController;
//   String Url = "";
//   String SelectedOption = "Option 1";
//
//   TextEditingController SearchController = TextEditingController();
//   PullToRefreshController? pullToRefreshController;
//
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<InternetProvider>(context, listen: false)
//         .checkInternetConnectvity();
//
//     pullToRefreshController = PullToRefreshController(
//       options: PullToRefreshOptions(),
//       onRefresh: () async {
//         await inAppWebViewController?.reload();
//       },
//     );
//   }
//
//   void showAlertDialog(String selectedOption) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) => AlertDialog(
//             title: const Text("Search Engine"),
//             content: Container(
//               height: 100,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   RadioListTile(
//                     title: const Text("Google"),
//                     value: "https://www.google.com/",
//                     groupValue: Url,
//                     onChanged: (value) {
//                       setState(() {
//                         Url = value!;
//                       });
//                       inAppWebViewController!.loadUrl(
//                         urlRequest: URLRequest(
//                           url: Uri.parse(Url),
//                         ),
//                       );
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   RadioListTile(
//                     title: const Text("Yahoo"),
//                     value: "https://www.yahoo.com/",
//                     groupValue: Url,
//                     onChanged: (value) {
//                       setState(() {
//                         Url = value!;
//                       });
//                       inAppWebViewController!.loadUrl(
//                         urlRequest: URLRequest(
//                           url: Uri.parse(Url),
//                         ),
//                       );
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   RadioListTile(
//                     title: const Text("Bing"),
//                     value: "https://www.bing.com/",
//                     groupValue: Url,
//                     onChanged: (value) {
//                       setState(() {
//                         Url = value!;
//                       });
//                       inAppWebViewController!
//                           .loadUrl(urlRequest: URLRequest(url: Uri.parse(Url)));
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   RadioListTile(
//                     title: const Text("Duck Duck Go"),
//                     value: "https://duckduckgo.com/",
//                     groupValue: Url,
//                     onChanged: (value) {
//                       setState(() {
//                         Url = value!;
//                       });
//                       inAppWebViewController!
//                           .loadUrl(urlRequest: URLRequest(url: Uri.parse(Url)));
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void bookmarklist(String selectedOption) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.7,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width * 1,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         border: const Border(
//                           bottom: BorderSide(
//                             color: Colors.black,
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                       child: TextButton.icon(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         icon: const Icon(
//                           Icons.close,
//                           color: Colors.black,
//                         ),
//                         label: const Text(
//                           "Dismiss",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 flex: 10,
//                 child: Column(
//                   children: [
//                     Text("Vivek Baraiya"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double h = size.height;
//     double w = size.width;
//
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//           appBar: AppBar(
//             title: const Text(
//               'My Browser',
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.white,
//             elevation: 0,
//             actions: [
//               PopupMenuButton(
//                 offset: const Offset(10, 60),
//                 shape: const OutlineInputBorder(),
//                 icon: const Icon(Icons.more_vert, color: Colors.black),
//                 itemBuilder: (context) => [
//                   PopupMenuItem(
//                     value: "Option 1",
//                     child: Row(
//                       children: [
//                         const Icon(Icons.bookmark_add_outlined,
//                             color: Colors.black),
//                         SizedBox(
//                           width: w * 0.04,
//                         ),
//                         const Text("All BookMark"),
//                       ],
//                     ),
//                   ),
//                   PopupMenuItem(
//                     value: "Option 2",
//                     child: Row(
//                       children: [
//                         const Icon(Icons.laptop, color: Colors.black),
//                         SizedBox(
//                           width: w * 0.04,
//                         ),
//                         const Text("Search Engine"),
//                       ],
//                     ),
//                   ),
//                 ],
//                 onSelected: (selectedOption) {
//                   setState(() {
//                     SelectedOption = selectedOption;
//                   });
//                   if (selectedOption == "Option 1") {
//                     bookmarklist(selectedOption);
//                   } else if (selectedOption == "Option 2") {
//                     showAlertDialog(selectedOption);
//                   }
//                 },
//               ),
//             ],
//           ),
//           body: Container(
//             height: h * 1,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     height: h * 0.74,
//                     child: InAppWebView(
//                       pullToRefreshController: pullToRefreshController,
//                       onWebViewCreated: (controller) {
//                         inAppWebViewController = controller;
//                       },
//                       onLoadStart: (controller, url) {
//                         setState(() {
//                           inAppWebViewController = controller;
//                         });
//                       },
//                       onLoadStop: (controller, url) async {
//                         await pullToRefreshController?.endRefreshing();
//                       },
//                       initialUrlRequest: URLRequest(url: Uri.parse(Url)),
//                     ),
//                   ),
//                   SizedBox(
//                     height: h * 0.15,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TextField(
//                               controller: SearchController,
//                               decoration: InputDecoration(
//                                 enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Colors.black,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 focusedBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Colors.black,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 border: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 suffixIcon: IconButton(
//                                   icon: const Icon(
//                                     Icons.search,
//                                     color: Colors.black,
//                                   ),
//                                   onPressed: () {
//                                     String newLink = SearchController.text;
//                                     inAppWebViewController?.loadUrl(
//                                       urlRequest: URLRequest(
//                                         url: Uri.parse(
//                                             "https://www.google.com/search?q=$newLink"),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               IconButton(
//                                 onPressed: () async {
//                                   await inAppWebViewController?.loadUrl(
//                                     urlRequest: URLRequest(
//                                       url: Uri.parse(Url),
//                                     ),
//                                   );
//                                 },
//                                 icon: const Icon(Icons.home, size: 35),
//                               ),
//                               IconButton(
//                                 onPressed: () async {},
//                                 icon: const Icon(
//                                   Icons.bookmark_add_outlined,
//                                   size: 30,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () async {
//                                   if (await inAppWebViewController!
//                                       .canGoBack()) {
//                                     await inAppWebViewController?.goBack();
//                                   }
//                                 },
//                                 icon: const Icon(
//                                   Icons.keyboard_arrow_left_outlined,
//                                   size: 30,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () async {
//                                   await inAppWebViewController?.reload();
//                                 },
//                                 icon: const Icon(
//                                   Icons.refresh,
//                                   size: 30,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () async {
//                                   if (await inAppWebViewController!
//                                       .canGoForward()) {
//                                     await inAppWebViewController?.goForward();
//                                   }
//                                 },
//                                 icon: const Icon(
//                                   Icons.keyboard_arrow_right_outlined,
//                                   size: 30,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
