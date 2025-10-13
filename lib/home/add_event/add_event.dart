import 'package:events/firebase_utils.dart';
import 'package:events/home/add_event/widget/date_or_time_widget.dart';
import 'package:events/home/taps/home/widget/event_tab_item.dart';
import 'package:events/home/widget/custom_elevated_button.dart';
import 'package:events/home/widget/custom_text_form_field.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:events/model/event.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:events/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/event_list_provider.dart';

class AddEvent extends StatefulWidget {
  AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  String selectedEventName = '';
  String selectedEventImage = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  String formatDate = "";
  TimeOfDay? selectedTime;
  String formatTime = "";
  late EventListProvider eventListProvider;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workShop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    List<String> eventImagesList = [
      AppAsset.sportImage,
      AppAsset.birthDayImage,
      AppAsset.meetingImage,
      AppAsset.gamingImage,
      AppAsset.workshopImage,
      AppAsset.bookClubImage,
      AppAsset.exhibitionImage,
      AppAsset.holidayImage,
      AppAsset.eatingImage,
    ];
    selectedEventImage = eventImagesList[selectedIndex];
    selectedEventName = eventsNameList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyle.medium20Primary,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(selectedEventImage),
                ),
                SizedBox(
                  height: height * 0.07,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: EventTabItem(
                          selectedBgColor: AppColor.primaryLight,
                          unSelectedTextStyle: AppStyle.bold16Primary,
                          selectedTextStyle: Theme.of(
                            context,
                          ).textTheme.titleMedium!,
                          borderColor: AppColor.primaryLight,
                          isSelected: selectedIndex == index,
                          eventName: eventsNameList[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(width: width * 0.02),
                    itemCount: eventsNameList.length,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: height * 0.01),
                CustomTextFormField(
                  controller: titleController,
                  prefixIcon: Image.asset(
                    AppAsset.iconEdit,
                    color: Theme.of(context).indicatorColor,
                  ),
                  hintText: AppLocalizations.of(context)!.event_title,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please enter title";
                    }
                    return null;
                  },
                  hintTextStyle: Theme.of(context).textTheme.bodyLarge,
                  borderSideColor: Theme.of(context).splashColor,
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: height * 0.01),
                CustomTextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  hintText: AppLocalizations.of(context)!.event_description,
                  hintTextStyle: Theme.of(context).textTheme.bodyLarge,
                  validator: (description) {
                    if (description == null || description.trim().isEmpty) {
                      return "please enter description";
                    }
                    return null;
                  },
                  borderSideColor: Theme.of(context).splashColor,
                ),
                SizedBox(height: height * 0.02),
                DateOrTimeWidget(
                  iconName: AppAsset.iconDate,
                  eventDateOrTime: AppLocalizations.of(context)!.event_date,
                  onChooseEventDateOrTime: chooseDate,
                  chooseDateOrTime: selectedDate == null
                      ? AppLocalizations.of(context)!.choose_date
                      : formatDate,
                  // "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                ),
                SizedBox(height: height * 0.01),
                DateOrTimeWidget(
                  iconName: AppAsset.iconTime,
                  eventDateOrTime: AppLocalizations.of(context)!.event_time,
                  onChooseEventDateOrTime: chooseTime,
                  chooseDateOrTime: selectedTime == null
                      ? AppLocalizations.of(context)!.choose_time
                      : formatTime,
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.location,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: height * 0.01),
                CustomElevatedButton(
                  onPressed: () {
                    //todo: choose location
                  },
                  backgroundColor: AppColor.transparentColor,
                  borderColor: AppColor.primaryLight,
                  hasIcon: true,
                  childIconWidget: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.015,
                        ),
                        margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.primaryLight,
                        ),
                        child: Image.asset(
                          AppAsset.iconLocation,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.choose_event_location,
                        style: AppStyle.medium16Primary,
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: width * 0.02),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: width * 0.06,
                          color: AppColor.primaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                  onPressed: addEvent,
                  text: AppLocalizations.of(context)!.add_event,
                ),
                SizedBox(height: height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 356)),
    );
    selectedDate = chooseDate;
    if (selectedDate != null) {
      formatDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    }
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    if (selectedTime != null) {
      formatTime = selectedTime!.format(context);
    }
    setState(() {});
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      //todo: add event in firestore.
      Event event = Event(title: titleController.text,
        description: descriptionController.text,
        eventName: selectedEventName,
        eventDateTime: selectedDate!,
        eventImage: selectedEventImage,
        eventTime: formatTime,
      );
      FirebaseUtils.addEventToFireStore(event).timeout(Duration(seconds: 1),
          onTimeout: () {
            //todo: alert dialog - toast - snack bar
            ToastUtils.showToastMessage(
              message: 'Event Added Successfully',
              backgroundColor: AppColor.primaryLight,
              textColor: AppColor.whiteColor,
            );
            //todo: refresh list to get last event
            // eventListProvider.getAllEvents();
            Navigator.pop(context);
          }
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    eventListProvider.getAllEvents();
  }
}
