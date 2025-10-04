import 'dart:io';

import 'package:aio_image_provider/aio_image_provider.dart';
import 'package:flutter/cupertino.dart';

enum AipImageType { url, file, asset }

abstract class AipImage {
  final String? url;
  final String? path;
  final String? assetName;
  final AipImageType type;
  AipImage({this.url, this.path, required this.type, this.assetName});

  ImageProvider get imageProvider;
}

class AipUrlImage extends AipImage {
  AipUrlImage({required String url}) : super(url: url, path: null, assetName: null, type: AipImageType.url);

  @override
  ImageProvider<Object> get imageProvider => NetworkImage(url!);

}

class AipFileImage extends AipImage {
  AipFileImage({required String path}) : super(path: path, url: null, assetName: null, type: AipImageType.file);

  @override
  ImageProvider<Object> get imageProvider => FileImage(File("${AioImageProvider().saveDirectory}/${path!}"));
}

class AipAssetImage extends AipImage {
  AipAssetImage({required super.assetName}) : super(path: null, url: null, type: AipImageType.asset);

  @override
  ImageProvider<Object> get imageProvider => AssetImage(assetName!);
}