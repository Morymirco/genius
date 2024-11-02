import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Implémenter la création d'une nouvelle conversation
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: 10, // Nombre d'exemples de conversations
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ConversationTile(
            title: 'Conversation ${index + 1}',
            lastMessage: 'Dernier message de la conversation ${index + 1}',
            lastMessageTime: DateTime.now().subtract(Duration(minutes: index * 10)),
            unreadCount: index % 3,
          );
        },
      ),
    );
  }
}

class ConversationTile extends StatelessWidget {
  final String title;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const ConversationTile({
    Key? key,
    required this.title,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(title[0].toUpperCase()),
      ),
      title: Text(title),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatDate(lastMessageTime),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        // Implémenter la navigation vers la conversation
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else {
      return '${date.day}/${date.month}';
    }
  }
} 