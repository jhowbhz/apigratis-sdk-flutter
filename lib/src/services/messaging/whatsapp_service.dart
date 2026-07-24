import 'device_proxy_service.dart';
import '../core/types.dart';

/// WhatsApp device-based API (`POST /whatsapp/{action}`).
/// Requires `Authorization: Bearer` + `DeviceToken`.
class WhatsAppService extends DeviceProxyService {
  WhatsAppService(super.http) : super(http, 'whatsapp');

  /// Starts the device session (accepts optional webhooks).
  Future<Json> start([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('start', body, options);

  /// Returns the pairing QR Code (`response.qrcode` in base64).
  Future<Json> qrcode([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('qrcode', body, options);

  /// Ends the session.
  Future<Json> logout([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('logout', body, options);

  /// Closes the browser/session on the server.
  Future<Json> close([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('close', body, options);

  /// Deletes the session on the server.
  Future<Json> deleteSession([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('deleteSession', body, options);

  /// Sends a text message: `{'number': '5511999999999', 'text': 'Olá!'}`.
  Future<Json> sendText(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendText', body, options);

  /// Sends a file from URL: `{'number': ..., 'path': ...}`.
  Future<Json> sendFile(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendFile', body, options);

  /// Sends a file as base64.
  Future<Json> sendFile64(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendFile64', body, options);

  /// Sends audio (URL; converted to mp3 by gateway, max 6 min).
  Future<Json> sendAudio(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendAudio', body, options);

  /// Sends video from URL.
  Future<Json> sendVideo(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendVideo', body, options);

  /// Sends a link with preview.
  Future<Json> sendLink(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendLink', body, options);

  /// Sends a location: `{'number': ..., 'lat': ..., 'lng': ...}`.
  Future<Json> sendLocation(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendLocation', body, options);

  /// Sends a contact.
  Future<Json> sendContact(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendContact', body, options);

  /// Sends an image to story.
  Future<Json> sendImageToStorie(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendImageToStorie', body, options);

  /// Sends text to story.
  Future<Json> sendTextToStorie(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendTextToStorie', body, options);

  /// Sends video to story.
  Future<Json> sendVideoToStorie(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendVideoToStorie', body, options);

  /// Sends a GIF.
  Future<Json> sendGif(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendGif', body, options);

  /// Sends a sticker.
  Future<Json> sendSticker(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendSticker', body, options);

  /// Sends a contact vCard list.
  Future<Json> sendContactVcardList(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendContactVcardList', body, options);

  /// Sends a list message.
  Future<Json> sendList(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendList', body, options);

  /// Sends buttons message.
  Future<Json> sendButtons(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendButtons', body, options);

  /// Sends a poll message.
  Future<Json> sendPollMessage(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendPollMessage', body, options);

  /// Sends an order message.
  Future<Json> sendOrderMessage(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendOrderMessage', body, options);

  /// Sends a PIX key message.
  Future<Json> sendPixKey(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendPixKey', body, options);

  /// Sends a message with thumbnail.
  Future<Json> sendMessageWithThumb(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendMessageWithThumb', body, options);

  /// Sends audio as base64.
  Future<Json> sendAudio64(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendAudio64', body, options);

  /// Sends video as GIF.
  Future<Json> sendVideoAsGif(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendVideoAsGif', body, options);

  /// Sends mentioned message.
  Future<Json> sendMentioned(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendMentioned', body, options);

  /// Sends read status.
  Future<Json> sendReadStatus(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('sendReadStatus', body, options);

  /// Starts typing indicator.
  Future<Json> startTyping(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('startTyping', body, options);

  /// Stops typing indicator.
  Future<Json> stopTyping(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('stopTyping', body, options);

  /// Starts recording indicator.
  Future<Json> startRecording(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('startRecording', body, options);

  /// Stops recording indicator.
  Future<Json> stopRecording(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('stopRecording', body, options);

  /// Checks if a number is on WhatsApp.
  Future<Json> checkNumberStatus(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('checkNumberStatus', body, options);

  /// Gets all chats.
  Future<Json> getAllChats([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getAllChats', body, options);

  /// Gets all chats with messages.
  Future<Json> getAllChatsWithMessages([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getAllChatsWithMessages', body, options);

  /// Gets all contacts.
  Future<Json> getAllContacts([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getAllContacts', body, options);

  /// Gets all groups.
  Future<Json> getAllGroups([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getAllGroups', body, options);

  /// Gets all groups with full info.
  Future<Json> getAllGroupsFull([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getAllGroupsFull', body, options);

  /// Gets all labels.
  Future<Json> getAllLabels([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getAllLabels', body, options);

  /// Gets all new messages.
  Future<Json> getAllNewMessages([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getAllNewMessages', body, options);

  /// Gets auto download settings.
  Future<Json> getAutoDownloadSettings([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getAutoDownloadSettings', body, options);

  /// Sets auto download settings.
  Future<Json> setAutoDownloadSettings(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('setAutoDownloadSettings', body, options);

  /// Gets battery level.
  Future<Json> getBatteryLevel([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getBatteryLevel', body, options);

  /// Gets block list.
  Future<Json> getBlockList([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getBlockList', body, options);

  /// Blocks a contact.
  Future<Json> blockContact(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('blockContact', body, options);

  /// Unblocks a contact.
  Future<Json> unblockContact(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('unblockContact', body, options);

  /// Gets chat info.
  Future<Json> getChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getChat', body, options);

  /// Gets common groups.
  Future<Json> getCommonGroups(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getCommonGroups', body, options);

  /// Gets community participants.
  Future<Json> getCommunityParticipants(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getCommunityParticipants', body, options);

  /// Gets connection state.
  Future<Json> getConnectionState([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getConnectionState', body, options);

  /// Gets connection status.
  Future<Json> getConnectionStatus([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getConnectionStatus', body, options);

  /// Gets group admins.
  Future<Json> getGroupAdmins(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getGroupAdmins', body, options);

  /// Gets group info from invite link.
  Future<Json> getGroupInfoFromInviteLink(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getGroupInfoFromInviteLink', body, options);

  /// Gets group invite link.
  Future<Json> getGroupInviteLink(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getGroupInviteLink', body, options);

  /// Gets group members.
  Future<Json> getGroupMembers(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getGroupMembers', body, options);

  /// Gets group members IDs.
  Future<Json> getGroupMembersIds(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getGroupMembersIds', body, options);

  /// Gets group membership requests.
  Future<Json> getGroupMembershipRequests(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getGroupMembershipRequests', body, options);

  /// Gets group size limit.
  Future<Json> getGroupSizeLimit([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getGroupSizeLimit', body, options);

  /// Gets messages from chat.
  Future<Json> getMessagesChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getMessagesChat', body, options);

  /// Gets messages from row ID.
  Future<Json> getMessagesFromRowId(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getMessagesFromRowId', body, options);

  /// Gets number profile.
  Future<Json> getNumberProfile(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getNumberProfile', body, options);

  /// Gets phone number by LID.
  Future<Json> getPhoneNumberByLid(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getPhoneNumberByLid', body, options);

  /// Gets platform from message.
  Future<Json> getPlatformFromMessage(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getPlatformFromMessage', body, options);

  /// Gets products.
  Future<Json> getProducts([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getProducts', body, options);

  /// Gets profile picture.
  Future<Json> getProfilePic(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getProfilePic', body, options);

  /// Gets reactions.
  Future<Json> getReactions(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('getReactions', body, options);

  /// Gets status.
  Future<Json> getStatus([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getStatus', body, options);

  /// Gets unread messages.
  Future<Json> getUnreadMessages([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getUnreadMessages', body, options);

  /// Gets WID.
  Future<Json> getWid([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getWid', body, options);

  /// Checks if authenticated.
  Future<Json> isAuthenticated([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('isAuthenticated', body, options);

  /// Checks if connected.
  Future<Json> isConnected([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('isConnected', body, options);

  /// Checks if logged in.
  Future<Json> isLoggedIn([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('isLoggedIn', body, options);

  /// Checks if multi-device.
  Future<Json> isMultiDevice([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('isMultiDevice', body, options);

  /// Joins a group.
  Future<Json> joinGroup(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('joinGroup', body, options);

  /// Joins WhatsApp Web Beta.
  Future<Json> joinWebBeta([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('joinWebBeta', body, options);

  /// Leaves a group.
  Future<Json> leaveGroup(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('leaveGroup', body, options);

  /// Loads earlier messages.
  Future<Json> loadEarlierMessages(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('loadEarlierMessages', body, options);

  /// Marks message as played.
  Future<Json> markPlayed(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('markPlayed', body, options);

  /// Opens a chat.
  Future<Json> openChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('openChat', body, options);

  /// Promotes community participant.
  Future<Json> promoteCommunityParticipant(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('promoteCommunityParticipant', body, options);

  /// Promotes participant.
  Future<Json> promoteParticipant(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('promoteParticipant', body, options);

  /// Removes group icon.
  Future<Json> removeGroupIcon(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('removeGroupIcon', body, options);

  /// Removes participant.
  Future<Json> removeParticipant(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('removeParticipant', body, options);

  /// Removes subgroups from community.
  Future<Json> removeSubgroupsCommunity(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('removeSubgroupsCommunity', body, options);

  /// Replies to a message.
  Future<Json> reply(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('reply', body, options);

  /// Restarts session.
  Future<Json> restartSession([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('restartSession', body, options);

  /// Sets group description.
  Future<Json> setGroupDescription(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('setGroupDescription', body, options);

  /// Sets group picture.
  Future<Json> setGroupPic(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('setGroupPic', body, options);

  /// Sets group property.
  Future<Json> setGroupProperty(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('setGroupProperty', body, options);

  /// Sets group subject.
  Future<Json> setGroupSubject(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('setGroupSubject', body, options);

  /// Sets messages admins only.
  Future<Json> setMessagesAdminsOnly(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('setMessagesAdminsOnly', body, options);

  /// Sets profile name.
  Future<Json> setProfileName(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('setProfileName', body, options);

  /// Sets profile picture.
  Future<Json> setProfilePic(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('setProfilePic', body, options);

  /// Sets temporary messages.
  Future<Json> setTemporaryMessages(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('setTemporaryMessages', body, options);

  /// Sets theme.
  Future<Json> setTheme(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('setTheme', body, options);

  /// Starts phone watchdog.
  Future<Json> startPhoneWatchdog([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('startPhoneWatchdog', body, options);

  /// Stops phone watchdog.
  Future<Json> stopPhoneWatchdog([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('stopPhoneWatchdog', body, options);

  /// Verifies a number.
  Future<Json> verifyNumber(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('verifyNumber', body, options);

  /// Gets WhatsApp versions.
  Future<Json> whatsappVersions([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('whatsapp-versions', body, options);

  /// Creates a community.
  Future<Json> createCommunity(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('createCommunity', body, options);

  /// Creates a group.
  Future<Json> createGroup(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('createGroup', body, options);

  /// Deactivates community.
  Future<Json> deactivateCommunity(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('deactivateCommunity', body, options);

  /// Deletes a chat.
  Future<Json> deleteChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('deleteChat', body, options);

  /// Deletes a message.
  Future<Json> deleteMessage(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('deleteMessage', body, options);

  /// Downloads media by message.
  Future<Json> downloadMediaByMessage(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('downloadMediaByMessage', body, options);

  /// Forwards messages.
  Future<Json> forwardMessages(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('forwardMessages', body, options);

  /// Gets all broadcast lists.
  Future<Json> getAllBroadcastList([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('getAllBroadcastList', body, options);

  /// Adds participant.
  Future<Json> addParticipant(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('addParticipant', body, options);

  /// Adds subgroups to community.
  Future<Json> addSubgroupsCommunity(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('addSubgroupsCommunity', body, options);

  /// Approves group membership request.
  Future<Json> approveGroupMembershipRequest(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('approveGroupMembershipRequest', body, options);

  /// Archives a chat.
  Future<Json> archiveChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('archiveChat', body, options);

  /// Clears a chat.
  Future<Json> clearChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('clearChat', body, options);

  /// Closes a chat.
  Future<Json> closeChat(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('closeChat', body, options);

  /// Demotes community participant.
  Future<Json> demoteCommunityParticipant(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('demoteCommunityParticipant', body, options);

  /// Demotes participant.
  Future<Json> demoteParticipant(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('demoteParticipant', body, options);

  /// Gets fila (queue).
  Future<Json> fila([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('fila', body, options);

  /// Executes any action asynchronously via queue: `POST /whatsapp/{action}/queue`.
  Future<Json> queue(String action, [Json? body, RequestOptions options = const RequestOptions()]) {
    final path = 'whatsapp/$action/queue';
    return http.post(path, body, options);
  }
}