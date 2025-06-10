// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// import '../../../domain/entities/quote.dart';
// import '../../../utils/constants/app_constants.dart';
// import '../../../utils/extensions/padding.dart';
// import '../../providers/task_provider.dart';
// import '../../widgets/tab_header.dart';
// import 'widgets/quote_tile.dart';
//
// class QuotePage extends StatelessWidget {
//   const QuotePage({super.key});
//
//   @override
//   Widget build(BuildContext context) => Consumer<TaskProvider>(
//     builder:
//         (context, provider, child) => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Quotes', style: AppTexts.titleTextStyle),
//             TabHeader(
//               tabs: [
//                 Tab(text: 'Pending'),
//                 Tab(text: 'Approved'),
//                 Tab(text: 'Rejected'),
//               ],
//             ),
//             10.hGap,
//             Builder(
//               builder: (context) {
//                 switch (provider.tabIndex) {
//                   case 0:
//                     return _buildQuotes(Quote.pendingQuotes);
//                   case 1:
//                     return _buildQuotes(Quote.approvedQuotes);
//                   default:
//                     return _buildQuotes(Quote.rejectedQuotes);
//                 }
//               },
//             ),
//           ],
//         ),
//   );
//   Widget _buildQuotes(List<Quote> list) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       ...List.generate(
//         list.length,
//         (index) => Padding(
//           padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
//           child: QuoteTile(quote: list[index]),
//         ),
//       ),
//     ],
//   );
// }
