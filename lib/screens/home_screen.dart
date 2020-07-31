import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:convert';
import 'dart:io';
import 'package:storage_path/storage_path.dart';
import 'package:EasyScan/Models/file_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FileModel> file;
  FileModel selectedModel;
  String img;
  @override
  void initState() {
    getimagepath();
    super.initState();
  }

  getimagepath() async {
    var imagePath = await StoragePath.imagesPath;
    var jsonimg = jsonDecode(imagePath) as List;
    file = jsonimg.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (file != null && file.length > 0) {
      selectedModel = file[0];
      img = file[0].files[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheet(context);
          setState(() {});
        },
        child: Icon(Icons.phonelink_lock),
      ),
      appBar: AppBar(
        title: Text('EasyScan'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              child: img != null
                  ? Image.file(
                      File(img),
                      height: MediaQuery.of(context).size.height * 0.49,
                      width: MediaQuery.of(context).size.width,
                    )
                  : Container(
                      child: Center(
                        child: Text("No Image Selected, Tap on Icon to load"),
                      ),
                    ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  bottomSheet(BuildContext context) {
    return showMaterialModalBottomSheet(
        context: context,
        builder: (_, scrollcont) {
          return selectedModel == null
              ? Container()
              : Container(
                  height: MediaQuery.of(context).size.height * 0.39,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: selectedModel.files.length,
                    itemBuilder: (_, count) {
                      var singlefile = selectedModel.files[count];
                      return GestureDetector(
                        onLongPress: () {
                          setState(() {});
                        },
                        onTap: () {
                          setState(() {
                            img = singlefile;
                          });
                        },
                        child: Image.file(
                          File(singlefile),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                );
        });
  }
}
