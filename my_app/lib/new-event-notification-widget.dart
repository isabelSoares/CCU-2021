import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/common/string-utils.dart';
import 'package:my_app/music-widget.dart';
import 'theme.dart';

final List<String> eventTypes = [
  "Orquestral",
  "Chamber",
  "Choral",
  "Cinema",
  "Contemporary",
  "Early and Barroque",
  "Jazz",
  "Opera",
  "Piano",
  "Voice",
  "Violin",
  "World Music"
];

final List<int> daysOptions = [1, 2, 7, 14, 30, 60];

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MusicWidget()));
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
  final databaseReference = FirebaseDatabase.instance.reference();

  String _type;
  int _days;

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
                                        initialValue: _days,
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

  void _onEventTypeChange(String value) {
    setState(() {
      _type = value;
    });
  }

  void _onEventTimeFrameChange(int value) {
    setState(() {
      _days = value;
    });
  }

  Widget _getEventTypeText() {
    if (_type == null) {
      return Text("Choose type of event",
          style: myThemeData.textTheme.bodyText1
              .merge(TextStyle(color: Color(0x36000000))));
    } else {
      return Text(_type, style: myThemeData.textTheme.bodyText1);
    }
  }

  Widget _getEventTimeFrameText() {
    if (_days == null) {
      return Text("Choose time frame",
          style: myThemeData.textTheme.bodyText1
              .merge(TextStyle(color: Color(0x36000000))));
    } else {
      return Text(getTimeFrameString(_days),
          style: myThemeData.textTheme.bodyText1);
    }
  }

  Widget _doneButton(BuildContext context) {
    return RaisedButton.icon(
      textColor: Colors.white,
      label: Text("DONE"),
      icon: Icon(Icons.check),
      onPressed: () {
        DatabaseReference itemRef =
            databaseReference.child("notifications/scheduled").push();
        itemRef.set({
          "type": "event",
          "name": _type,
          "days": _days,
        });
        Navigator.pop(context);
      },
    );
  }
}

class EventTypeDialog extends StatefulWidget {
  final String initialValue;
  final void Function(String) onValueChange;

  const EventTypeDialog({this.initialValue, this.onValueChange});

  State<StatefulWidget> createState() {
    return _EventTypeDialogState();
  }
}

class _EventTypeDialogState extends State<EventTypeDialog> {
  String _selectedType;

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

    eventTypes.forEach((element) {
      RadioListTile item = RadioListTile<String>(
        title: Text(element),
        value: element,
        groupValue: _selectedType,
        onChanged: (String value) {
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
  final int initialValue;
  final void Function(int) onValueChange;

  const EventTimeFrameDialog({this.initialValue, this.onValueChange});

  State<StatefulWidget> createState() {
    return _EventTimeFrameDialogState();
  }
}

class _EventTimeFrameDialogState extends State<EventTimeFrameDialog> {
  int _selectedDays;

  @override
  void initState() {
    super.initState();
    _selectedDays = widget.initialValue;
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

    daysOptions.forEach((element) {
      RadioListTile item = RadioListTile<int>(
        title: Text(getTimeFrameString(element)),
        value: element,
        groupValue: _selectedDays,
        onChanged: (int value) {
          setState(() {
            _selectedDays = value;
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
