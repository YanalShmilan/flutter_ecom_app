import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUi on AsyncValue {
  void showAlertDialogError(BuildContext context) {
          if (hasError && isRefreshing) {
        showExceptionAlertDialog(context: context,title: 'Erorr',exception: error);
      }

  }
}