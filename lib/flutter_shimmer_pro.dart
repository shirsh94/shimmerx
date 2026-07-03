///
/// A package provides an easy way to add shimmer effect to Flutter application
///

library flutter_shimmer_pro;

export 'skeleton_widgets.dart';

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///
/// An enum defines all supported directions of shimmer effect
///
/// * [ShimmerDirection.ltr] left to right direction
/// * [ShimmerDirection.rtl] right to left direction
/// * [ShimmerDirection.ttb] top to bottom direction
/// * [ShimmerDirection.btt] bottom to top direction
///
enum ShimmerDirection { ltr, rtl, ttb, btt }

///
/// An enum defines all supported animation styles of shimmer effect
///
/// * [ShimmerEffect.wave] Classic wave shimmer effect (default)
/// * [ShimmerEffect.pulse] Pulsing opacity effect
/// * [ShimmerEffect.glow] Glowing/blooming effect
/// * [ShimmerEffect.fade] Smooth fade in/out effect
/// * [ShimmerEffect.slide] Sliding highlight effect
/// * [ShimmerEffect.diagonal] Diagonal wave effect
/// * [ShimmerEffect.circular] Circular ripple effect
/// * [ShimmerEffect.radial] Radial gradient effect
/// * [ShimmerEffect.breathing] Breathing/scale effect
/// * [ShimmerEffect.aurora] Aurora borealis color shifting effect
///
enum ShimmerEffect {
  wave,
  pulse,
  glow,
  fade,
  slide,
  diagonal,
  circular,
  radial,
  breathing,
  aurora,
}

///
/// Defines the visual properties for shimmer effects in a theme.
///
/// Used by [ShimmerTheme] to configure the default appearance of shimmer
/// effects throughout the widget subtree.
///
@immutable
class ShimmerThemeData {
  /// The gradient for the shimmer effect.
  final Gradient gradient;

  /// The border radius for shimmer containers.
  final double radius;

  /// The duration of the shimmer animation.
  final Duration duration;

  /// The default animation effect to use.
  final ShimmerEffect effect;

  /// Creates a shimmer theme data.
  const ShimmerThemeData({
    Gradient? gradient,
    this.radius = 8.0,
    this.duration = const Duration(milliseconds: 1500),
    this.effect = ShimmerEffect.wave,
  }) : gradient = gradient ??
          const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xFFE0E0E0),
              Color(0xFFE0E0E0),
              Color(0xFFF5F5F5),
              Color(0xFFE0E0E0),
              Color(0xFFE0E0E0),
            ],
            stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
          );

  /// Creates a copy of this theme data with the given fields replaced.
  ShimmerThemeData copyWith({
    Gradient? gradient,
    double? radius,
    Duration? duration,
    ShimmerEffect? effect,
  }) {
    return ShimmerThemeData(
      gradient: gradient ?? this.gradient,
      radius: radius ?? this.radius,
      duration: duration ?? this.duration,
      effect: effect ?? this.effect,
    );
  }

  /// Linearly interpolate between two shimmer theme data objects.
  static ShimmerThemeData lerp(ShimmerThemeData a, ShimmerThemeData b, double t) {
    return ShimmerThemeData(
      gradient: t < 0.5 ? a.gradient : b.gradient,
      radius: lerpDouble(a.radius, b.radius, t)!,
      duration: lerpDuration(a.duration, b.duration, t),
      effect: t < 0.5 ? a.effect : b.effect,
    );
  }

  static Duration lerpDuration(Duration a, Duration b, double t) {
    return Duration(
      milliseconds: (lerpDouble(a.inMilliseconds.toDouble(), b.inMilliseconds.toDouble(), t) ?? 0).toInt(),
    );
  }

  static double? lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}

///
/// An inherited widget that defines the configuration of shimmer effects
/// in its widget subtree.
///
/// Values specified here are used as defaults for [Shimmer] widgets that
/// don't specify their own values.
///
class ShimmerTheme extends InheritedWidget {
  /// The shimmer theme data for this widget's descendants.
  final ShimmerThemeData data;

  /// Creates a shimmer theme that controls the shimmer effects of descendants.
  const ShimmerTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The shimmer theme data from the closest [ShimmerTheme] ancestor.
  ///
  /// If there is no [ShimmerTheme] ancestor, returns the default theme data.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// final theme = ShimmerTheme.of(context);
  /// ```
  static ShimmerThemeData of(BuildContext context) {
    final ShimmerTheme? theme = context.dependOnInheritedWidgetOfExactType<ShimmerTheme>();
    return theme?.data ?? const ShimmerThemeData();
  }

  /// The shimmer theme data from the closest [ShimmerTheme] ancestor.
  ///
  /// If there is no [ShimmerTheme] ancestor, returns null.
  ///
  /// This method is useful when you need to check if a theme is present
  /// without falling back to the default.
  static ShimmerThemeData? maybeOf(BuildContext context) {
    final ShimmerTheme? theme = context.dependOnInheritedWidgetOfExactType<ShimmerTheme>();
    return theme?.data;
  }

  @override
  bool updateShouldNotify(ShimmerTheme oldWidget) {
    return data != oldWidget.data;
  }
}

///
/// A controller for managing shimmer animation state.
///
/// Provides methods to control the shimmer animation including pause,
/// resume, stop, restart, and reverse.
///
class ShimmerController extends ChangeNotifier {
  AnimationController? _controller;
  bool _isPaused = false;
  bool _isReversed = false;

  /// The underlying animation controller.
  AnimationController? get controller => _controller;

  /// Whether the animation is currently paused.
  bool get isPaused => _isPaused;

  /// Whether the animation is currently reversed.
  bool get isReversed => _isReversed;

  /// Attaches this controller to an animation controller.
  void attach(AnimationController controller) {
    _controller = controller;
  }

  /// Detaches this controller from the animation controller.
  void detach() {
    _controller = null;
  }

  /// Pauses the shimmer animation.
  void pause() {
    if (_controller != null && _controller!.isAnimating) {
      _controller!.stop();
      _isPaused = true;
      notifyListeners();
    }
  }

  /// Resumes the shimmer animation from its current position.
  void resume() {
    if (_controller != null && _isPaused) {
      _controller!.forward(from: _controller!.value);
      _isPaused = false;
      notifyListeners();
    }
  }

  /// Stops the shimmer animation and resets to the beginning.
  void stop() {
    if (_controller != null) {
      _controller!.stop();
      _controller!.reset();
      _isPaused = false;
      notifyListeners();
    }
  }

  /// Restarts the shimmer animation from the beginning.
  void restart() {
    if (_controller != null) {
      _controller!.reset();
      _controller!.forward();
      _isPaused = false;
      notifyListeners();
    }
  }

  /// Reverses the shimmer animation direction.
  void reverse() {
    if (_controller != null) {
      if (_isReversed) {
        _controller!.forward();
      } else {
        _controller!.reverse();
      }
      _isReversed = !_isReversed;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }
}

///
/// Pre-configured shimmer presets for common platforms and use cases.
///
/// Provides ready-to-use shimmer configurations that match the visual style
/// of popular apps and platforms.
///
class ShimmerPreset {
  ShimmerPreset._();

  /// YouTube-style shimmer with red accents
  static ShimmerThemeData youtube() {
    return const ShimmerThemeData(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0xFF282828),
          Color(0xFF282828),
          Color(0xFF424242),
          Color(0xFF282828),
          Color(0xFF282828),
        ],
        stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
      ),
      radius: 12.0,
      duration: Duration(milliseconds: 1500),
      effect: ShimmerEffect.wave,
    );
  }

  /// Instagram-style shimmer with gradient colors
  static ShimmerThemeData instagram() {
    return const ShimmerThemeData(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0xFFE0E0E0),
          Color(0xFFE0E0E0),
          Color(0xFFF5F5F5),
          Color(0xFFE0E0E0),
          Color(0xFFE0E0E0),
        ],
        stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
      ),
      radius: 8.0,
      duration: Duration(milliseconds: 1200),
      effect: ShimmerEffect.aurora,
    );
  }

  /// Amazon-style shimmer with dark theme
  static ShimmerThemeData amazon() {
    return const ShimmerThemeData(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0xFF37475A),
          Color(0xFF37475A),
          Color(0xFF485769),
          Color(0xFF37475A),
          Color(0xFF37475A),
        ],
        stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
      ),
      radius: 4.0,
      duration: Duration(milliseconds: 1800),
      effect: ShimmerEffect.slide,
    );
  }

  /// Netflix-style shimmer with dark red accents
  static ShimmerThemeData netflix() {
    return const ShimmerThemeData(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0xFF221F1F),
          Color(0xFF221F1F),
          Color(0xFF404040),
          Color(0xFF221F1F),
          Color(0xFF221F1F),
        ],
        stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
      ),
      radius: 4.0,
      duration: Duration(milliseconds: 2000),
      effect: ShimmerEffect.fade,
    );
  }

  /// Spotify-style shimmer with green accents
  static ShimmerThemeData spotify() {
    return const ShimmerThemeData(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0xFF121212),
          Color(0xFF121212),
          Color(0xFF282828),
          Color(0xFF121212),
          Color(0xFF121212),
        ],
        stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
      ),
      radius: 8.0,
      duration: Duration(milliseconds: 1400),
      effect: ShimmerEffect.pulse,
    );
  }

  /// Chat-style shimmer for messaging apps
  static ShimmerThemeData chat() {
    return const ShimmerThemeData(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0xFFF0F0F0),
          Color(0xFFF0F0F0),
          Color(0xFFFFFFFF),
          Color(0xFFF0F0F0),
          Color(0xFFF0F0F0),
        ],
        stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
      ),
      radius: 16.0,
      duration: Duration(milliseconds: 1600),
      effect: ShimmerEffect.breathing,
    );
  }

  /// Settings-style shimmer for settings pages
  static ShimmerThemeData settings() {
    return const ShimmerThemeData(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0xFFF5F5F5),
          Color(0xFFF5F5F5),
          Color(0xFFFFFFFF),
          Color(0xFFF5F5F5),
          Color(0xFFF5F5F5),
        ],
        stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
      ),
      radius: 12.0,
      duration: Duration(milliseconds: 1500),
      effect: ShimmerEffect.wave,
    );
  }

  /// Dashboard-style shimmer for analytics dashboards
  static ShimmerThemeData dashboard() {
    return const ShimmerThemeData(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0xFFE8E8E8),
          Color(0xFFE8E8E8),
          Color(0xFFF8F8F8),
          Color(0xFFE8E8E8),
          Color(0xFFE8E8E8),
        ],
        stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
      ),
      radius: 8.0,
      duration: Duration(milliseconds: 2000),
      effect: ShimmerEffect.glow,
    );
  }
}

///
/// A widget renders shimmer effect over [child] widget tree.
///
/// [child] defines an area that shimmer effect blends on. You can build [child]
/// from whatever [Widget] you like but there're some notices in order to get
/// exact expected effect and get better rendering performance:
///
/// * Use static [Widget] (which is an instance of [StatelessWidget]).
/// * [Widget] should be a solid color element. Every colors you set on these
/// [Widget]s will be overridden by colors of [gradient].
/// * Shimmer effect only affects to opaque areas of [child], transparent areas
/// still stays transparent.
///
/// [period] controls the speed of shimmer effect. The default value is 1500
/// milliseconds.
///
/// [direction] controls the direction of shimmer effect. The default value
/// is [ShimmerDirection.ltr].
///
/// [gradient] controls colors of shimmer effect.
///
/// [loop] the number of animation loop, set value of `0` to make animation run
/// forever.
///
/// [enabled] controls if shimmer effect is active. When set to false the animation
/// is paused
///
///
/// ## Pro tips:
///
/// * [child] should be made of basic and simple [Widget]s, such as [Container],
/// [Row] and [Column], to avoid side effect.
///
/// * use one [Shimmer] to wrap list of [Widget]s instead of a list of many [Shimmer]s
///
@immutable
class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration period;
  final ShimmerDirection direction;
  final Gradient gradient;
  final int loop;
  final bool enabled;
  final ShimmerEffect effect;
  final ShimmerController? controller;

  const Shimmer({
    super.key,
    required this.child,
    required this.gradient,
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 1500),
    this.loop = 0,
    this.enabled = true,
    this.effect = ShimmerEffect.wave,
    this.controller,
  });

  ///
  /// Creates a shimmer widget that uses theme data for default values.
  ///
  /// If [gradient] is not provided, it will be taken from the closest
  /// [ShimmerTheme] ancestor.
  ///
  static Widget themed({
    Key? key,
    required Widget child,
    Gradient? gradient,
    ShimmerDirection? direction,
    Duration? period,
    int? loop,
    bool? enabled,
    ShimmerEffect? effect,
    ShimmerController? controller,
  }) {
    return _ThemedShimmer(
      key: key,
      child: child,
      gradient: gradient,
      direction: direction,
      period: period,
      loop: loop,
      enabled: enabled,
      effect: effect,
      controller: controller,
    );
  }

  ///
  /// A convenient constructor provides an easy and convenient way to create a
  /// [Shimmer] which [gradient] is [LinearGradient] made up of `baseColor` and
  /// `highlightColor`.
  ///
  Shimmer.fromColors({
    super.key,
    required this.child,
    required Color baseColor,
    required Color highlightColor,
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
    this.loop = 0,
    this.enabled = true,
    this.effect = ShimmerEffect.wave,
    this.controller,
  }) : gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        baseColor,
        baseColor,
        highlightColor,
        baseColor,
        baseColor
      ],
      stops: const <double>[
        0.0,
        0.35,
        0.5,
        0.65,
        1.0
      ]);

  @override
  _ShimmerState createState() => _ShimmerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Gradient>('gradient', gradient,
        defaultValue: null));
    properties.add(EnumProperty<ShimmerDirection>('direction', direction));
    properties.add(EnumProperty<ShimmerEffect>('effect', effect));
    properties.add(
        DiagnosticsProperty<Duration>('period', period, defaultValue: null));
    properties
        .add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: null));
    properties.add(DiagnosticsProperty<int>('loop', loop, defaultValue: 0));
  }
}

class _ThemedShimmer extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final ShimmerDirection? direction;
  final Duration? period;
  final int? loop;
  final bool? enabled;
  final ShimmerEffect? effect;
  final ShimmerController? controller;

  const _ThemedShimmer({
    super.key,
    required this.child,
    this.gradient,
    this.direction,
    this.period,
    this.loop,
    this.enabled,
    this.effect,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShimmerTheme.of(context);
    final effectiveGradient = gradient ?? theme.gradient;

    return Shimmer(
      gradient: effectiveGradient,
      direction: direction ?? ShimmerDirection.ltr,
      period: period ?? theme.duration,
      loop: loop ?? 0,
      enabled: enabled ?? true,
      effect: effect ?? theme.effect,
      controller: controller,
      child: child,
    );
  }
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.period)
      ..addStatusListener((AnimationStatus status) {
        if (status != AnimationStatus.completed) {
          return;
        }
        _count++;
        if (widget.loop <= 0) {
          _controller.repeat();
        } else if (_count < widget.loop) {
          _controller.forward(from: 0.0);
        }
      });
    if (widget.controller != null) {
      widget.controller!.attach(_controller);
    }
    if (widget.enabled) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.detach();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Shimmer oldWidget) {
    if (widget.enabled) {
      _controller.forward();
    } else {
      _controller.stop();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) => _Shimmer(
        child: child,
        direction: widget.direction,
        gradient: widget.gradient,
        percent: _controller.value,
        effect: widget.effect,
      ),
    );
  }
}

@immutable
class _Shimmer extends SingleChildRenderObjectWidget {
  final double percent;
  final ShimmerDirection direction;
  final Gradient gradient;
  final ShimmerEffect effect;

  const _Shimmer({
    Widget? child,
    required this.percent,
    required this.direction,
    required this.gradient,
    required this.effect,
  }) : super(child: child);

  @override
  _ShimmerFilter createRenderObject(BuildContext context) {
    return _ShimmerFilter(percent, direction, gradient, effect);
  }

  @override
  void updateRenderObject(BuildContext context, _ShimmerFilter shimmer) {
    shimmer.percent = percent;
    shimmer.gradient = gradient;
    shimmer.direction = direction;
    shimmer.effect = effect;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  ShimmerDirection _direction;
  Gradient _gradient;
  double _percent;
  ShimmerEffect _effect;

  _ShimmerFilter(this._percent, this._direction, this._gradient, this._effect);

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue == _percent) {
      return;
    }
    _percent = newValue;
    markNeedsPaint();
  }

  set gradient(Gradient newValue) {
    if (newValue == _gradient) {
      return;
    }
    _gradient = newValue;
    markNeedsPaint();
  }

  set direction(ShimmerDirection newDirection) {
    if (newDirection == _direction) {
      return;
    }
    _direction = newDirection;
    markNeedsLayout();
  }

  set effect(ShimmerEffect newEffect) {
    if (newEffect == _effect) {
      return;
    }
    _effect = newEffect;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      final double width = child!.size.width;
      final double height = child!.size.height;

      switch (_effect) {
        case ShimmerEffect.wave:
          _paintWave(context, offset, width, height);
          break;
        case ShimmerEffect.pulse:
          _paintPulse(context, offset, width, height);
          break;
        case ShimmerEffect.glow:
          _paintGlow(context, offset, width, height);
          break;
        case ShimmerEffect.fade:
          _paintFade(context, offset, width, height);
          break;
        case ShimmerEffect.slide:
          _paintSlide(context, offset, width, height);
          break;
        case ShimmerEffect.diagonal:
          _paintDiagonal(context, offset, width, height);
          break;
        case ShimmerEffect.circular:
          _paintCircular(context, offset, width, height);
          break;
        case ShimmerEffect.radial:
          _paintRadial(context, offset, width, height);
          break;
        case ShimmerEffect.breathing:
          _paintBreathing(context, offset, width, height);
          break;
        case ShimmerEffect.aurora:
          _paintAurora(context, offset, width, height);
          break;
      }
    } else {
      layer = null;
    }
  }

  void _paintWave(PaintingContext context, Offset offset, double width, double height) {
    Rect rect;
    double dx, dy;
    if (_direction == ShimmerDirection.rtl) {
      dx = _offset(width, -width, _percent);
      dy = 0.0;
      rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
    } else if (_direction == ShimmerDirection.ttb) {
      dx = 0.0;
      dy = _offset(-height, height, _percent);
      rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
    } else if (_direction == ShimmerDirection.btt) {
      dx = 0.0;
      dy = _offset(height, -height, _percent);
      rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
    } else {
      dx = _offset(-width, width, _percent);
      dy = 0.0;
      rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
    }
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = _gradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  void _paintPulse(PaintingContext context, Offset offset, double width, double height) {
    final double pulseValue = (math.sin(_percent * math.pi * 2) + 1) / 2;
    final Color pulseColor = Color.lerp(
      _gradient.colors.first,
      _gradient.colors.last,
      pulseValue,
    )!;
    final Gradient pulseGradient = LinearGradient(
      colors: [pulseColor, pulseColor],
      stops: const [0.0, 1.0],
    );
    final Rect rect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      width,
      height,
    );
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = pulseGradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  void _paintGlow(PaintingContext context, Offset offset, double width, double height) {
    final double glowValue = (math.sin(_percent * math.pi * 4) + 1) / 2;
    final Rect rect = Rect.fromLTWH(
      offset.dx - (width * glowValue * 0.5),
      offset.dy - (height * glowValue * 0.5),
      width * (1 + glowValue),
      height * (1 + glowValue),
    );
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = _gradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  void _paintFade(PaintingContext context, Offset offset, double width, double height) {
    final double fadeValue = (math.sin(_percent * math.pi * 2) + 1) / 2;
    final Color fadeColor = _gradient.colors.first.withOpacity(0.3 + fadeValue * 0.7);
    final Gradient fadeGradient = LinearGradient(
      colors: [fadeColor, fadeColor],
      stops: const [0.0, 1.0],
    );
    final Rect rect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      width,
      height,
    );
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = fadeGradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  void _paintSlide(PaintingContext context, Offset offset, double width, double height) {
    final double slideOffset = _percent * width * 2 - width;
    final Rect rect = Rect.fromLTWH(
      offset.dx + slideOffset,
      offset.dy,
      width * 3,
      height,
    );
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = _gradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  void _paintDiagonal(PaintingContext context, Offset offset, double width, double height) {
    final double diagonalOffset = _percent * (width + height);
    final Rect rect = Rect.fromLTWH(
      offset.dx - diagonalOffset,
      offset.dy - diagonalOffset,
      width + diagonalOffset * 2,
      height + diagonalOffset * 2,
    );
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = _gradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  void _paintCircular(PaintingContext context, Offset offset, double width, double height) {
    final double radius = _percent * math.max(width, height) * 0.8;
    final Rect rect = Rect.fromCircle(
      center: offset + Offset(width / 2, height / 2),
      radius: radius,
    );
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = _gradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  void _paintRadial(PaintingContext context, Offset offset, double width, double height) {
    final double radialValue = (math.sin(_percent * math.pi * 2) + 1) / 2;
    final Rect rect = Rect.fromLTWH(
      offset.dx - (width * radialValue * 0.5),
      offset.dy - (height * radialValue * 0.5),
      width * (1 + radialValue),
      height * (1 + radialValue),
    );
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = _gradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  void _paintBreathing(PaintingContext context, Offset offset, double width, double height) {
    final double breatheValue = (math.sin(_percent * math.pi * 2) + 1) / 2;
    final Color breatheColor1 = _gradient.colors.first.withOpacity(0.5 + breatheValue * 0.5);
    final Color breatheColor2 = _gradient.colors.last.withOpacity(0.5 + breatheValue * 0.5);
    final Gradient breatheGradient = LinearGradient(
      colors: [breatheColor1, breatheColor2],
      stops: const [0.0, 1.0],
    );
    final Rect rect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      width,
      height,
    );
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = breatheGradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  void _paintAurora(PaintingContext context, Offset offset, double width, double height) {
    final double auroraValue = _percent * math.pi * 2;
    final Color color1 = Color.lerp(
      _gradient.colors.first,
      _gradient.colors.last,
      (math.sin(auroraValue) + 1) / 2,
    )!;
    final Color color2 = Color.lerp(
      _gradient.colors.first,
      _gradient.colors.last,
      (math.cos(auroraValue) + 1) / 2,
    )!;
    final Gradient auroraGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [color1, color2, color1],
      stops: const [0.0, 0.5, 1.0],
    );
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = auroraGradient.createShader(offset & size)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }
}

///
/// Extension methods to apply shimmer without wrapping widgets.
///
/// ```dart
/// Container(height: 48, color: Colors.grey).shimmer();
/// Text('Loading').shimmer();
/// Card(child: ...).shimmer();
/// ```
///
extension ShimmerWidgetExtension on Widget {
  /// Wraps this widget with [Shimmer] using a default gradient.
  ///
  /// Uses a default light grey gradient suitable for skeleton loaders.
  Widget shimmer({
    Gradient? gradient,
    Duration period = const Duration(milliseconds: 1500),
    ShimmerDirection direction = ShimmerDirection.ltr,
    int loop = 0,
    bool enabled = true,
    ShimmerEffect effect = ShimmerEffect.wave,
    ShimmerController? controller,
  }) {
    return Shimmer(
      gradient: gradient ??
          const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xFFE0E0E0),
              Color(0xFFE0E0E0),
              Color(0xFFF5F5F5),
              Color(0xFFE0E0E0),
              Color(0xFFE0E0E0),
            ],
            stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
          ),
      period: period,
      direction: direction,
      loop: loop,
      enabled: enabled,
      effect: effect,
      controller: controller,
      child: this,
    );
  }

  /// Wraps this widget with [Shimmer] using theme data for defaults.
  ///
  /// Uses [ShimmerTheme] for default values if not explicitly provided.
  Widget shimmerThemed({
    Gradient? gradient,
    ShimmerDirection? direction,
    Duration? period,
    int? loop,
    bool? enabled,
    ShimmerEffect? effect,
    ShimmerController? controller,
  }) {
    return _ThemedShimmer(
      gradient: gradient,
      direction: direction,
      period: period,
      loop: loop,
      enabled: enabled,
      effect: effect,
      controller: controller,
      child: this,
    );
  }

  /// Wraps this widget with [Shimmer] using a custom [gradient].
  Widget shimmerWith({
    required Gradient gradient,
    Duration period = const Duration(milliseconds: 1500),
    ShimmerDirection direction = ShimmerDirection.ltr,
    int loop = 0,
    bool enabled = true,
    ShimmerEffect effect = ShimmerEffect.wave,
    ShimmerController? controller,
  }) {
    return Shimmer(
      gradient: gradient,
      period: period,
      direction: direction,
      loop: loop,
      enabled: enabled,
      effect: effect,
      controller: controller,
      child: this,
    );
  }
}
