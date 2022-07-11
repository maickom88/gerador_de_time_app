import 'package:flutter/material.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:micro_core/core/theme/theme.dart';

Future<T?> showAlert<T>(BuildContext context, String description) =>
    showAdaptiveActionSheet<T>(
      context: context,
      title: Text(
        description,
        textAlign: TextAlign.center,
      ),
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text('Sim, entendi',
              style: AppTypography.t14()
                  .copyWith(color: Colors.blue, fontWeight: FontWeight.bold)),
          onPressed: () {
            AppDefault.close(context);
          },
        ),
      ],
    );
