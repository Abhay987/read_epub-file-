import 'package:flutter/material.dart';
import 'package:epub_view/epub_view.dart';
import 'package:newprojectapp/newpage.dart';
void main() {
  runApp(const MyAppNew());
}

class MyAppNew extends StatelessWidget {
  const MyAppNew({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late EpubController epubController;
  @override
  void initState() {
    super.initState();
      epubController= EpubController(document: EpubDocument.openAsset('assets/epubFile/Around the World in 28 Languages.epub',
      ),epubCfi: 'epubcfi(/6/6[s002]!/4/2)',
       );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save_alt),
            color: Colors.white,
            onPressed: () => _showCurrentEpubCfi(context),
          ),
        ],
        // Show actual chapter name
        title: EpubViewActualChapter(
            controller: epubController,
          builder: (chapterValue)=>Text(
            'Chapter: ' +
                (chapterValue?.chapter?.Title
                    ?.replaceAll('\n', '')
                    .trim() ??
                    ''),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(
          controller: epubController,
        ),
      ),
      body: EpubView(controller: epubController,
      builders: EpubViewBuilders<DefaultBuilderOptions>(options: const DefaultBuilderOptions(),
      chapterDividerBuilder: (_)=> const Divider()),),
    );
  }
  void _showCurrentEpubCfi(context) {
    final cfi = epubController.generateEpubCfi();

    if (cfi != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
          content: Text(cfi),
    action: SnackBarAction(
    label: 'GO',
    onPressed: () {
    epubController.gotoEpubCfi(cfi);
    })));}
}
}
