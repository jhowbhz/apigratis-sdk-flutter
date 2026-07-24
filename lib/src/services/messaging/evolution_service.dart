import 'device_proxy_service.dart';
import '../core/types.dart';

/// Evolution API (`POST /evolution/{controller}/{action}`).
/// Uses DeviceToken for authentication.
class EvolutionService extends BaseService {
  EvolutionService(super.http);

  @override
  String buildUrl(String path) => http.joinUrl(http.baseUrl, 'evolution/$path');

  /// Instance operations
  Future<Json> createInstance(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('instance/create', body, options);

  Future<Json> connectInstance(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('instance/connect', body, options);

  Future<Json> connectionState(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('instance/connectionState', body, options);

  Future<Json> restartInstance(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('instance/restart', body, options);

  Future<Json> logoutInstance(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('instance/logout', body, options);

  Future<Json> deleteInstance(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('instance/delete', body, options);

  /// Message operations
  Future<Json> sendText(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendText', body, options);

  Future<Json> sendTextQueue(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendText/queue', body, options);

  Future<Json> sendMedia(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendMedia', body, options);

  Future<Json> sendSticker(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendSticker', body, options);

  Future<Json> sendContact(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendContact', body, options);

  Future<Json> sendLocation(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendLocation', body, options);

  Future<Json> sendPoll(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendPoll', body, options);

  Future<Json> sendReaction(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendReaction', body, options);

  Future<Json> sendStatus(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendStatus', body, options);

  Future<Json> sendButtons(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendButtons', body, options);

  Future<Json> sendWhatsAppAudio(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('message/sendWhatsAppAudio', body, options);

  Future<Json> deleteMessageForEveryone(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/deleteMessageForEveryone', body, options);

  /// Chat operations
  Future<Json> findChats(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/findChats', body, options);

  Future<Json> findContacts(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/findContacts', body, options);

  Future<Json> findMessages(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/findMessages', body, options);

  Future<Json> fetchPrivacySettings(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/fetchPrivacySettings', body, options);

  Future<Json> fetchProfile(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/fetchProfile', body, options);

  Future<Json> fetchProfilePictureUrl(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/fetchProfilePictureUrl', body, options);

  Future<Json> updatePrivacySettings(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/updatePrivacySettings', body, options);

  Future<Json> updateProfileName(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/updateProfileName', body, options);

  Future<Json> updateProfilePicture(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/updateProfilePicture', body, options);

  Future<Json> updateProfileStatus(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/updateProfileStatus', body, options);

  Future<Json> removeProfilePicture(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/removeProfilePicture', body, options);

  Future<Json> getBase64FromMediaMessage(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/getBase64FromMediaMessage', body, options);

  Future<Json> whatsappNumbers(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('chat/whatsappNumbers', body, options);

  /// Group operations
  Future<Json> createGroup(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/create', body, options);

  Future<Json> fetchAllGroups(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/fetchAllGroups?getParticipants=true', body, options);

  Future<Json> findGroupInfos(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/findGroupInfos', body, options);

  Future<Json> inviteCode(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/inviteCode', body, options);

  Future<Json> inviteInfo(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/inviteInfo', body, options);

  Future<Json> participants(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/participants', body, options);

  Future<Json> revokeInviteCode(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/revokeInviteCode', body, options);

  Future<Json> sendInvite(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/sendInvite', body, options);

  Future<Json> updateGroupDescription(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/updateGroupDescription', body, options);

  Future<Json> updateGroupPicture(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/updateGroupPicture', body, options);

  Future<Json> updateGroupSubject(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/updateGroupSubject', body, options);

  Future<Json> updateParticipant(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/updateParticipant', body, options);

  Future<Json> updateSetting(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('group/updateSetting', body, options);

  /// Label operations
  Future<Json> findLabels([Json? body, RequestOptions options = const RequestOptions()]) =>
      post('label/findLabels', body, options);

  Future<Json> handleLabel(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('label/handleLabel', body, options);

  /// Call operations
  Future<Json> offerCall(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('call/offer', body, options);

  /// Settings
  Future<Json> findSettings([Json? body, RequestOptions options = const RequestOptions()]) =>
      post('settings/find', body, options);

  Future<Json> setSettings(Json body, [RequestOptions options = const RequestOptions()]) =>
      post('settings/set', body, options);

  /// Generic request for any evolution path
  Future<Json> request(String controller, String action, [Json? body, RequestOptions options = const RequestOptions()]) {
    final path = '$controller/$action';
    return post(path, body, options);
  }
}