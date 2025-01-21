import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/quotation_provider.dart';
import 'package:task_app/widgets/custom_text_feild.dart';

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
    rateControllers.values.forEach((controller) => controller.dispose());
    materialControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBody: true,
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: ElevatedButton(
              onPressed: () {
                // Collecting updated rate and amount data
                Map<String, dynamic> updatedQuotation = {};
                final quotationProvider =
                    Provider.of<QuotationProvider>(context, listen: false);

                quotationProvider.roomDetails.forEach((roomName, windows) {
                  updatedQuotation[roomName] = {};
                  windows.forEach((windowName, windowDetails) {
                    double rate = double.tryParse(
                            rateControllers[windowName]?.text ?? '0') ??
                        0.0;
                    String material =
                        materialControllers[windowName]?.text ?? "";
                    double area =
                        double.tryParse(windowDetails['area'] ?? '0') ?? 0.0;
                    double amount = rate * area;

                    updatedQuotation[roomName]![windowName] = {
                      'height': windowDetails['height'],
                      'width': windowDetails['width'],
                      'area': windowDetails['area'],
                      'type': windowDetails['type'],
                      'remarks': windowDetails['remarks'],
                      'material': material,
                      'rate': rate.toString(),
                      'amount': amount.toStringAsFixed(2),
                    };
                  });
                });
                print(updatedQuotation);
              },
              child: const Text('Finish Quotation'),
            ),
          ),
        ],
        appBar: AppBar(
          title: Text(
            'Quotation',
            style: AppTexts.appBarStyle,
          ),
          actions: [
            Consumer<QuotationProvider>(
                builder: (context, quotationProvider, child) {
              return Text(
                QuotationProvider.instance.calculateTotalAmount().toString(),
                style: AppTexts.headingStyle,
              );
            })
          ],
        ),
        body: Consumer<QuotationProvider>(
          builder: (context, quotationProvider, child) {
            return Padding(
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
                        _buildDivider(),
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
                              text: rate.toString(),
                            ),
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
                                _buildDivider(
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
                                              hintTxt: 'Rate',
                                              onChangedFunc: (value) {
                                                double newRate =
                                                    double.tryParse(value) ??
                                                        0.0;
                                                quotationProvider.setRate(
                                                    roomName,
                                                    windowName,
                                                    newRate);
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
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDivider(
      {double verticalPadding = 0,
      double horizontalPadding = 0,
      Color color = AppColors.primary}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Divider(color: color),
    );
  }
}
