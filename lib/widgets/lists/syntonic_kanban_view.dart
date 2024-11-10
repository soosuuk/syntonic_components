import 'package:flutter/material.dart';

class KanbanView extends StatefulWidget {
  final List<String> sectionNames;
  final Widget Function(BuildContext, int, int) itemBuilder;

  const KanbanView({
    Key? key,
    required this.sectionNames,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  _KanbanViewState createState() => _KanbanViewState();
}

class _KanbanViewState extends State<KanbanView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  void _onItemDropped(String item, String newSection, int newIndex) {
    setState(() {
      // Handle item drop logic here
    });
  }

  void _onItemMove(Offset position) {
    double pageWidth = MediaQuery.of(context).size.width * 0.8;
    int pageIndex = (position.dx / pageWidth).round();
    pageIndex = pageIndex.clamp(0, widget.sectionNames.length - 1);
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('PageView Example')),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0), // Add 16px padding to the left
        child: PageView.builder(
          controller: _pageController,
          padEnds: false,  // Prevent padding at edges
          itemCount: 5,  // Number of pages
          itemBuilder: (context, sectionIndex) {
            return KanbanSection(
              sectionIndex: sectionIndex,
              title: widget.sectionNames[sectionIndex],
              onItemDropped: _onItemDropped,
              onItemMove: _onItemMove,
              itemBuilder: widget.itemBuilder,
              name: widget.sectionNames[sectionIndex],
            );
            return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.only(right: 8.0),  // Space between pages
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Text(
                  'Page ${sectionIndex + 1}',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class KanbanSection extends StatelessWidget {
  final int sectionIndex;
  final String title;
  final Function(String, String, int) onItemDropped;
  final Function(Offset) onItemMove;
  final Widget Function(BuildContext, int, int) itemBuilder;
  final String name;

  const KanbanSection({
    Key? key,
    required this.sectionIndex,
    required this.title,
    required this.onItemDropped,
    required this.onItemMove,
    required this.itemBuilder,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAcceptWithDetails: (details) {
        int newIndex = 0; // Default to adding at the start
        onItemDropped(details.data, title, newIndex);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              const SizedBox(height: 8.0),
              Expanded(
                child: ReorderableListView.builder(
                  scrollController: ScrollController(),
                  itemCount: 5, // Assuming 5 items per section
                  onReorder: (oldIndex, newIndex) {
                    // Handle reorder logic here
                  },
                  itemBuilder: (context, itemIndex) {
                    return LongPressDraggable<String>(
                      key: ValueKey('Task ${itemIndex + 1}'),
                      data: 'Task ${itemIndex + 1}',
                      child: itemBuilder(context, sectionIndex, itemIndex),
                      feedback: Material(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: itemBuilder(context, sectionIndex, itemIndex),
                        ),
                      ),
                      childWhenDragging: Container(),
                      onDragUpdate: (details) {
                        onItemMove(details.globalPosition);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}