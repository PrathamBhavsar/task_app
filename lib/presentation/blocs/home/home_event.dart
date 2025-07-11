import 'package:flutter/foundation.dart';

import '../../../utils/enums/user_role.dart';

@immutable
abstract class HomeEvent {}

class SetBarIndexEvent extends HomeEvent {
  final int index;

  SetBarIndexEvent(this.index);
}
