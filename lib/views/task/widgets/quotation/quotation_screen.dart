import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_colors.dart';
import '../../../../providers/quotation_provider.dart';
import '../../../../widgets/custom_text_field.dart';

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({super.key});

  @override
  _QuotationScreenState createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  final Map<String, TextEditingController> rateControllers = {};
  final Map<String, TextEditingController> materialControllers = {};

  @override
  void dispose() {
    for (var controller in rateControllers.values) {
      controller.dispose();
    }
    for (var controller in materialControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text(
              'Quotation',
              style: AppTexts.appBarStyle,
            ),
            actions: [
              Consumer<QuotationProvider>(
                builder: (context, quotationProvider, child) => Row(
                  children: [
                    Text(
                      quotationProvider.calculateTotalAmount().toString(),
                      style: AppTexts.headingStyle,
                    ),
                    IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        Map<String, Map<String, Map<String, dynamic>>>
                            updatedQuotation = {};

                        quotationProvider.roomDetails
                            .forEach((roomName, windows) {
                          updatedQuotation[roomName] = {};
                          windows.forEach((windowName, windowDetails) {
                            double rate = double.tryParse(
                                    rateControllers[windowName]?.text ?? '0') ??
                                0.0;
                            String material =
                                materialControllers[windowName]?.text ?? "";
                            double area =
                                double.tryParse(windowDetails['area'] ?? '0') ??
                                    0.0;
                            double amount = rate * area;

                            updatedQuotation[roomName]![windowName] = {
                              'material': material,
                              'rate': rate,
                              'amount': amount.toStringAsFixed(2),
                              'area': windowDetails['area'],
                              'type': windowDetails['type'],
                              'remarks': windowDetails['remarks'],
                            };
                          });
                        });

                        quotationProvider.saveAllQuotations(updatedQuotation);
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Quotation details saved successfully!'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Consumer<QuotationProvider>(
            builder: (context, quotationProvider, child) => Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: quotationProvider.roomDetails.keys.length,
                itemBuilder: (context, roomIndex) {
                  String roomName =
                      quotationProvider.roomDetails.keys.elementAt(roomIndex);
                  final windows = quotationProvider.roomDetails[roomName]!;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roomName,
                          style: AppTexts.tileHeading,
                        ),
                        AppConsts.buildDivider(),
                        ...windows.keys.map((windowName) {
                          double rate =
                              quotationProvider.getRate(roomName, windowName);
                          String material = quotationProvider.getMaterial(
                              roomName, windowName);
                          double area = double.tryParse(
                                  quotationProvider.roomDetails[roomName]
                                          ?[windowName]?['area'] ??
                                      '0') ??
                              0;
                          double amount = area * rate;

                          rateControllers.putIfAbsent(
                            windowName,
                            () => TextEditingController(
                                text: rate == 0.0 ? "" : rate.toString()),
                          );
                          materialControllers.putIfAbsent(
                            windowName,
                            () => TextEditingController(text: material),
                          );

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    windowName,
                                    style: AppTexts.tileTitle2,
                                  ),
                                  Text(
                                    'Area: $area',
                                    style: AppTexts.tileTitle2,
                                  ),
                                ],
                              ),
                              children: [
                                AppConsts.buildDivider(
                                  horizontalPadding: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Material',
                                              style: AppTexts.tileSubtitle,
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomTextField(
                                              controller: materialControllers[
                                                  windowName],
                                              hintTxt: 'Material',
                                            ),
                                          ),
                                        ],
                                      ),
                                      AppPaddings.gapH(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Rate',
                                              style: AppTexts.tileSubtitle,
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomTextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller:
                                                  rateControllers[windowName],
                                              hintTxt: '0.0',
                                              onChangedFunc: (value) {
                                                double newRate =
                                                    double.tryParse(value) ??
                                                        0.0;
                                                quotationProvider.setRate(
                                                  roomName,
                                                  windowName,
                                                  newRate,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      AppPaddings.gapH(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Amount',
                                              style: AppTexts.tileSubtitle,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              amount.toStringAsFixed(2),
                                              style: AppTexts.tileSubtitle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
}
