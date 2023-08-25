import 'package:base_structure/core/mediators/bloc_hub/hub.dart';
import 'package:base_structure/core/mediators/communication_types/base_communication.dart';

mixin BlocMember {
 late BlocHub blocHub;
 late String name;

  void receive(String from, CommunicationType data);

  void sendTo(CommunicationType data, String receiverName) {
    blocHub.sendToByName(name, data, receiverName);
  }

  void sendToAll(CommunicationType data) {
    blocHub.sendToAll(name, data);
  }
}
