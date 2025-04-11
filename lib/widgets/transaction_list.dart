// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints){
              return Column(
                children: [
                  Text(
                    'No Transaction Added Yet ! ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height:constraints.maxHeight * 0.6 ,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                return Card(
                child: ListTile(
                leading: CircleAvatar(
                radius: 30,
                child: FittedBox(
                child : Text('\$${transactions[index].amount}'),
                ),
                ),
              title: Text(transactions[index].title,
              style : Theme.of(context).textTheme.titleMedium,
              ),
            subtitle: Text(DateFormat.yMMMEd().format(transactions[index].date)),
            trailing: IconButton(onPressed: ()=> deleteTx(transactions[index].id), icon: Icon(Icons.delete)),
                ),
            
                  );
                }));
  }
}
