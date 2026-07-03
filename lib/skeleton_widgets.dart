import 'package:flutter/material.dart';

import 'shimmerx.dart';

const Color _kBoneColor = Colors.white;

Widget _shimmerSkeleton({
  required Widget child,
  Color? baseColor,
  Color? highlightColor,
  Duration period = const Duration(milliseconds: 1500),
  ShimmerDirection direction = ShimmerDirection.ltr,
  int loop = 0,
  bool enabled = true,
}) {
  return Shimmer.fromColors(
    baseColor: baseColor ?? Colors.grey.shade300,
    highlightColor: highlightColor ?? Colors.grey.shade100,
    period: period,
    direction: direction,
    loop: loop,
    enabled: enabled,
    child: child,
  );
}

Widget _boneBox({
  double? width,
  double? height,
  BorderRadius borderRadius = BorderRadius.zero,
  BoxShape shape = BoxShape.rectangle,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: _kBoneColor,
      borderRadius: shape == BoxShape.circle ? null : borderRadius,
      shape: shape,
    ),
  );
}

/// Circular avatar skeleton placeholder.
class ShimmerAvatar extends StatelessWidget {
  final double size;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const ShimmerAvatar({
    super.key,
    this.size = 48,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return _shimmerSkeleton(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: _boneBox(
        width: size,
        height: size,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Single-line text skeleton placeholder.
class ShimmerText extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const ShimmerText({
    super.key,
    this.width,
    this.height = 14,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return _shimmerSkeleton(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: _boneBox(
        width: width,
        height: height,
        borderRadius: borderRadius,
      ),
    );
  }
}

/// Button-shaped skeleton placeholder.
class ShimmerButton extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const ShimmerButton({
    super.key,
    this.width,
    this.height = 48,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return _shimmerSkeleton(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: _boneBox(
        width: width,
        height: height,
        borderRadius: borderRadius,
      ),
    );
  }
}

/// Image or banner skeleton placeholder.
class ShimmerImage extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const ShimmerImage({
    super.key,
    this.width,
    this.height = 160,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return _shimmerSkeleton(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: _boneBox(
        width: width,
        height: height,
        borderRadius: borderRadius,
      ),
    );
  }
}

/// Card skeleton with title and content lines.
class ShimmerCard extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const ShimmerCard({
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return _shimmerSkeleton(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: _kBoneColor,
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _boneBox(
              width: 140,
              height: 16,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            _boneBox(
              width: double.infinity,
              height: 12,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            _boneBox(
              width: double.infinity,
              height: 12,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            _boneBox(
              width: 180,
              height: 12,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }
}

/// List tile skeleton with avatar, title, and subtitle.
class ShimmerListTile extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double avatarSize;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const ShimmerListTile({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.avatarSize = 48,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return _shimmerSkeleton(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            _boneBox(
              width: avatarSize,
              height: avatarSize,
              shape: BoxShape.circle,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _boneBox(
                    width: double.infinity,
                    height: 14,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  _boneBox(
                    width: 160,
                    height: 12,
                    borderRadius: BorderRadius.circular(4),
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

/// Profile header skeleton with avatar, name, and bio lines.
class ShimmerProfile extends StatelessWidget {
  final double avatarSize;
  final EdgeInsetsGeometry padding;
  final bool centered;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const ShimmerProfile({
    super.key,
    this.avatarSize = 72,
    this.padding = const EdgeInsets.all(24),
    this.centered = true,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisAlignment =
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return _shimmerSkeleton(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            _boneBox(
              width: avatarSize,
              height: avatarSize,
              shape: BoxShape.circle,
            ),
            const SizedBox(height: 16),
            _boneBox(
              width: 160,
              height: 16,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            _boneBox(
              width: double.infinity,
              height: 12,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            _boneBox(
              width: double.infinity,
              height: 12,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            _boneBox(
              width: 200,
              height: 12,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }
}

/// Chat message bubble skeleton placeholder.
class ShimmerChatBubble extends StatelessWidget {
  final bool isSender;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const ShimmerChatBubble({
    super.key,
    this.isSender = false,
    this.width = 220,
    this.height = 48,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isSender ? 16 : 4),
      bottomRight: Radius.circular(isSender ? 4 : 16),
    );

    return _shimmerSkeleton(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: Padding(
        padding: padding,
        child: Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: _boneBox(
            width: width,
            height: height,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}

/// Multi-line paragraph skeleton with a shorter last line.
class ShimmerParagraph extends StatelessWidget {
  final int lineCount;
  final double lineHeight;
  final double lineSpacing;
  final double lastLineWidthFactor;
  final EdgeInsetsGeometry padding;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const ShimmerParagraph({
    super.key,
    this.lineCount = 4,
    this.lineHeight = 12,
    this.lineSpacing = 8,
    this.lastLineWidthFactor = 0.65,
    this.padding = EdgeInsets.zero,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return _shimmerSkeleton(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(lineCount, (index) {
            final isLast = index == lineCount - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : lineSpacing),
              child: isLast
                  ? FractionallySizedBox(
                      widthFactor: lastLineWidthFactor,
                      alignment: Alignment.centerLeft,
                      child: _boneBox(
                        width: double.infinity,
                        height: lineHeight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )
                  : _boneBox(
                      width: double.infinity,
                      height: lineHeight,
                      borderRadius: BorderRadius.circular(4),
                    ),
            );
          }),
        ),
      ),
    );
  }
}

/// Grid of skeleton placeholders.
class ShimmerGrid extends StatelessWidget {
  final int crossAxisCount;
  final int itemCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry padding;
  final BorderRadius itemBorderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const ShimmerGrid({
    super.key,
    this.crossAxisCount = 2,
    this.itemCount = 6,
    this.mainAxisSpacing = 12,
    this.crossAxisSpacing = 12,
    this.childAspectRatio = 1,
    this.padding = const EdgeInsets.all(16),
    this.itemBorderRadius = const BorderRadius.all(Radius.circular(12)),
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return _shimmerSkeleton(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: GridView.builder(
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return _boneBox(
            width: double.infinity,
            height: double.infinity,
            borderRadius: itemBorderRadius,
          );
        },
      ),
    );
  }
}
