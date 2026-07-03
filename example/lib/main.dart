import 'package:flutter/material.dart';
import 'package:flutter_shimmer_pro/flutter_shimmer_pro.dart';

import 'placeholders.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmerx',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        'loading': (_) => const LoadingListPage(),
        'slide': (_) => SlideToUnlockPage(),
        'skeletons': (_) => const SkeletonWidgetsPage(),
        'effects': (_) => const AnimationEffectsPage(),
        'theme': (_) => const ThemeDemoPage(),
        'presets': (_) => const PresetsDemoPage(),
        'controller': (_) => const ControllerDemoPage(),
        'gradients': (_) => const GradientDemoPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Shimmerx'),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildListDelegate([
                _buildFeatureCard(
                  context,
                  title: 'Loading List',
                  icon: Icons.list,
                  color: Colors.blue,
                  route: 'loading',
                ),
                _buildFeatureCard(
                  context,
                  title: 'Slide To Unlock',
                  icon: Icons.lock_open,
                  color: Colors.purple,
                  route: 'slide',
                ),
                _buildFeatureCard(
                  context,
                  title: 'Skeleton Widgets',
                  icon: Icons.widgets,
                  color: Colors.green,
                  route: 'skeletons',
                ),
                _buildFeatureCard(
                  context,
                  title: 'Animation Effects',
                  icon: Icons.animation,
                  color: Colors.orange,
                  route: 'effects',
                ),
                _buildFeatureCard(
                  context,
                  title: 'Theme Demo',
                  icon: Icons.palette,
                  color: Colors.pink,
                  route: 'theme',
                ),
                _buildFeatureCard(
                  context,
                  title: 'Presets',
                  icon: Icons.bookmark,
                  color: Colors.teal,
                  route: 'presets',
                ),
                _buildFeatureCard(
                  context,
                  title: 'Controller',
                  icon: Icons.gamepad,
                  color: Colors.indigo,
                  route: 'controller',
                ),
                _buildFeatureCard(
                  context,
                  title: 'Gradients',
                  icon: Icons.gradient,
                  color: Colors.amber,
                  route: 'gradients',
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(route),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({super.key});

  @override
  State<LoadingListPage> createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading List'),
      ),
      body: Shimmer(
        gradient: const LinearGradient(
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
        enabled: true,
        child: const SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              BannerPlaceholder(),
              TitlePlaceholder(width: double.infinity),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.threeLines,
              ),
              SizedBox(height: 16.0),
              TitlePlaceholder(width: 200.0),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              SizedBox(height: 16.0),
              TitlePlaceholder(width: 200.0),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlideToUnlockPage extends StatelessWidget {
  final List<String> days = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  SlideToUnlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime time = DateTime.now();
    final int hour = time.hour;
    final int minute = time.minute;
    final int day = time.weekday;
    final int month = time.month;
    final int dayInMonth = time.day;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide To Unlock'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1a237e), Color(0xFF3949ab)],
              ),
            ),
          ),
          Positioned(
            top: 48.0,
            right: 0.0,
            left: 0.0,
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    '${hour < 10 ? '0$hour' : '$hour'}:${minute < 10 ? '0$minute' : '$minute'}',
                    style: const TextStyle(
                      fontSize: 60.0,
                      color: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                  ),
                  Text(
                    '${days[day - 1]}, ${months[month - 1]} $dayInMonth',
                    style: const TextStyle(fontSize: 24.0, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 32.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Opacity(
                  opacity: 0.8,
                  child: Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.chevron_right,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                        ),
                        const Text(
                          'Slide to unlock',
                          style: TextStyle(
                            fontSize: 28.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class SkeletonWidgetsPage extends StatelessWidget {
  const SkeletonWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skeleton Widgets'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ShimmerAvatar(size: 56),
          SizedBox(height: 16),
          ShimmerText(width: 180),
          SizedBox(height: 16),
          ShimmerButton(width: double.infinity),
          SizedBox(height: 16),
          ShimmerImage(height: 120),
          SizedBox(height: 16),
          ShimmerCard(),
          SizedBox(height: 16),
          ShimmerListTile(),
          SizedBox(height: 16),
          ShimmerProfile(centered: false, padding: EdgeInsets.zero),
          SizedBox(height: 16),
          ShimmerChatBubble(isSender: false),
          SizedBox(height: 8),
          ShimmerChatBubble(isSender: true),
          SizedBox(height: 16),
          ShimmerParagraph(lineCount: 4),
          SizedBox(height: 16),
          ShimmerGrid(
            itemCount: 4,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

class AnimationEffectsPage extends StatelessWidget {
  const AnimationEffectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Effects'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildEffectCard('Wave', ShimmerEffect.wave),
          const SizedBox(height: 16),
          _buildEffectCard('Pulse', ShimmerEffect.pulse),
          const SizedBox(height: 16),
          _buildEffectCard('Glow', ShimmerEffect.glow),
          const SizedBox(height: 16),
          _buildEffectCard('Fade', ShimmerEffect.fade),
          const SizedBox(height: 16),
          _buildEffectCard('Slide', ShimmerEffect.slide),
          const SizedBox(height: 16),
          _buildEffectCard('Diagonal', ShimmerEffect.diagonal),
          const SizedBox(height: 16),
          _buildEffectCard('Circular', ShimmerEffect.circular),
          const SizedBox(height: 16),
          _buildEffectCard('Radial', ShimmerEffect.radial),
          const SizedBox(height: 16),
          _buildEffectCard('Breathing', ShimmerEffect.breathing),
          const SizedBox(height: 16),
          _buildEffectCard('Aurora', ShimmerEffect.aurora),
        ],
      ),
    );
  }

  Widget _buildEffectCard(String title, ShimmerEffect effect) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              effect: effect,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 200,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeDemoPage extends StatelessWidget {
  const ThemeDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Default Theme',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ShimmerTheme(
            data: const ShimmerThemeData(
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
              duration: Duration(milliseconds: 1500),
              effect: ShimmerEffect.wave,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildThemedCard('Default Wave'),
                const SizedBox(height: 16),
                _buildThemedCard('Another Card'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Custom Theme - Pulse Effect',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ShimmerTheme(
            data: const ShimmerThemeData(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFFBDBDBD),
                  Color(0xFFBDBDBD),
                  Color(0xFFEEEEEE),
                  Color(0xFFBDBDBD),
                  Color(0xFFBDBDBD),
                ],
                stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
              ),
              radius: 12.0,
              duration: Duration(milliseconds: 1000),
              effect: ShimmerEffect.pulse,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildThemedCard('Pulse Card'),
                const SizedBox(height: 16),
                _buildThemedCard('Another Pulse Card'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Custom Theme - Aurora Effect',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ShimmerTheme(
            data: const ShimmerThemeData(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFF9C27B0),
                  Color(0xFF9C27B0),
                  Color(0xFFE1BEE7),
                  Color(0xFF9C27B0),
                  Color(0xFF9C27B0),
                ],
                stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
              ),
              radius: 16.0,
              duration: Duration(milliseconds: 2000),
              effect: ShimmerEffect.aurora,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildThemedCard('Aurora Card'),
                const SizedBox(height: 16),
                _buildThemedCard('Another Aurora Card'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Custom Theme - Breathing Effect',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ShimmerTheme(
            data: const ShimmerThemeData(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFF4CAF50),
                  Color(0xFF4CAF50),
                  Color(0xFFC8E6C9),
                  Color(0xFF4CAF50),
                  Color(0xFF4CAF50),
                ],
                stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
              ),
              radius: 20.0,
              duration: Duration(milliseconds: 1800),
              effect: ShimmerEffect.breathing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildThemedCard('Breathing Card'),
                const SizedBox(height: 16),
                _buildThemedCard('Another Breathing Card'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemedCard(String title) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer.themed(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 150,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PresetsDemoPage extends StatelessWidget {
  const PresetsDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presets'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPresetSection('YouTube', ShimmerPreset.youtube()),
          const SizedBox(height: 24),
          _buildPresetSection('Instagram', ShimmerPreset.instagram()),
          const SizedBox(height: 24),
          _buildPresetSection('Amazon', ShimmerPreset.amazon()),
          const SizedBox(height: 24),
          _buildPresetSection('Netflix', ShimmerPreset.netflix()),
          const SizedBox(height: 24),
          _buildPresetSection('Spotify', ShimmerPreset.spotify()),
          const SizedBox(height: 24),
          _buildPresetSection('Chat', ShimmerPreset.chat()),
          const SizedBox(height: 24),
          _buildPresetSection('Settings', ShimmerPreset.settings()),
          const SizedBox(height: 24),
          _buildPresetSection('Dashboard', ShimmerPreset.dashboard()),
        ],
      ),
    );
  }

  Widget _buildPresetSection(String title, ShimmerThemeData themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ShimmerTheme(
          data: themeData,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Shimmer.themed(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(themeData.radius),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 150,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(themeData.radius),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 200,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ControllerDemoPage extends StatefulWidget {
  const ControllerDemoPage({super.key});

  @override
  State<ControllerDemoPage> createState() => _ControllerDemoPageState();
}

class _ControllerDemoPageState extends State<ControllerDemoPage> {
  final ShimmerController _controller = ShimmerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controller Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                controller: _controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 200,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: _controller.pause,
                child: const Text('Pause'),
              ),
              ElevatedButton(
                onPressed: _controller.resume,
                child: const Text('Resume'),
              ),
              ElevatedButton(
                onPressed: _controller.stop,
                child: const Text('Stop'),
              ),
              ElevatedButton(
                onPressed: _controller.restart,
                child: const Text('Restart'),
              ),
              ElevatedButton(
                onPressed: _controller.reverse,
                child: const Text('Reverse'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Controller Methods:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text('• pause() - Pauses the animation'),
          const Text('• resume() - Resumes from current position'),
          const Text('• stop() - Stops and resets to beginning'),
          const Text('• restart() - Restarts from beginning'),
          const Text('• reverse() - Reverses animation direction'),
        ],
      ),
    );
  }
}

class GradientDemoPage extends StatelessWidget {
  const GradientDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradient Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Linear Gradient',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Shimmer(
                gradient: const LinearGradient(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Linear Gradient with Colors',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Shimmer(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0xFF2196F3),
                    Color(0xFF2196F3),
                    Color(0xFF64B5F6),
                    Color(0xFF2196F3),
                    Color(0xFF2196F3),
                  ],
                  stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Radial Gradient',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Shimmer(
                gradient: const RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: <Color>[
                    Color(0xFFF5F5F5),
                    Color(0xFFE0E0E0),
                    Color(0xFFE0E0E0),
                  ],
                  stops: <double>[0.0, 0.5, 1.0],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Sweep Gradient',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Shimmer(
                gradient: const SweepGradient(
                  center: Alignment.center,
                  startAngle: 0.0,
                  endAngle: 3.14,
                  colors: <Color>[
                    Color(0xFFE0E0E0),
                    Color(0xFFF5F5F5),
                    Color(0xFFE0E0E0),
                  ],
                  stops: <double>[0.0, 0.5, 1.0],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Custom Multi-Color Gradient',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Shimmer(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0xFFFF6B6B),
                    Color(0xFFFF6B6B),
                    Color(0xFF4ECDC4),
                    Color(0xFFFF6B6B),
                    Color(0xFFFF6B6B),
                  ],
                  stops: <double>[0.0, 0.35, 0.5, 0.65, 1.0],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
