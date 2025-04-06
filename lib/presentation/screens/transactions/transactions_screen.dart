import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/transaction.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: Colors.black,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        'Add Transaction',
        style: AppTexts.labelTextStyle.copyWith(color: Colors.white),
      ),
      onPressed: () => context.pushNamed('newTransaction'),
    ),
    appBar: AppBar(
      title: Text('Transaction Management', style: AppTexts.titleTextStyle),
    ),
    body: SingleChildScrollView(
      child: _buildUI(context).padAll(AppPaddings.appPaddingInt),
    ),
  );

  Widget _buildUI(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Transaction List", style: AppTexts.titleTextStyle),
      5.hGap,
      Text("View all transactions", style: AppTexts.inputHintTextStyle),
      20.hGap,
      ...List.generate(
        Transaction.sampleTransactions.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Transaction.sampleTransactions[index].name,
                        style: AppTexts.headingTextStyle,
                      ),
                      Text(
                        Transaction.sampleTransactions[index].time,
                        style: AppTexts.inputHintTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "\$${Transaction.sampleTransactions[index].amount.toString()}.00",
                        style: AppTexts.headingTextStyle,
                      ),
                      Text(
                        Transaction.sampleTransactions[index].status,
                        style: AppTexts.inputHintTextStyle.copyWith(
                          color:
                              Transaction.sampleTransactions[index].status ==
                                      "Completed"
                                  ? AppColors.green
                                  : AppColors.errorRed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              10.hGap,
              index != Transaction.sampleTransactions.length - 1
                  ? Divider(color: AppColors.accent)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    ],
  );
}
