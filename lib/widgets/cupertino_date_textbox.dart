import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CupertinoDateTextBox extends StatefulWidget {
  const CupertinoDateTextBox({
    super.key,
    required this.initialValue,
    required this.onDateChange,
    required this.hintText,
    this.color = CupertinoColors.label,
    this.hintColor = CupertinoColors.inactiveGray,
    this.pickerBackgroundColor = CupertinoColors.systemBackground,
    this.fontSize = 17.0,
    this.textfieldPadding = 15.0,
    this.enabled = true,
  });

  final DateTime initialValue;
  final Function(DateTime) onDateChange;
  final String hintText;
  final Color color;
  final Color hintColor;
  final Color pickerBackgroundColor;
  final double fontSize;
  final double textfieldPadding;
  final bool enabled;

  @override
  _CupertinoDateTextBoxState createState() => _CupertinoDateTextBoxState();
}

class _CupertinoDateTextBoxState extends State<CupertinoDateTextBox> {
  final double _kPickerSheetHeight = 250.0;
  DateTime? _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialValue;
  }

  void callCallback() {
    widget.onDateChange(_currentDate!);
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: TextStyle(
          color: widget.color,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  void onSelectedDate(DateTime date) {
    setState(() {
      _currentDate = date;
    });
  }

  Widget _buildTextField(String hintText) {
    String fieldText;
    Color textColor;

    if (_currentDate != null) {
      final formatter = DateFormat.yMd().add_jm(); // Formato para fecha y hora
      fieldText = formatter.format(_currentDate!);
      textColor = widget.color;
    } else {
      fieldText = hintText;
      textColor = widget.hintColor;
    }

    return Flexible(
      child: GestureDetector(
        onTap: !widget.enabled
            ? null
            : () async {
                if (_currentDate == null) {
                  setState(() {
                    _currentDate = DateTime.now(); // Establece la fecha y hora actual si no hay valor
                  });
                }
                await showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildBottomPicker(CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime, // Cambiado a dateAndTime
                      backgroundColor: widget.pickerBackgroundColor,
                      initialDateTime: _currentDate,
                      onDateTimeChanged: (DateTime newDateTime) {
                        onSelectedDate(newDateTime);
                        callCallback();
                      },
                    ));
                  },
                );

                callCallback();
              },
        child: InputDecorator(
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: CupertinoColors.inactiveGray,
              fontSize: widget.fontSize,
            ),
            contentPadding: EdgeInsets.all(widget.textfieldPadding),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                color: CupertinoColors.inactiveGray,
                width: 0.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                color: CupertinoColors.inactiveGray,
                width: 0.0,
              ),
            ),
          ),
          child: Text(
            fieldText,
            style: TextStyle(
              color: textColor,
              fontSize: widget.fontSize,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildTextField(widget.hintText),
      ],
    );
  }
}