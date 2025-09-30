import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Comments'),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView(
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
