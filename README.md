# Shimmerx

A powerful and flexible Flutter package for creating beautiful shimmer loading effects. Shimmerx provides multiple animation styles, gradient support, global theming, platform presets, and animation control.

## Features

- 🎨 **Multiple Animation Styles** - 10 unique shimmer effects (wave, pulse, glow, fade, slide, diagonal, circular, radial, breathing, aurora)
- 🌈 **Gradient Support** - Full support for LinearGradient, RadialGradient, SweepGradient, and custom gradients
- 🎭 **Global Theming** - Configure shimmer effects globally with ShimmerTheme
- 🧩 **Platform Presets** - Ready-to-use presets for YouTube, Instagram, Amazon, Netflix, Spotify, Chat, Settings, and Dashboard
- ⭐ **Animation Control** - Pause, resume, stop, restart, and reverse animations with ShimmerController
- 🔧 **Extension Methods** - Easy-to-use extension methods for quick implementation
- 📱 **Material 3 Ready** - Modern UI components with Material 3 design

## Why Shimmerx?

While there are other shimmer packages available, Shimmerx stands out with its comprehensive feature set and modern approach:

| Feature | Shimmerx | shimmer | shimmer_loading |
|---------|----------|---------|-----------------|
| **Animation Styles** | 10 unique effects | 1 basic effect | 1 basic effect |
| **Gradient Support** | Linear, Radial, Sweep, Custom | Only LinearGradient | Only LinearGradient |
| **Global Theming** | ✅ Full theme support | ❌ No theming | ❌ No theming |
| **Platform Presets** | ✅ 8 ready-to-use presets | ❌ No presets | ❌ No presets |
| **Animation Control** | ✅ Pause, resume, stop, restart, reverse | ❌ No control | ❌ No control |
| **Extension Methods** | ✅ shimmer(), shimmerThemed(), shimmerWith() | ❌ No extensions | ❌ No extensions |
| **Material 3** | ✅ Full support | ❌ Material 2 only | ❌ Material 2 only |
| **Custom Effects** | ✅ Wave, Pulse, Glow, Fade, Slide, Diagonal, Circular, Radial, Breathing, Aurora | ❌ Only wave | ❌ Only wave |

**Key Advantages:**
- **More Animation Options** - 10 different animation styles vs just 1 in other packages
- **Flexible Gradients** - Support for all gradient types (Linear, Radial, Sweep) not just Linear
- **Global Configuration** - Theme support for consistent shimmer across your app
- **Platform-Specific Presets** - Pre-configured styles matching popular apps
- **Animation Control** - Full control over animation lifecycle (pause, resume, stop, restart, reverse)
- **Modern Design** - Built with Material 3 in mind
- **Developer Experience** - Extension methods for quick implementation

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  shimmerx: ^0.0.1
```

## Getting Started

### Basic Usage

```dart
import 'package:shimmerx/shimmerx.dart';

// Simple shimmer with default gradient
Shimmer(
  child: Container(
    width: 200,
    height: 100,
    color: Colors.grey,
  ),
)

// With custom gradient
Shimmer(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFE0E0E0),
      Color(0xFFE0E0E0),
      Color(0xFFF5F5F5),
      Color(0xFFE0E0E0),
      Color(0xFFE0E0E0),
    ],
    stops: [0.0, 0.35, 0.5, 0.65, 1.0],
  ),
  child: YourWidget(),
)
```

### Extension Methods

```dart
// Using extension method
Container(height: 48, color: Colors.grey).shimmer()

// With custom gradient
Text('Loading').shimmer(
  gradient: LinearGradient(
    colors: [Colors.blue, Colors.lightBlue],
  ),
)
```

### Animation Styles

```dart
Shimmer(
  effect: ShimmerEffect.wave,      // Default wave effect
  effect: ShimmerEffect.pulse,     // Pulsing opacity
  effect: ShimmerEffect.glow,      // Glowing effect
  effect: ShimmerEffect.fade,      // Fading effect
  effect: ShimmerEffect.slide,     // Sliding effect
  effect: ShimmerEffect.diagonal,  // Diagonal movement
  effect: ShimmerEffect.circular,  // Circular movement
  effect: ShimmerEffect.radial,    // Radial expansion
  effect: ShimmerEffect.breathing, // Breathing animation
  effect: ShimmerEffect.aurora,    // Aurora borealis effect
  child: YourWidget(),
)
```

### Global Theming

```dart
ShimmerTheme(
  data: ShimmerThemeData(
    gradient: LinearGradient(
      colors: [Colors.grey.shade300, Colors.grey.shade100],
    ),
    radius: 8.0,
    duration: Duration(milliseconds: 1500),
    effect: ShimmerEffect.wave,
  ),
  child: Column(
    children: [
      // All shimmer widgets inherit from theme
      Shimmer.themed(child: Card1()),
      Shimmer.themed(child: Card2()),
    ],
  ),
)
```

### Platform Presets

```dart
// YouTube-style shimmer
ShimmerTheme(
  data: ShimmerPreset.youtube(),
  child: YourContent(),
)

// Instagram-style shimmer
ShimmerTheme(
  data: ShimmerPreset.instagram(),
  child: YourContent(),
)

// Available presets:
// - ShimmerPreset.youtube()
// - ShimmerPreset.instagram()
// - ShimmerPreset.amazon()
// - ShimmerPreset.netflix()
// - ShimmerPreset.spotify()
// - ShimmerPreset.chat()
// - ShimmerPreset.settings()
// - ShimmerPreset.dashboard()
```

### Animation Controller

```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final ShimmerController _controller = ShimmerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer(
          controller: _controller,
          child: YourWidget(),
        ),
        ElevatedButton(
          onPressed: _controller.pause,
          child: Text('Pause'),
        ),
        ElevatedButton(
          onPressed: _controller.resume,
          child: Text('Resume'),
        ),
        ElevatedButton(
          onPressed: _controller.stop,
          child: Text('Stop'),
        ),
        ElevatedButton(
          onPressed: _controller.restart,
          child: Text('Restart'),
        ),
        ElevatedButton(
          onPressed: _controller.reverse,
          child: Text('Reverse'),
        ),
      ],
    );
  }
}
```

### Different Gradient Types

```dart
// LinearGradient
Shimmer(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
    colors: [Colors.blue, Colors.lightBlue],
  ),
  child: YourWidget(),
)

// RadialGradient
Shimmer(
  gradient: RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [Colors.white, Colors.grey],
  ),
  child: YourWidget(),
)

// SweepGradient
Shimmer(
  gradient: SweepGradient(
    center: Alignment.center,
    startAngle: 0.0,
    endAngle: 3.14,
    colors: [Colors.grey, Colors.white],
  ),
  child: YourWidget(),
)
```

## API Reference

### Shimmer

The main widget for applying shimmer effects.

| Property | Type | Description |
|----------|------|-------------|
| `gradient` | `Gradient` | The gradient to use for the shimmer effect |
| `direction` | `ShimmerDirection` | Direction of the shimmer animation |
| `period` | `Duration` | Duration of one animation cycle |
| `loop` | `int` | Number of loops (0 for infinite) |
| `enabled` | `bool` | Whether the animation is enabled |
| `effect` | `ShimmerEffect` | The animation effect style |
| `controller` | `ShimmerController?` | Optional controller for animation control |
| `child` | `Widget` | The child widget to apply shimmer to |

### ShimmerThemeData

Configuration for shimmer theming.

| Property | Type | Description |
|----------|------|-------------|
| `gradient` | `Gradient` | The gradient for the shimmer effect |
| `radius` | `double` | Border radius for shimmer containers |
| `duration` | `Duration` | Duration of the shimmer animation |
| `effect` | `ShimmerEffect` | The default animation effect |

### ShimmerController

Controller for managing shimmer animations.

| Method | Description |
|--------|-------------|
| `pause()` | Pauses the animation |
| `resume()` | Resumes from current position |
| `stop()` | Stops and resets to beginning |
| `restart()` | Restarts from beginning |
| `reverse()` | Reverses animation direction |

## Examples

See the `/example` directory for a complete demo showcasing all features:

- Loading List
- Slide To Unlock
- Skeleton Widgets
- Animation Effects
- Theme Demo
- Presets
- Controller
- Gradients

Run the example:

```bash
cd example
flutter run
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
