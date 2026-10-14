import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TextWidgetsDemo());
}

class TextWidgetsDemo extends StatelessWidget {
  const TextWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text Widgets',
      theme: ThemeData(colorSchemeSeed: Colors.pink, useMaterial3: true),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late final TapGestureRecognizer _linkTap;

  @override
  void initState() {
    super.initState();
    _linkTap = TapGestureRecognizer()
      ..onTap = () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You tapped the link inside RichText!')),
        );
      };
  }

  @override
  void dispose() {
    _linkTap.dispose(); // Recognizers must be disposed to avoid memory leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text, DefaultTextStyle & RichText Widgets'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // PART 1: Text
          const SectionTitle('1. Text'),

          const Text('Hello Flutter! This is a plain Text widget.'),

          const Text(
            'Styled Text',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              letterSpacing: 2,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            color: Colors.indigo.shade50,
            child: const Text('Centered text', textAlign: TextAlign.center),
          ),
          const SizedBox(height: 12),

          const Text(
            'This is a very long sentence that will not fit on one line, '
            'so Flutter cuts it and shows three dots at the end.',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          const Text(
            'This is a very long sentence that will not fit on one line, '
            'so here we allow two lines and then fade the rest of the text out '
            'instead of showing three dots.',
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),

          const SectionTitle('2. DefaultTextStyle'),

          const DefaultTextStyle(
            style: TextStyle(
              fontSize: 18,
              color: Colors.teal,
              fontWeight: FontWeight.w600,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('I inherit from Parent color teal, size 18, bold.'),
                Text('This line too, without writing any style!'),

                Text(
                  'I override only the color to red.',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          DefaultTextStyle(
            style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
            child: DefaultTextStyle.merge(
              style: const TextStyle(fontStyle: FontStyle.italic),
              child: const Text(
                'Purple + size 18 (from parent) + italic (merged)',
              ),
            ),
          ),

          const SectionTitle('3. RichText'),

          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              children: [
                const TextSpan(text: 'Flutter is '),
                const TextSpan(
                  text: 'fast',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const TextSpan(text: ', '),
                const TextSpan(
                  text: 'beautiful',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.pink,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'clickable',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: _linkTap,
                ),
                const TextSpan(text: '!'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          DefaultTextStyle(
            style: const TextStyle(fontSize: 22, color: Colors.orange),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Text: I am orange (inherited)'),
                RichText(
                  text: const TextSpan(
                    text: 'RichText: I am NOT orange (no inheritance)',
                  ),
                ),
                const Text.rich(
                  TextSpan(
                    text: 'Text.rich: I am orange ',
                    children: [
                      TextSpan(
                        text: 'and I can mix styles',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 12),
      child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}
