import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:my_app/common/notification.dart';

import 'theme.dart';

class AddEventNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New event notification"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text("Notification for:",
                style: myThemeData.textTheme.headline6),
          ),
          ListTile(
            title: Text("Specific event"),
            trailing: Icon(Icons.chevron_right),
            enabled: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Type of event"),
            trailing: Icon(Icons.chevron_right),
            enabled: true,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewTypeEventNotificationWidget()));
            },
          ),
        ],
      ),
    );
  }
}

class NewTypeEventNotificationWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _NewTypeEventNotificationWidgetState();
  }
}

class _NewTypeEventNotificationWidgetState
    extends State<NewTypeEventNotificationWidget> {
  EventType _type;
  Duration _timeFrame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New event notification"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Events", style: myThemeData.textTheme.headline6),
            SizedBox(height: 16),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.music, color: myThemeData.primaryColor),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Type of event:",
                              style: myThemeData.textTheme.bodyText2),
                          FlatButton(
                            child: _getEventTypeText(),
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => EventTypeDialog(
                                        onValueChange: _onEventTypeChange,
                                        initialValue: _type,
                                      ));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.access_time, color: myThemeData.primaryColor),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Time frame:",
                              style: myThemeData.textTheme.bodyText2),
                          FlatButton(
                            child: _getEventTimeFrameText(),
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => EventTimeFrameDialog(
                                        onValueChange: _onEventTimeFrameChange,
                                        initialValue: _timeFrame,
                                      ));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: _doneButton(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onEventTypeChange(EventType value) {
    setState(() {
      _type = value;
    });
  }

  void _onEventTimeFrameChange(Duration value) {
    setState(() {
      _timeFrame = value;
    });
  }

  Widget _getEventTypeText() {
    if (_type == null) {
      return Text("Choose type of event",
          style: myThemeData.textTheme.bodyText1
              .merge(TextStyle(color: Color(0x36000000))));
    } else {
      return Text(getEventType(_type), style: myThemeData.textTheme.bodyText1);
    }
  }

  Widget _getEventTimeFrameText() {
    if (_timeFrame == null) {
      return Text("Choose time frame",
          style: myThemeData.textTheme.bodyText1
              .merge(TextStyle(color: Color(0x36000000))));
    } else {
      return Text(getTimeFrameString(_timeFrame),
          style: myThemeData.textTheme.bodyText1);
    }
  }

  Widget _doneButton(BuildContext context) {
    var manager = context.watch<NotificationManager>();

    return RaisedButton.icon(
      label: Text("DONE"),
      icon: Icon(Icons.check),
      onPressed: () {
        manager.add(NotificationEvent(
          getEventType(_type),
          _type,
          _timeFrame,
        ));
        Navigator.pop(context);
      },
    );
  }
}

class EventTypeDialog extends StatefulWidget {
  final EventType initialValue;
  final void Function(EventType) onValueChange;

  const EventTypeDialog({this.initialValue, this.onValueChange});

  State<StatefulWidget> createState() {
    return _EventTypeDialogState();
  }
}

class _EventTypeDialogState extends State<EventTypeDialog> {
  EventType _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: getRadioTypeList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getRadioTypeList() {
    List<Widget> radioItems = [];

    EventType.values.forEach((element) {
      RadioListTile item = RadioListTile<EventType>(
        title: Text(getEventType(element)),
        value: element,
        groupValue: _selectedType,
        onChanged: (EventType value) {
          setState(() {
            _selectedType = value;
            widget.onValueChange(value);
            Navigator.pop(context);
          });
        },
      );

      radioItems.add(item);
    });

    return radioItems;
  }
}

class EventTimeFrameDialog extends StatefulWidget {
  final Duration initialValue;
  final void Function(Duration) onValueChange;

  const EventTimeFrameDialog({this.initialValue, this.onValueChange});

  State<StatefulWidget> createState() {
    return _EventTimeFrameDialogState();
  }
}

class _EventTimeFrameDialogState extends State<EventTimeFrameDialog> {
  Duration _selectedTimeFrame;

  @override
  void initState() {
    super.initState();
    _selectedTimeFrame = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: getRadioTimeFrameList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getRadioTimeFrameList() {
    List<Widget> radioItems = [];

    timeFrameMap.keys.forEach((element) {
      RadioListTile item = RadioListTile<Duration>(
        title: Text(element),
        value: timeFrameMap[element],
        groupValue: _selectedTimeFrame,
        onChanged: (Duration value) {
          setState(() {
            _selectedTimeFrame = value;
            widget.onValueChange(value);
            Navigator.pop(context);
          });
        },
      );

      radioItems.add(item);
    });

    return radioItems;
  }
}
