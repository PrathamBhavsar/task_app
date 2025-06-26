import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/message/message_bloc.dart';
import '../../../blocs/message/message_event.dart';
import '../../../blocs/message/message_state.dart';
import '../task_detail_page.dart';
import 'message_tile.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({required this.widget, super.key});

  final TaskDetailPage widget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is PutMessageSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<MessageBloc>().add(
              FetchMessagesRequested(widget.task.taskId!),
            );
          });
        }
      },
      builder: (BuildContext context, messageState) {
        if (messageState is MessageLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (messageState is MessageLoadFailure) {
          return const Center(
            child: Text('There was an issue loading messages!'),
          );
        }

        if (messageState is MessageLoadSuccess) {
          final messages = messageState.messages;

          if (messages.isEmpty) {
            return const Center(child: Text('There are no messages!'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task Messages', style: AppTexts.titleTextStyle),
              10.hGap,
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: messageState.messages.length,
                itemBuilder:
                    (context, index) =>
                        MessageTile(message: messageState.messages[index]),
                separatorBuilder: (context, index) => 10.hGap,
              ),
              const SizedBox(height: kBottomNavigationBarHeight + 10),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
