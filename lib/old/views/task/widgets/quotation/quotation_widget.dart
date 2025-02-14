import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_consts.dart';
import '../../../../providers/quotation_provider.dart';
import '../../../../extensions/app_paddings.dart';
import '../../../../helpers/indian_number_system_helper.dart';
import 'room_quote.dart';

class QuotationWidget extends StatelessWidget {
  const QuotationWidget({super.key});

  @override
  Widget build(BuildContext context) => Consumer<QuotationProvider>(
        builder:
            (BuildContext context, QuotationProvider provider, Widget? child) {
          final List<Map<String, dynamic>> rooms =
              provider.quotationDetails.entries
                  .map((entry) {
                    final roomName = entry.key;

                    final List<Map<String, dynamic>> windows =
                        entry.value.entries
                            .map((windowEntry) {
                              final windowName = windowEntry.key;
                              final windowData = windowEntry.value;

                              return {
                                'windowName': windowName,
                                'area': windowData['area'] ?? '',
                                'material': windowData['material'] ?? '',
                                'type': windowData['type'] ?? '',
                                'rate': windowData['rate'] ?? '0',
                                'amount': windowData['amount'] ?? '0',
                                'remarks': windowData['remarks'] ?? '',
                              };
                            })
                            .where((window) => window != null)
                            .cast<Map<String, dynamic>>()
                            .toList();

                    if (windows.isEmpty) {
                      return null;
                    }

                    return {'roomName': roomName, 'windows': windows};
                  })
                  .where((room) => room != null)
                  .cast<Map<String, dynamic>>()
                  .toList();
          double totalAmount = provider.calculateTotalAmount();
          return Padding(
            padding: AppPaddings.appPadding,
            child: Column(
              children: [
                InkWell(
                  onTap: () => context.pushNamed('quotation'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quotation', style: AppTexts.headingStyle),
                      Row(
                        children: [
                          provider.roomDetails.isEmpty
                              ? const SizedBox.shrink()
                              : IconButton(
                                  onPressed: () {
                                    _copyToClipboard(context, rooms);
                                  },
                                  icon: const Icon(Icons.copy_rounded),
                                ),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
                10.hGap,
                provider.roomDetails.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                        decoration: BoxDecoration(
                          color: AppColors.textFieldBg,
                          borderRadius: AppBorders.radius,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: rooms.length,
                                itemBuilder: (context, index) {
                                  final Map<String, dynamic> room =
                                      rooms[index];

                                  return RoomQuote(
                                    roomNames: room['roomName']!,
                                    windowTypes: (room['windows']
                                            as List<dynamic>)
                                        .map<String>((window) =>
                                            (window['type'] ?? '').toString())
                                        .toList(),
                                    windowRemarks:
                                        (room['windows'] as List<dynamic>)
                                            .map<String>((window) =>
                                                (window['remarks'] ?? '')
                                                    .toString())
                                            .toList(),
                                    windowAreas: (room['windows']
                                            as List<dynamic>)
                                        .map<String>((window) =>
                                            (window['area'] ?? '').toString())
                                        .toList(),
                                    windowRates: (room['windows']
                                            as List<dynamic>)
                                        .map<String>((window) =>
                                            (window['rate'] ?? '').toString())
                                        .toList(),
                                    windowAmounts: (room['windows']
                                            as List<dynamic>)
                                        .map<String>((window) =>
                                            (window['amount'] ?? '').toString())
                                        .toList(),
                                    windowNames:
                                        (room['windows'] as List<dynamic>)
                                            .map<String>((window) =>
                                                (window['windowName'] ?? '')
                                                    .toString())
                                            .toList(),
                                    windowMaterials:
                                        (room['windows'] as List<dynamic>)
                                            .map<String>((window) =>
                                                (window['material'] ?? '')
                                                    .toString())
                                            .toList(),
                                  );
                                },
                              ),
                              10.hGap,
                              totalAmount == 0.0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total',
                                          style: AppTexts.tileTitle1,
                                        ),
                                        Text(
                                          totalAmount.toString(),
                                          style: AppTexts.tileTitle1,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      );

  void _copyToClipboard(
      BuildContext context, List<Map<String, dynamic>> rooms) {
    double totalAmount = 0;

    final copyText = rooms.map((room) {
      final windowsText =
          (room['windows'] as List<Map<String, dynamic>>).map((window) {
        totalAmount += double.tryParse(window['amount'] ?? '0') ?? 0;
        return '''  ${window['windowName']}  Area: ${window['area']}
       
      Material: ${window['material']}
      Rate: ${window['rate']}
      Amount: ${window['amount']}''';
      }).join('\n');

      return '${room['roomName']}\n$windowsText';
    }).join('\n\n');

    final finalText =
        '$copyText\n\nTotal Amount: ₹ ${IndianNumberHelper.format(totalAmount)}';

    Clipboard.setData(ClipboardData(text: finalText)).then((_) {
      Fluttertoast.showToast(msg: 'Copied to your clipboard!');
    });
  }
}
