import 'device_proxy_service.dart';
import '../core/types.dart';

/// WhatsMeow API (`POST /whatsmeow/{action}`).
/// Uses DeviceToken for authentication.
class WhatsMeowService extends DeviceProxyService {
  WhatsMeowService(super.http) : super(http, 'whatsmeow');

  /// Instance operations
  Future<Json> createInstance(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('instance/create', body, options);

  Future<Json> connectInstance(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('instance/connect', body, options);

  Future<Json> disconnectInstance(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('instance/disconnect', body, options);

  Future<Json> logoutInstance(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('instance/logout', body, options);

  Future<Json> deleteInstance(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('instance/delete/<devicekey>', body, options);

  Future<Json> instanceInfo(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('instance/info/<devicekey>', body, options);

  Future<Json> getQRCode(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('instance/qr', body, options);

  /// Chat operations
  Future<Json> archiveChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('chat/archive', body, options);

  Future<Json> muteChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('chat/mute', body, options);

  Future<Json> pinChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('chat/pin', body, options);

  Future<Json> unpinChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('chat/unpin', body, options);

  /// Group operations
  Future<Json> createGroup(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('group/create', body, options);

  Future<Json> groupInfo(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('group/info', body, options);

  Future<Json> groupInviteLink(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('group/invitelink', body, options);

  Future<Json> joinGroup(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('group/join', body, options);

  Future<Json> listGroups([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('group/list', body, options);

  Future<Json> myAllGroups([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('group/myall', body, options);

  Future<Json> groupName(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('group/name', body, options);

  Future<Json> groupParticipant(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('group/participant', body, options);

  Future<Json> groupPhoto(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('group/photo', body, options);

  /// Send operations
  Future<Json> sendText(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('send/text', body, options);

  Future<Json> sendMedia(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('send/media', body, options);

  Future<Json> sendSticker(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('send/sticker', body, options);

  Future<Json> sendContact(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('send/contact', body, options);

  Future<Json> sendLocation(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('send/location', body, options);

  Future<Json> sendLink(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('send/link', body, options);

  Future<Json> sendPoll(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('send/poll', body, options);

  /// User operations
  Future<Json> getAvatar(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('user/avatar', body, options);

  Future<Json> blockUser(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('user/block', body, options);

  Future<Json> blockList([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('user/blocklist', body, options);

  Future<Json> checkUser(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('user/check', body, options);

  Future<Json> getContacts([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('user/contacts', body, options);

  Future<Json> getUserInfo(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('user/info', body, options);

  Future<Json> getPrivacy([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('user/privacy', body, options);

  Future<Json> getProfile([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('user/profile', body, options);

  Future<Json> unblockUser(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('user/unblock', body, options);
}