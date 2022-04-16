import 'package:{{#snakeCase}}{{package-name}}{{/snakeCase}}/material.dart';
import 'package:{{#snakeCase}}{{package-name}}{{/snakeCase}}/layout/layout.dart';

enum ResponsiveLayoutSize { small, medium, large }

///Signature for the builders (`small`, `medium`, `large`)
typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

///[LayoutBuilder] wrapper, that exposes builders for multiple
///breakpoints
class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    Key? key,
    required this.small,
    required this.medium,
    required this.large,
    this.child,
  }) : super(key: key);

  final ResponsiveLayoutWidgetBuilder small;
  final ResponsiveLayoutWidgetBuilder medium;
  final ResponsiveLayoutWidgetBuilder large;

  /// Optional child widget builder based on the current layout size
  /// which will be passed to the `small`, `medium` and `large` builders
  /// as a way to share/optimize shared layout.
  final Widget Function(ResponsiveLayoutSize currentSize)? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;

        if (screenWidth <= Breakpoints.small) {
          return small(context, child?.call(ResponsiveLayoutSize.small));
        }
        if (screenWidth <= Breakpoints.medium) {
          return medium(context, child?.call(ResponsiveLayoutSize.medium));
        }
        if (screenWidth <= Breakpoints.large) {
          return large(context, child?.call(ResponsiveLayoutSize.large));
        }
        return large(context, child?.call(ResponsiveLayoutSize.large));
      },
    );
  }
}
