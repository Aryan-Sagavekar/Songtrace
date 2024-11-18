import 'package:spotify/spotify.dart';

class PlaylistData {
  final String id;
  final String name;
  final bool collaborative;
  final String href;
  final String snapshotId;
  final String type;
  final String uri;
  final String description;
  final TracksLink tracksData;
  final List<String> images;

  PlaylistData({
    required this.id,
    required this.name,
    required this.collaborative,
    required this.href,
    required this.snapshotId,
    required this.type,
    required this.uri,
    required this.description,
    required this.tracksData,
    required this.images,
  });

  factory PlaylistData.fromJson(Map<String, dynamic> json) {
    return PlaylistData(
      id: json['id'],
      name: json['name'],
      collaborative: json['collaborative'],
      href: json['href'],
      snapshotId: json['snapshotId'],
      type: json['type'],
      uri: json['uri'],
      description: json['description'],
      tracksData: json['tracksData'],
      images: List<String>.from(json['images']?.map((x) => x) ?? []),
    );
  }
}
