import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // VIDEO
  final String urlToStreamVideo = 'http://213.226.254.135:91/mjpg/video.mjpg';
  final VlcPlayerController controller = VlcPlayerController();
  final int playerWidth = 640;
  final int playerHeight = 360;

  // SOCKET
  WebSocketChannel _webSocketChannel;
  SocketResponse socketResponse = SocketResponse();

  List listChatPengirim = [];
  List listChatPesan = [];

  List listWatchingName = [];
  List listWatchingAva = [];

  bool playButton;

  @override
  void initState() {
    // _socket();
    _webSocketChannel =
        IOWebSocketChannel.connect("ws://103.29.214.110:8085?1&negara789");
    _webSocketChannel.stream.listen((response) {
      print(response);
      setState(() {
        SocketResponse socketData =
            SocketResponse.fromJson(jsonDecode(response));

        // chat, button, watch, message
        if (socketData.action == 'chat') {
          listChatPengirim.add(socketData.chat.from);
          listChatPesan.add(socketData.chat.msg);
        } else if (socketData.action == 'button') {
          playButton = socketData.button.play;
        } else if (socketData.action == 'watch') {
          listWatchingName.add(socketData.watch.name);
          listWatchingAva.add(socketData.watch.ava);
        } else if (socketData.action == 'message') {
          listChatPengirim.add(socketData.chat.from);
          listChatPesan.add(socketData.chat.msg);
        }
      });

      print("==============CHAT===================");
      print(listChatPengirim);
      print(listChatPesan);
      print("==============WATCHING===============");
      print(listWatchingName);
      print(listWatchingAva);
      print("==============BUTTOM=================");
      print(playButton);
      print("=====================================");
    });
    super.initState();
  }

  TextEditingController _textControllerChat = TextEditingController();

  _sendChat(text) {
    _webSocketChannel.sink.add('{"chat":{"room":1,"mssg":"' + text + '"}}');
    print("send chat : " + '{"chat":{"room":1,"mssg":"' + text + '"}}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text("Ceritanya ini app bar"),
          ),
        ),
        body: ListView(
          children: <Widget>[
            // VIDEO
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: VlcPlayer(
                defaultWidth: playerWidth,
                defaultHeight: playerHeight,
                url: urlToStreamVideo,
                controller: controller,
                placeholder: Center(child: CircularProgressIndicator()),
              ),
            ),

            // VIEWER
            Container(
              color: Colors.black87.withOpacity(0.2),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Ini Watching",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: listWatchingName == null
                                ? 0
                                : listWatchingName.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(listWatchingName[index]),
                                subtitle: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: CircleAvatar(
                                    child: Image.network(
                                      listWatchingAva[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // CHAT
            Container(
              color: Colors.red.withOpacity(0.2),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Ini Chat",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          reverse: true,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          // child: Center(
                          //   child: Text('a'),
                          itemCount: listChatPengirim == null
                              ? 0
                              : listChatPengirim.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(listChatPengirim[index]),
                              subtitle: Text(listChatPesan[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      color: Colors.white,
                      child: RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (event) {
                          print(event.data.logicalKey.keyId);
                          /* if (event.runtimeType == RawKeyDownEvent &&
                          (event.logicalKey.keyId == 54)) {Navigator.pop(context, this._textController.text);} */
                        },
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: 'Writer chat text here',
                          ),
                          cursorColor: Colors.red,
                          maxLines: 1,
                          controller: _textControllerChat,
                          onSubmitted: (_textControllerChat) {
                            _sendChat(_textControllerChat);
                          },
                        ),
                      ))
                ],
              ),
            ),

            // BUTTON
            Container(
              color: Colors.amber.withOpacity(0.2),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(
                child: playButton == false
                    ? Container(
                        child: Text(
                          'WAITING',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    : Row(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                //
                                Container(
                                  color: Colors.greenAccent,
                                  child: FlatButton(
                                    onPressed: () {
                                      print("atas");
                                    },
                                    child: Icon(
                                      Icons.arrow_upward,
                                      size: MediaQuery.of(context).size.height *
                                          0.07,
                                    ),
                                  ),
                                ),
                                //
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        color: Colors.greenAccent,
                                        child: FlatButton(
                                          onPressed: () {
                                            print("Kiri");
                                          },
                                          child: Icon(
                                            Icons.arrow_back,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        color: Colors.greenAccent,
                                        child: FlatButton(
                                          onPressed: () {
                                            print("kanan");
                                          },
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    color: Colors.greenAccent,
                                    child: FlatButton(
                                      onPressed: () {
                                        print("bawah");
                                      },
                                      child: Icon(
                                        Icons.arrow_downward,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.orangeAccent,
                            child: FlatButton(
                              onPressed: () {
                                print("CAPIT");
                              },
                              child: Icon(
                                Icons.swap_horizontal_circle,
                                size: MediaQuery.of(context).size.height * 0.15,
                                color: Colors.white,
                              ),
                            ),
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

class SocketResponse {
  String action;
  Chat chat;
  Button button;
  Watch watch;

  SocketResponse({
    this.action,
    this.chat,
    this.button,
    this.watch,
  });

  factory SocketResponse.fromJson(dynamic json) {
    return SocketResponse(
      action: json["action"],
      chat: Chat.fromJson(json["chat"]),
      button: Button.fromJson(json["button"]),
      watch: Watch.fromJson(json["watch"]),
    );
  }

  // @override
  // String toString() {
  //   return '{ ${this.chat}, ${this.from}, ${this.mssg} }';
  // }
}

class Chat {
  String from;
  String msg;

  Chat({
    this.from,
    this.msg,
  });

  factory Chat.fromJson(dynamic json) {
    return Chat(
      from: json["from"],
      msg: json["msg"],
    );
  }

  @override
  String toString() {
    return '{ ${this.from}, ${this.msg} }';
  }
}

class Button {
  bool play;

  Button({this.play});

  factory Button.fromJson(dynamic json) {
    return Button(
      play: json["play"],
    );
  }

  @override
  String toString() {
    return '{ ${this.play} }';
  }
}

class Watch {
  String name;
  String ava;

  Watch({
    this.name,
    this.ava,
  });

  factory Watch.fromJson(dynamic json) {
    return Watch(
      name: json["name"],
      ava: json["ava"],
    );
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.ava} }';
  }
}
