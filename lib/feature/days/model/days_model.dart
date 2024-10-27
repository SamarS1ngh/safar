class Days {
  int tripId;
  int storyId;
  int dayId;
  List<ChatMsg> chatMsgs;
  Days(
      {required this.dayId,
      required this.chatMsgs,
      required this.storyId,
      required this.tripId});

  Map<String, dynamic> toJson() {
    return {
      "dayId": dayId,
      "chatMsgs": chatMsgs.map((msg) => msg.toJson()).toList(),
    };
  }

  factory Days.fromJson(Map<String, dynamic> json) {
    return Days(
        storyId: json["storyId"],
        tripId: json["tripId"],
        dayId: json["dayId"],
        chatMsgs: (json["chatMsgs"] as List)
            .map((msg) => ChatMsg.fromJson(msg as Map<String, dynamic>))
            .toList());
  }
}

class ChatMsg {
  bool isText;
  String content;
  DateTime timeStamp;

  ChatMsg(
      {required this.isText, required this.content, required this.timeStamp});

  Map<String, dynamic> toJson() {
    return {
      "isText": isText,
      "content": content,
      "timeStamp": timeStamp.millisecondsSinceEpoch,
    };
  }

  factory ChatMsg.fromJson(Map<String, dynamic> json) {
    return ChatMsg(
        isText: json["isText"],
        content: json["content"],
        timeStamp: DateTime.fromMillisecondsSinceEpoch(json["timeStamp"]));
  }
}
