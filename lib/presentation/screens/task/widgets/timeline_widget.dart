import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/timeline/timeline_bloc.dart';
import '../../../blocs/timeline/timeline_state.dart';
import 'timeline_tile.dart';

class TimeLineWidget extends StatelessWidget {
  const TimeLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      builder: (context, timelineState) {
        if (timelineState is TimelineLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (timelineState is TimelineLoadFailure) {
          return const Center(
            child: Text('There was an issue loading timelines!'),
          );
        }

        if (timelineState is TimelineLoadSuccess) {
          final timelines = timelineState.timelines;

          if (timelines.isEmpty) {
            return const Center(child: Text('There are no timelines!'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task Timeline', style: AppTexts.titleTextStyle),
              Text(
                'History of events for this task',
                style: AppTexts.inputHintTextStyle,
              ),
              10.hGap,
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: timelineState.timelines.length,
                itemBuilder:
                    (context, index) =>
                        TimelineTile(timeline: timelineState.timelines[index]),
                separatorBuilder: (context, index) => 20.hGap,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
