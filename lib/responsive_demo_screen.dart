import 'package:flutter/material.dart';

class ResponsiveDemoScreen extends StatefulWidget {
  const ResponsiveDemoScreen({Key? key}) : super(key: key);

  @override
  State<ResponsiveDemoScreen> createState() => _ResponsiveDemoScreenState();
}

class _ResponsiveDemoScreenState extends State<ResponsiveDemoScreen> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');
  int selectedIndex = 0;

  void _openDetailsMobile(BuildContext context, String item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsPage(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive multi-pane demo')),
      body: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width < 600) {
          return _buildListView(context, onTapMobile: true);
        } else if (width < 1024) {
          return Row(
            children: [
              SizedBox(
                width: 320,
                child: _buildListView(context, onTapMobile: false),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: DetailsPane(item: items[selectedIndex]),
              ),
            ],
          );
        } else {
          return Row(
            children: [
              SizedBox(
                width: 300,
                child: _buildListView(context, onTapMobile: false),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                flex: 2,
                child: DetailsPane(item: items[selectedIndex]),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                flex: 1,
                child: ExtraPane(item: items[selectedIndex]),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _buildListView(BuildContext context, {required bool onTapMobile}) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = items[index];
        final selected = index == selectedIndex;
        return Material(
          color: selected ? Colors.blue.shade50 : null,
          child: ListTile(
            title: Text(item),
            subtitle: const Text('Short description'),
            selected: selected,
            onTap: () {
              if (onTapMobile) {
                _openDetailsMobile(context, item);
              } else {
                setState(() => selectedIndex = index);
              }
            },
          ),
        );
      },
    );
  }
}

class DetailsPane extends StatelessWidget {
  final String item;
  const DetailsPane({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            '$item\n\nDetailed information shown here.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}

class ExtraPane extends StatelessWidget {
  final String item;
  const ExtraPane({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Extra panel for:\n\n$item\n\nUse this for actions / metadata / chat.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String item;
  const DetailsPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item)),
      body: DetailsPane(item: item),
    );
  }
}