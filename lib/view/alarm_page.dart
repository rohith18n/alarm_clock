import 'package:alarm_clock/providers/alarm_provider.dart';
import 'package:alarm_clock/models/alarm_info.dart';
import 'package:alarm_clock/utils/theme_data.dart';
import 'package:alarm_clock/widgets/alarm_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Consumer<AlarmController>(
        builder: (context, alarmController, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Alarm',
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w700,
                    color: CustomColors.primaryTextColor,
                    fontSize: 24),
              ),
              Expanded(
                child: FutureBuilder<List<AlarmInfo>>(
                  future: alarmController.alarms,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      alarmController.currentAlarms = snapshot.data;
                      return ListView(
                        children: snapshot.data!.map<Widget>((alarm) {
                          var alarmTime = DateFormat('hh:mm aa')
                              .format(alarm.alarmDateTime!);
                          var gradientColor = GradientTemplate
                              .gradientTemplate[alarm.gradientColorIndex!]
                              .colors;
                          return AlarmCard(
                              title: alarm.title!,
                              alarmTime: alarmTime,
                              gradientColor: gradientColor,
                              onChanged: (bool value) {},
                              switchValue: true,
                              onDelete: () =>
                                  alarmController.deleteAlarm(alarm.id));
                        }).followedBy([
                          if (alarmController.currentAlarms!.length < 5)
                            DottedBorder(
                              strokeWidth: 2,
                              color: CustomColors.clockOutline,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(24),
                              dashPattern: const [5, 4],
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: CustomColors.clockBG,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24)),
                                ),
                                child: MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  onPressed: () {
                                    alarmController.alarmTimeString =
                                        DateFormat('HH:mm')
                                            .format(DateTime.now());
                                    showModalBottomSheet(
                                      useRootNavigator: true,
                                      context: context,
                                      clipBehavior: Clip.antiAlias,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24),
                                        ),
                                      ),
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setModalState) {
                                            return Container(
                                              padding: const EdgeInsets.all(32),
                                              child: Column(
                                                children: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      var selectedTime =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                      );
                                                      if (selectedTime !=
                                                          null) {
                                                        final now =
                                                            DateTime.now();
                                                        var selectedDateTime =
                                                            DateTime(
                                                                now.year,
                                                                now.month,
                                                                now.day,
                                                                selectedTime
                                                                    .hour,
                                                                selectedTime
                                                                    .minute);
                                                        alarmController
                                                                .alarmTime =
                                                            selectedDateTime;
                                                        setModalState(() {
                                                          alarmController
                                                                  .alarmTimeString =
                                                              DateFormat(
                                                                      'HH:mm')
                                                                  .format(
                                                                      selectedDateTime);
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      alarmController
                                                          .alarmTimeString,
                                                      style: const TextStyle(
                                                          fontSize: 32),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: const Text('Repeat'),
                                                    trailing: Switch(
                                                      onChanged: (value) {
                                                        setModalState(() {
                                                          alarmController
                                                              .updateIsRepeatSelected(
                                                                  value);
                                                        });
                                                      },
                                                      value: alarmController
                                                          .isRepeatSelected,
                                                    ),
                                                  ),
                                                  const ListTile(
                                                    title: Text('Sound'),
                                                    trailing: Icon(Icons
                                                        .arrow_forward_ios),
                                                  ),
                                                  const ListTile(
                                                    title: Text('Title'),
                                                    trailing: Icon(Icons
                                                        .arrow_forward_ios),
                                                  ),
                                                  FloatingActionButton.extended(
                                                    onPressed: () {
                                                      alarmController.onSaveAlarm(
                                                          alarmController
                                                              .isRepeatSelected,
                                                          context);
                                                    },
                                                    icon:
                                                        const Icon(Icons.alarm),
                                                    label: const Text('Save'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                    // scheduleAlarm();
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/add_alarm.png',
                                        scale: 1.5,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Add Alarm',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'avenir'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            const Center(
                                child: Text(
                              'Only 5 alarms allowed!',
                              style: TextStyle(color: Colors.white),
                            )),
                        ]).toList(),
                      );
                    }
                    return const Center(
                      child: Text(
                        'Loading..',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
