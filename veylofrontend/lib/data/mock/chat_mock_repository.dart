import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/models/chat/chat_note.dart';
import 'package:veylo/models/chat/chat_thread.dart';

/// Geçici mock — backend hazır olunca repository ile değiştirilir.
class ChatMockRepository {
  const ChatMockRepository._();

  static List<ChatNote> notes() => const [
        ChatNote(
          id: 'note_self',
          userId: 'user_self',
          displayName: 'You',
          statusText: 'Not Ekle',
          avatarUrl: AppAssets.fakePerson03,
          isSelf: true,
          showAddBadge: true,
        ),
        ChatNote(
          id: 'note_lyra',
          userId: 'user_lyra',
          displayName: 'Lyra',
          statusText: 'Can’t Sleep',
          avatarUrl: AppAssets.fakePerson01,
        ),
        ChatNote(
          id: 'note_jessica',
          userId: 'user_jessica',
          displayName: 'Jessica',
          statusText: 'Need Advice',
          avatarUrl: AppAssets.fakePerson05,
        ),
        ChatNote(
          id: 'note_sarah',
          userId: 'user_sarah',
          displayName: 'Sarah',
          statusText: 'Depressed',
          avatarUrl: AppAssets.fakePerson07,
        ),
        ChatNote(
          id: 'note_ella',
          userId: 'user_ella',
          displayName: 'Ella',
          statusText: 'Looking For A Friend',
          avatarUrl: AppAssets.fakePerson02,
        ),
        ChatNote(
          id: 'note_mia',
          userId: 'user_mia',
          displayName: 'Mia',
          statusText: 'Need A Friend',
          avatarUrl: AppAssets.fakePerson04,
        ),
      ];

  static List<ChatThread> threads() => [
        ChatThread(
          id: 'conv_julia',
          peerUserId: 'user_julia',
          title: 'Julia Ivanova',
          lastMessagePreview:
              'Hey! I was about to explode with boredom. What can we do? What do you have in mind?',
          avatarUrl: AppAssets.fakePerson06,
          lastMessageAt: DateTime(2026, 3, 16, 11, 0),
          isOnline: true,
        ),
        ChatThread(
          id: 'conv_sona',
          peerUserId: 'user_sona',
          title: 'Sona Iglesias',
          lastMessagePreview: 'Hey!',
          avatarUrl: AppAssets.fakePerson03,
          lastMessageAt: DateTime(2026, 3, 16, 10, 0),
          isOnline: false,
        ),
        ChatThread(
          id: 'conv_jessica_blues',
          peerUserId: 'user_jessica_blues',
          title: 'Jessica Blues',
          lastMessagePreview:
              'Hey! I was about to explode with boredom. What can we do? What do you have in mind?',
          avatarUrl: AppAssets.fakePerson05,
          lastMessageAt: DateTime(2026, 3, 16, 9, 0),
          isOnline: true,
        ),
        ChatThread(
          id: 'conv_anon_1',
          peerUserId: 'user_anon_1',
          title: 'Anonymous',
          lastMessagePreview:
              'Hello Jhon, it was a pleasure meeting you. Could you tell me a little about yourself?',
          avatarUrl: AppAssets.fakePerson01,
          lastMessageAt: DateTime(2026, 3, 16, 8, 30),
          isAnonymous: true,
          maskedName: 'J***********',
          peerUsername: 'julia_ivanova',
          connectionProgress: 15,
          isOnline: true,
          // Örnek: takip edilmeyen kişiden mesaj → Approve / Block / Reject
          isStrangerRequest: true,
        ),
        ChatThread(
          id: 'conv_anon_2',
          peerUserId: 'user_anon_2',
          title: 'Anonymous',
          lastMessagePreview: 'Want to keep talking?',
          avatarUrl: AppAssets.fakePerson07,
          lastMessageAt: DateTime(2026, 3, 15, 22, 15),
          unreadCount: 2,
          isAnonymous: true,
          maskedName: 'A***********',
          peerUsername: 'mrdrls',
          connectionProgress: 40,
          isOnline: false,
        ),
        // Reveal demo — liste önizlemesi ile progress tutarlı (100%).
        ChatThread(
          id: 'conv_anon_100',
          peerUserId: 'user_reveal',
          title: 'Anonymous',
          lastMessagePreview: 'Ready to reveal profiles?',
          avatarUrl: AppAssets.fakePerson08,
          lastMessageAt: DateTime(2026, 3, 16, 12, 0),
          isAnonymous: true,
          maskedName: 'M***********',
          peerUsername: 'maya_ross',
          connectionProgress: 100,
          isOnline: true,
        ),
      ];
}
