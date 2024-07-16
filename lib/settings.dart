import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _time = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 5.0,
        shadowColor: Colors.black12,
      ),
      body: Column(
        children: [
          Card(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Stack(alignment: Alignment.topRight, children: [
              Image.asset(
                imageState(_time),
                width: 300.0,
                height: 100.0,
                fit: BoxFit.none,
                scale: 2,
                alignment: Alignment.topRight,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/smiley-african-woman-wearing-traditional-accessories_23-2148747966.jpg?t=st=1720456091~exp=1720459691~hmac=2b5f7672d242541838504bf687b7568b097acf520add92dd9ad26c6b44467295&w=740')),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: Text(
                            '${quoteState(_time)} Liyora!',
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.teal),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.red.shade400,
                              textStyle: const TextStyle(fontSize: 12.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              padding: const EdgeInsets.only(
                                  left: 30.0,
                                  right: 30.0,
                                 ),
                            ),
                            child: const Text("Log out"),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                SizedBox(
                    height: 80.0,
                    child: ColoredBox(
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Save data to cloud',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.7,
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    'You can prevent data loss by syncing data to cloud',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w100,
                                        color: Colors.black54),
                                  ),
                                )
                              ],
                            ),
                            FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 12.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 5.0,
                                    bottom: 5.0),
                              ),
                              child: const Text("Sync now"),
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 1.0,
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _updateHour();
  }

  void _updateHour() {
    setState(() {
      _time = int.parse(DateFormat('kk').format(DateTime.now()).toString());
    });
  }

  String imageState(int state) {
    if (state >= 4 && state <= 11) {
      return 'lib/assets/images/weather_light.png';
    } else if (state >= 12 && state <= 18) {
      return 'lib/assets/images/weather_day.png';
    } else {
      return 'lib/assets/images/weather_dark.png';
    }
  }

  String quoteState(int state) {
    if (state >= 4 && state <= 11) {
      return 'Good morning';
    } else if (state >= 12 && state <= 18) {
      return 'Good afternoon';
    } else {
      return 'Good night';
    }
  }
}
