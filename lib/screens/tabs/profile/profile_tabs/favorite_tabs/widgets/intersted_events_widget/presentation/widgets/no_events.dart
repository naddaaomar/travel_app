/*
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:p/screens/view_all_events/presentation/pages/view_all_recommended_events.dart';

class NoInterstedEvents extends StatefulWidget {
  const NoInterstedEvents({super.key, required Function() onAddInterest});

  @override
  State<NoInterstedEvents> createState() => _NoFavoritesState();
}

class _NoFavoritesState extends State<NoInterstedEvents> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.interests_outlined,
                    size: 80,
                    color: theme.colorScheme.secondary.withOpacity(0.6),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "You Don't Have Inerested Events Yet",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onBackground,
                      fontFamily: 'vol',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Make your Inerested Events easy to access',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.7),
                      fontFamily: 'vol',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 44),
                  ExploreButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) =>  ViewAllEvents(eventModel: []),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ExploreButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFF9682),
              Color(0xFFDF6951),
              Color(0xFFB43E26),
              Color(0xFFDF6951),
              Color(0xFFFF9682),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            'Explore Events',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontFamily: 'vol',
            ),
          ),
        ),
      ),
    );
  }
}

 */