import 'dart:convert';
import 'dart:io';
import 'package:EasyScan/Models/file_model.dart';
import 'package:EasyScan/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storage_path/storage_path.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  File _imageFile;
  List<FileModel> _galleryImageFile;
  String img;
  FileModel model;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _getimagefromgallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('EasyScan'),
      ),
      body: Center(
          child: OutlineButton(
        onPressed: _showImagePicker,
        child: Text('Choose image'),
      )),
    );
  }

  void _showImagePicker() async {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 35,
              color: Theme.of(context).primaryColor,
              child: Text(
                'Choose Source',
                style: text_style.copyWith(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              onTap: _getImageFromSource,
              leading: Icon(Icons.camera_alt),
              title: Text("From Camera"),
            ),
            ListTile(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    model = _galleryImageFile[1];
                  });
                  _showbottomsheet(context);
                },
                leading: Icon(Icons.image),
                title: Text("From Gallery")),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(20.0),
                bottomRight: const Radius.circular(20.0)),
          ),
        );
      },
    );
  }

  void _getImageFromSource() async {
    Navigator.pop(context);
    var _pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      setState(() {
        this._imageFile = File(_pickedFile.path);
      });
    }
  }

  _showbottomsheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => model == null
          ? Container(
              child: Center(child: Text('nothing to show')),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: model.files.length,
              itemBuilder: (_, count) {
                var singlefile = model.files[count];
                return GestureDetector(
                  onLongPress: () {},
                  child: Image.file(
                    File(singlefile),
                  ),
                );
              },
            ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  _getimagefromgallery() async {
    var _imagepath = await StoragePath.imagesPath;
    var jsonimg = jsonDecode(_imagepath) as List;
    _galleryImageFile =
        jsonimg.map<FileModel>((e) => FileModel.fromJson(e)).toList();

    if (_galleryImageFile != null) img = _galleryImageFile[0].files[0];
    model = _galleryImageFile[1];
  }
}
