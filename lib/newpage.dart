import 'package:epub_view/epub_view.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Go"),
          onPressed: ()async{
            EpubViewer.setConfig(
              themeColor: Theme.of(context).primaryColor,
              identifier: "androidBook",
              scrollDirection: EpubScrollDirection.VERTICAL,
              allowSharing: true,
              enableTts: true,
            );
            await EpubViewer.openAsset('assets/epubFile/pride_and_prejudice.epub');
          //EpubView(controller: EpubController(document: EpubDocument.openAsset('assets/epubFile/pride_and_prejudice.epub')));
          },
        ),
      ),
    );
  }
}
