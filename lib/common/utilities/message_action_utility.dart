enum MessageAction { none, getToCovidInfo }

class MessageActionUtility {
  static MessageAction getAction(int index) {
    switch (index) {
      case 1:
        return MessageAction.getToCovidInfo;
      default:
        return MessageAction.none;
    }
  }

  static MessageAction getActionByCode(String actionCode) {
    switch (actionCode) {
      case "0001":
        return MessageAction.getToCovidInfo;
      default:
        return MessageAction.none;
    }
  }
}
