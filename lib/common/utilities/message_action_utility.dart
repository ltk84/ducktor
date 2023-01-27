enum MessageAction {
  none,
  getToCovidInfo,
  askForPosition,
  getToMap,
  getToLocationSetting,
  openReminderSetting,
  getToNews,
  openNotiReminderList,
}

class MessageActionUtility {
  static MessageAction getAction(int? index) {
    switch (index) {
      case 1:
        return MessageAction.getToCovidInfo;
      case 2:
        return MessageAction.askForPosition;
      case 3:
        return MessageAction.getToMap;
      case 4:
        return MessageAction.getToLocationSetting;
      case 5:
        return MessageAction.openReminderSetting;
      case 6:
        return MessageAction.getToNews;
      case 7:
        return MessageAction.openNotiReminderList;
      default:
        return MessageAction.none;
    }
  }

  static MessageAction getActionByCode(String actionCode) {
    switch (actionCode) {
      case "0001":
        return MessageAction.getToCovidInfo;
      case "0002":
        return MessageAction.askForPosition;
      case "0003":
        return MessageAction.getToMap;
      case "0004":
        return MessageAction.getToLocationSetting;
      case "0005":
        return MessageAction.openReminderSetting;
      case "0006":
        return MessageAction.getToNews;
      case "0007":
        return MessageAction.openNotiReminderList;
      default:
        return MessageAction.none;
    }
  }
}
