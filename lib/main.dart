import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tags Generator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 160, 161, 161))
          //primarySwatch: Colors.lime,
          ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _titleController = TextEditingController();
  List<String> _generatedTags = [];

  void _generateTags() {
    String title = _titleController.text;
    // Replace this logic with your AI-based tag generation logic
    List<String> words = title.split(' ');
    List<String> generatedTags = words.take(5).toList();
    setState(() {
      _generatedTags = generatedTags;
    });
  }

  void _copyTagsToClipboard() {
    String tagsToCopy = _generatedTags
        .join(', '); // Join tags with a comma (customize as needed)
    Clipboard.setData(ClipboardData(text: tagsToCopy));
    // Show a SnackBar to indicate that tags have been copied
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tags copied to clipboard'),
      ),
    );
  }

  void _clearController() {
    _titleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    AssetImage backgroundImage = AssetImage('assets/background.png');
    Image image = Image(image: backgroundImage, fit: BoxFit.cover);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.text_rotation_angledown),
        title: Text(
          'Tags Generator',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: image),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.tag_sharp),
                      helperText: 'Tags Generator ',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      labelText: 'Enter the title of your video',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _clearController();
                        },
                        child: Icon(Icons.clear),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _generateTags();
                    },
                    child: Text('Generate Tags'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Generated Tags:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _generatedTags
                        .map((tag) => Chip(label: Text(tag)))
                        .toList(),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      _copyTagsToClipboard();
                    },
                    icon: Icon(Icons.content_copy),
                    label: Text('Copy Tags'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
