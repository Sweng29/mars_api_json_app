import 'Camera.dart';

class Mars {
  final int id;
  final String camera;
  final String cameraFullName;
  final String imageUrl;
  final String captureDate;
  final List<Camera> cameraList;

  Mars(
      {this.id,
      this.camera,
      this.imageUrl,
      this.captureDate,
      this.cameraList,
      this.cameraFullName});
}
