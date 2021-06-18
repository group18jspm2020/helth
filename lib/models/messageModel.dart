class Message {
  final String text;
  final bool isMe;
  final String time;

  Message({
    this.text,
    this.isMe,
    this.time,
  });
}

List<Message> message = [
  Message(text: "Hello", isMe: false, time: "8:30 AM"),
  Message(text: "I am Virtual Assistant", isMe: false, time: "8:30 AM"),
  Message(text: "How can I help you", isMe: false, time: "8:30 AM"),
];
