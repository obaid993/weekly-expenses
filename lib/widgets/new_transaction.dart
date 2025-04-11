// ignore_for_file: unused_import, unused_field, must_be_immutable, prefer_final_fields, unused_local_variable, unused_element, prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(1990),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        child: Container(
            padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment : CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: 'Title'),
                  onFieldSubmitted: (_) => _submitData(),
                ),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Amount',
                  ),
                  onFieldSubmitted: (_) => _submitData(),
                ),
                SizedBox(height: 3),
                Container(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(_selectedDate == null
                              ? 'No Date Choosen'
                              : 'Picked Date : ${DateFormat.yMd().format(_selectedDate!)}')),
                      ElevatedButton(
                          onPressed: _presentDatePicker,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitData,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // button's shape
                    ),
                  ),
                )
              ],
            ),),
          ),
      
      
    );
  }
}
