import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/quotation_provider.dart';
import 'package:task_app/views/task/widgets/quotation/room_quote.dart';

class QuotationWidget extends StatelessWidget {
  const QuotationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuotationProvider>(
      builder:
          (BuildContext context, QuotationProvider provider, Widget? child) {
        final List<Map<String, dynamic>> rooms = provider.roomDetails.entries
            .map((entry) {
              final roomName = entry.key;

              final List<Map<String, dynamic>> windows = entry.value.entries
                  .map((windowEntry) {
                    final windowName = windowEntry.key;
                    final windowData = windowEntry.value;

                    return {
                      'windowName': windowName,
                      'area': windowData['area'] ?? '',
                      'material': windowData['material'] ?? '',
                      'rate': windowData['rate'] ?? '0',
                      'amount': windowData['amount'] ?? '0',
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
              AppPaddings.gapH(10),
              provider.roomDetails.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      decoration: BoxDecoration(
                        color: AppColors.textFieldBg,
                        borderRadius: AppConsts.radius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: rooms.length,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> room = rooms[index];

                            return RoomQuote(
                              roomNames: room['roomName']!,
                              windowAreas: (room['windows'] as List<dynamic>)
                                  .map<String>((window) =>
                                      (window as Map<String, String>)['area']!)
                                  .toList(),
                              windowRates: (room['windows'] as List<dynamic>)
                                  .map<String>((window) =>
                                      (window as Map<String, String>)['rate']!)
                                  .toList(),
                              windowAmounts: (room['windows'] as List<dynamic>)
                                  .map<String>((window) => (window
                                      as Map<String, String>)['amount']!)
                                  .toList(),
                              windowNames: (room['windows'] as List<dynamic>?)
                                      ?.map<String>((window) => (window as Map<
                                          String, String>)['windowName']!)
                                      .toList() ??
                                  [],
                              windowMaterials: (room['windows']
                                          as List<dynamic>?)
                                      ?.map<String>((window) => (window
                                          as Map<String, String>)['material']!)
                                      .toList() ??
                                  [],
                              totalAmount: provider
                                  .calculateRoomTotal(room['roomName']!)
                                  .toString(),
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

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
      Amount: ${window['amount']}
      ''';
      }).join('\n');

      return '${room['roomName']}\n$windowsText';
    }).join('\n\n');

    final finalText =
        '$copyText\n\nTotal Amount: \₹ ${totalAmount.toStringAsFixed(2)}';

    Clipboard.setData(ClipboardData(text: finalText)).then((_) {
      Fluttertoast.showToast(msg: 'Copied to your clipboard!');
    });
  }
}
