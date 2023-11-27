import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'drawer_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  List<String> quotes = [];
  int postCount = 10; // Initial number of quotes to load
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMoreQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getFirstName(),
      builder: (context, snapshot) {
        final String name = snapshot.data ?? 'Default Name';

        return Scaffold(
          appBar: AppBar(
            title: Text('Welcome'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Hello $name ,",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      // Load more quotes when reaching the end
                      _loadMoreQuotes();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: quotes.length + 1, // +1 for the loading indicator
                    itemBuilder: (context, index) {
                      if (index < quotes.length) {
                        return _buildQuoteCard(quotes[index]);
                      } else {
                        return _buildLoader();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          drawer: DrawerPage(),
          floatingActionButton: FloatingActionButton(
            onPressed: _resetAndLoadNewPosts,
            tooltip: 'New Posts',
            child: Icon(Icons.restart_alt_sharp),
          ),
        );
      },
    );
  }

  Future<String> _getFirstName() async {
    return await storage.read(key: 'firstName') ?? 'Default Name';
  }

  Widget _buildQuoteCard(String quote) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(quote),
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  void _loadMoreQuotes() async {
    setState(() {
      isLoading = true;
    });

    for (int i = 0; i < 10; i++) {
      final response = await http.get(Uri.parse('https://api.quotable.io/random?tags=inspirational'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> quoteData = json.decode(response.body);
        final String content = quoteData['content'];
        setState(() {
          quotes.add(content);
        });
      } else {
        // Handle error
        print('Failed to load quotes: ${response.statusCode}');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void _resetAndLoadNewPosts() {
    setState(() {
      quotes.clear();
    });

    _loadMoreQuotes();
  }
}
