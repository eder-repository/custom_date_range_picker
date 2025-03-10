import 'dart:io';

import 'package:custom_date_range_picker/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// `CustomDateRangePicker({
///   Key? key,
///   this.initialStartDate,
///   this.initialEndDate,
///   required this.onApplyClick,
///   this.barrierDismissible = true,
///   required this.minimumDate,
///   required this.maximumDate,
///   required this.onCancelClick,
/// }`
class CustomDateRangePicker extends StatefulWidget {
  const CustomDateRangePicker(
      {Key? key,
      this.initialStartDate,
      this.initialEndDate,
      required this.onApplyClick,
      this.barrierDismissible = true,
      this.minimumDate,
      this.maximumDate,
      required this.onCancelClick,
      this.textFirts,
      this.textSecond,
      this.multiLanguage = false,
      this.textFirtsButton,
      this.textSecondsButton})
      : super(key: key);

  final DateTime? minimumDate;

  final DateTime? maximumDate;

  final bool barrierDismissible;

  final DateTime? initialStartDate;

  final DateTime? initialEndDate;

  final Function(DateTime, DateTime) onApplyClick;

  final Function() onCancelClick;

  final String? textFirts;

  final String? textSecond;

  final String? textFirtsButton;

  final String? textSecondsButton;

  final bool multiLanguage;

  @override
  CustomDateRangePickerState createState() => CustomDateRangePickerState();
}

class CustomDateRangePickerState extends State<CustomDateRangePicker>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  DateTime? startDate;

  DateTime? endDate;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (widget.barrierDismissible) {
              Navigator.pop(context);
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(4, 4),
                        blurRadius: 8.0),
                  ],
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget.textFirts ?? 'From',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  startDate != null
                                      ? DateFormat(
                                          'EEE, dd MMM',
                                          widget.multiLanguage
                                              ? Platform.localeName
                                                  .substring(0, 2)
                                              : null,
                                        ).format(startDate!)
                                      : '--/-- ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 74,
                            width: 1,
                            color: Theme.of(context).dividerColor,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget.textSecond ?? 'To',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  endDate != null
                                      ? DateFormat(
                                          'EEE, dd MMM',
                                          widget.multiLanguage
                                              ? Platform.localeName
                                                  .substring(0, 2)
                                              : null,
                                        ).format(endDate!)
                                      : '--/-- ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        height: 1,
                      ),
                      CustomCalendar(
                        minimumDate: widget.minimumDate,
                        maximumDate: widget.maximumDate,
                        initialEndDate: widget.initialEndDate,
                        initialStartDate: widget.initialStartDate,
                        multiLanguage: widget.multiLanguage,
                        startEndDateChange:
                            (DateTime startDateData, DateTime endDateData) {
                          setState(() {
                            startDate = startDateData;
                            endDate = endDateData;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16, top: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 8,
                                      offset: const Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(24.0)),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context).primaryColor),
                                    ),
                                    onPressed: () {
                                      try {
                                        widget.onCancelClick();
                                        Navigator.pop(context);
                                      } catch (_) {}
                                    },
                                    child: Center(
                                      child: Text(
                                        widget.textFirtsButton ?? 'Cancel',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 8,
                                      offset: const Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24.0)),
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      try {
                                        widget.onApplyClick(
                                            startDate!, endDate!);
                                        Navigator.pop(context);
                                      } catch (_) {}
                                    },
                                    child: Center(
                                      child: Text(
                                        widget.textSecondsButton ?? 'Apply',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// `showCustomDateRangePicker(
///   BuildContext context, {
///   required bool dismissible,
///   required DateTime minimumDate,
///   required DateTime maximumDate,
///   DateTime? startDate,
///   DateTime? endDate,
///   required Function(DateTime startDate, DateTime endDate) onApplyClick,
///   required Function() onCancelClick,
///   Color? backgroundColor,
///   Color? primaryColor,
///   String? fontFamily,
/// })`
void showCustomDateRangePicker(
  BuildContext context, {
  required bool dismissible,
  DateTime? minimumDate,
  DateTime? maximumDate,
  DateTime? startDate,
  DateTime? endDate,
  required Function(DateTime startDate, DateTime endDate) onApplyClick,
  required Function() onCancelClick,
  Color? backgroundColor,
  Color? primaryColor,
  String? fontFamily,
  String? textFirst,
  String? textSecond,
  String? textFirtsButton,
  String? textSecondsButton,
  bool multiLanguage = false,
}) {
  FocusScope.of(context).requestFocus(FocusNode());
  showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) => CustomDateRangePicker(
      barrierDismissible: true,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
      textFirts: textFirst,
      textSecond: textSecond,
      textFirtsButton: textFirtsButton,
      textSecondsButton: textSecondsButton,
      multiLanguage: multiLanguage,
      initialStartDate: startDate,
      initialEndDate: endDate,
      onApplyClick: onApplyClick,
      onCancelClick: onCancelClick,
    ),
  );
}
