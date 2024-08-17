import 'package:flutter/material.dart';

class AlternativeWidget extends StatelessWidget {
  final Widget child;
  final Function onRefresh;

  const AlternativeWidget(
      {super.key, required this.child, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Theme.of(context).primaryColor,
      onRefresh: () async {
        await onRefresh();
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [child],
              ),
            ),
          )
        ],
      ),
    );
  }
}
