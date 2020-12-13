import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:date_format/date_format.dart';
import 'theme.dart';

class AddPlaceNotificationWidget extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    List<dynamic> places = [];

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
      body: StreamBuilder(
        stream: databaseReference.child("places/").onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            DataSnapshot dataValues = snapshot.data.snapshot;
            Map<dynamic, dynamic> values = dataValues.value;
            values.forEach((key, value) {
              if (key == "gardens") {
                Map<dynamic, dynamic>.from(value).forEach((key, value) {
                  places.add(value["name"]);
                });
              } else {
                places.add(value["type"]);
              }
            });

            List<Widget> listItems = [
              Container(
                padding: EdgeInsets.all(16),
                child: Text("Choose a place:",
                    style: myThemeData.textTheme.headline6),
              ),
            ];

            for (String item in places) {
              ListTile tile = ListTile(
                title: Text(item),
                trailing: Icon(Icons.chevron_right),
                enabled: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewPlaceNotificationWidget(item)));
                },
              );

              listItems.add(tile);
            }
            return ListView(children: listItems);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class NewPlaceNotificationWidget extends StatefulWidget {
  final String place;
  NewPlaceNotificationWidget(this.place);

  State<StatefulWidget> createState() {
    return _NewPlaceNotificationWidgetState();
  }
}

class _NewPlaceNotificationWidgetState
    extends State<NewPlaceNotificationWidget> {
  final databaseReference = FirebaseDatabase.instance.reference();

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
    // var manager = context.watch<NotificationManager>();

    return RaisedButton.icon(
      textColor: Colors.white,
      label: Text("DONE"),
      icon: Icon(Icons.check),
      onPressed: () {
        databaseReference
            .child("notifications/scheduled")
            .orderByChild("name")
            .equalTo(widget.place)
            .once()
            .then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> values = snapshot.value;

          if (values == null) {
            DatabaseReference itemRef =
                databaseReference.child("notifications/scheduled").push();
            itemRef.set({
              "type": "place",
              "name": widget.place,
              "from": {
                "hour": _selectedTimeFrom.hour,
                "minute": _selectedTimeFrom.minute
              },
              "to": {
                "hour": _selectedTimeTo.hour,
                "minute": _selectedTimeTo.minute
              },
              "capacity": _currentSliderValue.toInt()
            });
          } else {
            databaseReference
                .child(
                    "notifications/scheduled/" + values.keys.first.toString())
                .update({
              "type": "place",
              "name": widget.place,
              "from": {
                "hour": _selectedTimeFrom.hour,
                "minute": _selectedTimeFrom.minute
              },
              "to": {
                "hour": _selectedTimeTo.hour,
                "minute": _selectedTimeTo.minute
              },
              "capacity": _currentSliderValue.toInt()
            });
          }
        });

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
