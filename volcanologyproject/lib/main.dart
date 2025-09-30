import 'package:flutter/material.dart';
import 'package:volcanologyproject/services/database_helper.dart';
import 'package:volcanologyproject/Models/models.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Initialize FFI for desktop platforms
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _showCommentsDialog(int eventId) async {
    List<Comment> comments = await DatabaseHelper.getCommentsForEvent(eventId);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Comments'),
          content: SizedBox(
            width: double.maxFinite,
            child: comments.isEmpty
                ? const Text('No comments found.')
                : ListView(
                    shrinkWrap: true,
                    children: comments
                        .map(
                          (comment) => ListTile(
                            title: Text(comment.content),
                            subtitle: Text(
                              'By ${comment.createdBy} on ${comment.date}',
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Volcanology'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            // Replace 1 with the actual eventId you want to fetch comments for
            _showCommentsDialog(1);
          },
          child: Ink(
            height: 100,
            width: 100,
            color: Colors.blue,
            child: const Center(
              child: Text('Krakatau', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
