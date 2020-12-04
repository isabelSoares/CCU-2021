import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';
import 'package:my_app/common/notification.dart';

import 'theme.dart';

class AddPlaceNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New place notification"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(16),
          child:
              Text("Choose a place:", style: myThemeData.textTheme.headline6),
        ),
        ListTile(
          title: Text("Garden A"),
          trailing: Icon(Icons.chevron_right),
          enabled: true,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewPlaceNotificationWidget(place: "Garden A")));
          },
        ),
        ListTile(
          title: Text("Garden B"),
          trailing: Icon(Icons.chevron_right),
          enabled: true,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewPlaceNotificationWidget(place: "Garden B")));
          },
        ),
        ListTile(
          title: Text("Library"),
          trailing: Icon(Icons.chevron_right),
          enabled: true,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewPlaceNotificationWidget(place: "Library")));
          },
        ),
      ]),
    );
  }
}

class NewPlaceNotificationWidget extends StatefulWidget {
  final String place;
  const NewPlaceNotificationWidget({Key key, this.place}) : super(key: key);

  State<StatefulWidget> createState() {
    return _NewPlaceNotificationWidgetState();
  }
}

class _NewPlaceNotificationWidgetState
    extends State<NewPlaceNotificationWidget> {
  TimeOfDay _selectedTimeFrom = TimeOfDay(hour: 9, minute: 00);
  TimeOfDay _selectedTimeTo = TimeOfDay(hour: 18, minute: 00);

  TextEditingController _timeControllerFrom = TextEditingController();
  TextEditingController _timeControllerTo = TextEditingController();

  double _currentSliderValue = 50;

  Future<Null> _selectTimeFrom(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _selectedTimeFrom,
    );
    if (picked != null) {
      setState(() {
        _selectedTimeFrom = picked;
        String hour = _selectedTimeFrom.hour.toString();
        String minute = _selectedTimeFrom.minute.toString();
        String time = hour + ':' + minute;
        _timeControllerFrom.text = time;
        _timeControllerFrom.text = formatDate(
            DateTime(
                2019, 08, 1, _selectedTimeFrom.hour, _selectedTimeFrom.minute),
            [HH, ':', nn]).toString();
      });
    }
  }

  Future<Null> _selectTimeTo(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _selectedTimeTo,
    );
    if (picked != null) {
      setState(() {
        _selectedTimeTo = picked;
        String hour = _selectedTimeTo.hour.toString();
        String minute = _selectedTimeTo.minute.toString();
        String time = hour + ':' + minute;
        _timeControllerTo.text = time;
        _timeControllerTo.text = formatDate(
            DateTime(2019, 08, 1, _selectedTimeTo.hour, _selectedTimeTo.minute),
            [HH, ':', nn]).toString();
      });
    }
  }

  @override
  void initState() {
    _timeControllerFrom.text =
        formatDate(DateTime(2019, 08, 1, 9, 0), [HH, ':', nn]).toString();
    _timeControllerTo.text =
        formatDate(DateTime(2019, 08, 1, 18, 0), [HH, ':', nn]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New place notification"),
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
            Text(widget.place, style: myThemeData.textTheme.headline6),
            SizedBox(height: 16),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: [
                  SizedBox(height: 10),
                  Icon(Icons.access_time, color: myThemeData.primaryColor),
                ]),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("From:", style: myThemeData.textTheme.bodyText2),
                          timeWidgetFrom(context),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("To:", style: myThemeData.textTheme.bodyText2),
                          timeWidgetTo(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.people, color: myThemeData.primaryColor),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Capacity less than:",
                              style: myThemeData.textTheme.bodyText2),
                          Text(_currentSliderValue.round().toString() + " %",
                              style: myThemeData.textTheme.bodyText1),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    activeColor: myThemeData.primaryColor,
                    inactiveColor: myThemeData.accentColor,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: _doneButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _doneButton(BuildContext context) {
    var manager = context.watch<NotificationManager>();

    return RaisedButton.icon(
      label: Text("DONE"),
      icon: Icon(Icons.check),
      onPressed: () {
        manager.add(NotificationPlace(
          widget.place,
          _selectedTimeFrom,
          _selectedTimeTo,
          _currentSliderValue,
        ));
        Navigator.pop(context);
      },
    );
  }

  Widget timeWidgetFrom(BuildContext context) {
    return Row(children: [
      InkWell(
        onTap: () {
          _selectTimeFrom(context);
        },
        child: Container(
          width: 100,
          alignment: Alignment.topRight,
          child: TextFormField(
            textAlign: TextAlign.end,
            style: myThemeData.textTheme.bodyText1,
            enabled: false,
            keyboardType: TextInputType.text,
            controller: _timeControllerFrom,
            decoration: InputDecoration(
              disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.all(0),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget timeWidgetTo(BuildContext context) {
    return Row(children: [
      InkWell(
        onTap: () {
          _selectTimeTo(context);
        },
        child: Container(
          width: 100,
          alignment: Alignment.topRight,
          child: TextFormField(
            textAlign: TextAlign.end,
            style: myThemeData.textTheme.bodyText1,
            enabled: false,
            keyboardType: TextInputType.text,
            controller: _timeControllerTo,
            decoration: InputDecoration(
              disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.all(0),
            ),
          ),
        ),
      ),
    ]);
  }
}
