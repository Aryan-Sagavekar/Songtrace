import 'package:spotify/spotify.dart';

class PlaylistData {
  final String id;
  final String name;
  final bool collaborative;
  final String href;
  final String tracksLink;
  final String snapshotId;
  final String type;
  final String uri;
  final List<String> images;

  PlaylistData({
    required this.id,
    required this.name,
    required this.collaborative,
    required this.href,
    required this.tracksLink,
    required this.snapshotId,
    required this.type,
    required this.uri,
    required this.images,
  });

  factory PlaylistData.fromJson(Map<String, dynamic> json) {
    return PlaylistData(
      id: json['id'],
      name: json['name'],
      collaborative: json['collaborative'],
      href: json['href'],
      tracksLink: json['trackslink'],
      snapshotId: json['snapshotId'],
      type: json['type'],
      uri: json['uri'],
      images: List<String>.from(json['images']?.map((x) => x) ?? []),
    );
  }
}
