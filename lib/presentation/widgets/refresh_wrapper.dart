import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RefreshableStateWrapper<T> extends StatelessWidget {
  const RefreshableStateWrapper({
    required this.state,
    required this.fetchFunction,
    required this.itemBuilder,
    required this.extractItems,
    required this.isLoading,
    required this.isFailure,
    required this.getFailureMessage,
    this.emptyMessage = 'No data available',
    this.separatorBuilder,
    super.key,
  });

  final dynamic state;
  final Future<void> Function() fetchFunction;
  final Widget Function(BuildContext, T) itemBuilder;
  final List<T> Function(dynamic state) extractItems;
  final bool Function(dynamic state) isLoading;
  final bool Function(dynamic state) isFailure;
  final String Function(dynamic failureState) getFailureMessage;
  final String emptyMessage;
  final Widget Function(BuildContext, int)? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.black,
      backgroundColor: Colors.white,
      onRefresh: fetchFunction,
      child: Builder(
        builder: (context) {
          if (isLoading(state)) {
            return const _CenteredScrollWrapper(
              child: CircularProgressIndicator(),
            );
          }

          if (isFailure(state)) {
            final message = getFailureMessage(state);
            return _CenteredScrollWrapper(
              child: Text(message, textAlign: TextAlign.center),
            );
          }

          final List<T> items = extractItems(state);

          if (items.isEmpty) {
            return _CenteredScrollWrapper(child: Text(emptyMessage));
          }

          return ListView.separated(
            itemCount: items.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => itemBuilder(context, items[index]),
            separatorBuilder:
                separatorBuilder ??
                (context, index) => const SizedBox(height: 12),
          );
        },
      ),
    );
  }
}

class _CenteredScrollWrapper extends StatelessWidget {
  final Widget child;

  const _CenteredScrollWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 0.8.sh,
          child: Center(child: child),
        ),
      ],
    );
  }
}
