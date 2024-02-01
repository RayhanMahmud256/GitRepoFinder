import 'package:flutter/material.dart';
import 'package:gitapihandler/providers/apiprovider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class repo_details extends StatelessWidget {

  late int id;
  repo_details(this.id);
  List list = [];

  @override
  Widget build(BuildContext context) {
    final repoProvider = Provider.of<ApiProvider>(context);
    list = repoProvider.list;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repository_Details"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 25),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(list[id]['owner']['avatar_url']),
                ),
                const SizedBox(height: 20),
                Text('Star Count: ' + list[id]['stargazers_count'].toString()),
                const SizedBox(height: 8),
                Text('Total Visitor: ' + list[id]['watchers_count'].toString()),
                const SizedBox(height: 8),
                Text('Total Fork: ' + list[id]['forks'].toString()),
                const SizedBox(height: 8),
                Text('Watchers: ' + list[id]['watchers'].toString()),
                const SizedBox(height: 8),
                Text('Repository Size: ' + list[id]['size'].toString()),
                const SizedBox(height: 8),
                Text('Repository Ownername: ' + list[id]['owner']['login']),
                const SizedBox(height: 8),
                Text('Repository name: ' + list[id]['full_name']),
                const SizedBox(height: 8),
                Text('Description: ' + list[id]['description']),
                const SizedBox(height: 8),
                Text('Created At: ' + list[id]['created_at']),
                const SizedBox(height: 8),
                Text('Last Updated: ' + list[id]['updated_at']),
                const SizedBox(height: 25),
                ElevatedButton(
                  child: const Text('Open Repository'),
                  onPressed: () {
                    launchURL(list[id]['html_url']);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
