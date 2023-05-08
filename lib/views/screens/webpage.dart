import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/controllers/providers/internetcheak_provider.dart';
import 'package:mirror_wall/utils/attributs.dart';
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
              Expanded(
                flex: 10,
                child: Container(
                  child: ListView.builder(
                    itemCount: Bookmark.length,
                    itemBuilder: (context, i) => ListTile(
                      title: Text("$name[i]"),
                      subtitle: Text("$Bookmark[i]"),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            Bookmark.remove(Bookmark[i]);
                            name.remove(name[i]);
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
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
      body: (Provider.of<InternetProvider>(context)
                  .connectivityModel
                  .InternetStatus ==
              "WAITING..")
          ? Center(
              child: Text(
                "Cheak Your internet.....",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Container(
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
                                  Icons.home,
                                  size: 38,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  setState(() {
                                    Bookmark.add(webrefreshthase?.getUrl());
                                    name.add(webrefreshthase?.getTitle());
                                  });
                                },
                                icon: Icon(
                                  Icons.bookmark_add_outlined,
                                  size: 38,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (await webrefreshthase!.canGoBack()) {
                                    setState(() {
                                      webrefreshthase?.goBack();
                                    });
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
