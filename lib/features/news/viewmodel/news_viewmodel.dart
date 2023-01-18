import 'package:ducktor/common/networking/network_client/network_client.dart';
import 'package:ducktor/common/networking/networking_constant.dart';
import 'package:ducktor/features/news/models/news.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsViewModel {
  late final NetworkClient _network;

  NewsViewModel() {
    String host = dotenv.env['HOST'] ?? '';
    String port = dotenv.env['PORT'] ?? '';
    _network = NetworkClient("http://$host:$port");
    fetchNews();
  }

  Future<List<News>?> fetchNews() async {
    const path = 'https://ducktorbackend-1673595226148.azurewebsites.net/news';
    final response = await _network.request(
      RequestMethod.get,
      path,
      null,
      null,
    );

    if (response == null) return null;

    final List<News>? result = response.when(success: (data) {
      return null;
    }, error: (message) {
      return null;
    }, loading: (message) {
      return null;
    });
    return result;
  }
}
