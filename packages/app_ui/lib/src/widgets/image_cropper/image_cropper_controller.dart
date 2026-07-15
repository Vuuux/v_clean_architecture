part of './image_cropper.dart';

typedef ImageCropperController = GlobalKey<ImageCropperState>;

extension ImageCropperControllerExtension on ImageCropperController {
  Future<Uint8List?> crop({double pixelRatio = 3}) async {
    return currentState?.crop(pixelRatio: pixelRatio);
  }
}
