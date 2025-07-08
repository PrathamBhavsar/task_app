import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/measurement/measurement_cubit.dart';
import '../../../blocs/measurement/measurement_state.dart';

class UnitSelector extends StatelessWidget {
  final int index;

  const UnitSelector({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementCubit, MeasurementState>(
      builder: (context, state) {
        final selectedUnit = state.unit;

        final units = ['m', 'in', 'sqft'];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Unit', style: AppTexts.labelTextStyle),
            10.hGap,
            IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: List.generate(units.length * 2 - 1, (i) {
                      if (i.isOdd) {
                        return Container(
                          width: 1,
                          height: double.infinity,
                          color: Colors.grey.shade400,
                        );
                      }

                      final unit = units[i ~/ 2];
                      final isSelected = selectedUnit == unit;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.read<MeasurementCubit>().updateUnit(unit);
                          },
                          child: Container(
                            color:
                                isSelected
                                    ? Colors.white
                                    : Colors.grey.shade300,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: Text(
                                unit,
                                style: TextStyle(
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            10.hGap,
          ],
        );
      },
    );
  }
}
