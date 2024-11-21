import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: const Center(
          child: AnimatedDock(),
        ),
      ),
    );
  }
}

class AnimatedDock extends StatefulWidget {
  const AnimatedDock({super.key});

  @override
  _AnimatedDockState createState() => _AnimatedDockState();
}

class _AnimatedDockState extends State<AnimatedDock> {
  final List<DockItem> dockItems = [
    DockItem(icon: Icons.home, label: 'Home'),
    DockItem(icon: Icons.search, label: 'Search'),
    DockItem(icon: Icons.settings, label: 'Settings'),
    DockItem(icon: Icons.camera_alt, label: 'Camera'),
    DockItem(icon: Icons.favorite, label: 'Favorite'),
  ];

  int? hoverIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dockItems.asMap().entries.map((entry) {
          int index = entry.key;
          DockItem item = entry.value;

          bool isHovered = hoverIndex == index;

          return GestureDetector(
            onTap: () => print('${item.label} clicked'),
            child: Draggable(
              data: item,
              feedback: Material(
                color: Colors.transparent,
                child: Icon(
                  item.icon,
                  size: 60,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              childWhenDragging: const SizedBox.shrink(),
              child: MouseRegion(
                onEnter: (_) => setState(() => hoverIndex = index),
                onExit: (_) => setState(() => hoverIndex = null),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: isHovered ? 80 : 60,
                  height: isHovered ? 80 : 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      if (isHovered)
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: Icon(
                    item.icon,
                    color: Colors.white,
                    size: isHovered ? 40 : 30,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DockItem {
  final IconData icon;
  final String label;

  DockItem({required this.icon, required this.label});
}