enum Author { server, client }

class Message {
  final Author author;
  final String content;

  Message({required this.author, required this.content});

  bool get isClientMessage => author == Author.client;
}
