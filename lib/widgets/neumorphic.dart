import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../style.dart';

class NeumorphicWidget extends StatelessWidget {
  final Widget child;
  const NeumorphicWidget({this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
        usedTheme: UsedTheme.LIGHT,
        theme: NeumorphicThemeData(
          defaultTextColor: Style.textColor,
          baseColor: Style.bgColor,
          accentColor: Style.primaryColor,
          variantColor: Style.primaryColor,
          intensity: 0.8,
          lightSource: LightSource.topRight,
          depth: 6,
        ),
        darkTheme: NeumorphicThemeData(
          //TODO Add black theme
          baseColor: Color(0xFF3E3E3E),
          intensity: 0.5,
          lightSource: LightSource.topRight,
          depth: 6,
        ),
        child: child);
  }
}
