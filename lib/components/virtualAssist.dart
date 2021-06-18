import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:doctor/models/messageModel.dart';

class VirtualAssist extends StatefulWidget {
  @override
  _VirtualAssistState createState() => _VirtualAssistState();
}

class _VirtualAssistState extends State<VirtualAssist> {
  Icon _keyboardIcon = Icon(Icons.mic);
  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print('keyboard $visible');
        setState(() {
          _keyboardIcon = visible ? Icon(Icons.send) : Icon(Icons.mic);
        });
      },
    );
    super.initState();
  }

  _buildMessage(Message message) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      margin: message.isMe
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          )
        ],
        color: message.isMe ? Colors.green[50] : Colors.blue[50],
        borderRadius: message.isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: message.isMe
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.time,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  message.text,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.time,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  message.text,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );
  }

  final textFieldValueHolder = TextEditingController();
  String result = '';

  getTextInputData() {
    setState(() {
      result = textFieldValueHolder.text;
      message.add(Message(text: result, time: "6 AM", isMe: true));
      message.add(Message(text: "Ok", time: "10 AM", isMe: false));
      textFieldValueHolder.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              //alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 15.0),
                  itemCount: message.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (message.length == 0) {
                      return Text("Empty");
                    }
                    Message mes = message[index];
                    return _buildMessage(mes);
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            height: 70.0,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.0,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: TextField(
                      controller: textFieldValueHolder,
                      cursorColor: Colors.white,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {},
                      decoration: InputDecoration.collapsed(
                        hintText: 'Send a message...',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.blue,
                  icon: _keyboardIcon,
                  iconSize: 25.0,
                  onPressed: getTextInputData,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
