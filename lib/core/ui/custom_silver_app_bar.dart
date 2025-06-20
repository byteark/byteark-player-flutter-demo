import 'package:demo_byteark_player_flutter_integration/core/theme/styles.dart';
import 'package:flutter/material.dart';

class CustomSilverAppBar extends StatelessWidget {
  final String title;
  final Widget background;

  const CustomSilverAppBar(
      {super.key, required this.title, required this.background});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Detect collapsed state
          final isCollapsed = constraints.maxHeight <=
              kToolbarHeight + MediaQuery.of(context).padding.top;

          return FlexibleSpaceBar(
            title: isCollapsed
                ? Text(
                    title,
                    style: Styles.header,
                  )
                : null, // Hide title when expanded
            background: background,
          );
        },
      ),
    );
  }
}
