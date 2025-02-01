import 'package:flutter/services.dart';

const methodChannel = MethodChannel('method.channel.bannzai.medicalarm');

void requestAppTrackingTransparency() {
  methodChannel.invokeMethod('requestAppTrackingTransparency');
}
