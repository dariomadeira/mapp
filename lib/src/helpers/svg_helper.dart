import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<SvgPicture> loadSvg(BuildContext context, String path) async {
  var picture = SvgPicture.asset(path);
  await precachePicture(picture.pictureProvider, context);
  return picture;
}

Future<Image> loadByNetwork(BuildContext context, String path) async {
  var picture = Image.network(path);
  await precacheImage(picture.image, context);
  return picture;
}