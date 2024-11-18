import 'package:songtrace/keys/keys.dart';
import 'package:songtrace/model/playlist_model.dart';
import 'package:spotify/spotify.dart';

class SpotifyService {
  static SpotifyApi? spotify;

  static void create() async {
    var credentials = SpotifyApiCredentials(clientId, clientSecret);
    spotify = SpotifyApi(credentials);
  }

  static Future<List<Track>> searchTrackInfoByName(
      String trackName, int count) async {
    var searchResult = await spotify!.search.get(trackName).first(count);
    // List<PlaylistData> foundTracks = [];
    List<Track> foundTracks = [];

    for (var pages in searchResult) {
      if (pages.items == null) {
        print('Empty items');
      }

      for (var item in pages.items!) {
        // if (item is PlaylistSimple) {
        //   var playlist = PlaylistData(
        //     id: item.id!,
        //     name: item.name!,
        //     collaborative: item.collaborative ?? false,
        //     href: item.href!,
        //     tracksLink: item.tracksLink!.href!,
        //     snapshotId: item.snapshotId ?? '',
        //     type: item.type ?? 'playlist',
        //     uri: item.uri!,
        //     description: item.description!,
        //     trackCount: item.tracksLink!.total!,
        //     images: item.images?.map((img) => img.url!).toList() ?? [],
        //   );
        // }

        //   foundTracks.add(playlist);

        // print('Playlist Model:');
        // print('ID: ${item.id}');
        // print('Name: ${item.name}');
        // print('Collaborative: ${item.collaborative}');
        // print('Href: ${item.href}');
        // print('Tracks Link: ${item.tracksLink}');
        // print('Owner: ${item.owner!.displayName}');
        // print('Public: ${item.public}');
        // print('Snapshot ID: ${item.snapshotId}');
        // print('Type: ${item.type}');
        // print('URI: ${item.uri}');
        // print('Images Count: ${item.images!.length}');
        // print('-------------------------------');
        // }

        if (item is Track) {
          foundTracks.add(item);

          // print('Track:\n'
          //     'id: ${item.id}\n'
          //     'name: ${item.name}\n'
          //     'href: ${item.href}\n'
          //     'type: ${item.type}\n'
          //     'uri: ${item.uri}\n'
          //     'isPlayable: ${item.isPlayable}\n'
          //     'artists: ${item.artists!.length}\n'
          //     'availableMarkets: ${item.availableMarkets!.length}\n'
          //     'discNumber: ${item.discNumber}\n'
          //     'trackNumber: ${item.trackNumber}\n'
          //     'explicit: ${item.explicit}\n'
          //     'popularity: ${item.popularity}\n'
          //     '-------------------------------');
        }
      }
    }

    return foundTracks;
  }

  static Future<List<PlaylistData>> fetchFeaturedPlaylists() async {
    var searchResult = await spotify!.search.get('Top 100').first(10);
    List<PlaylistData> featuredList = [];

    for (var pages in searchResult) {
      if (pages.items == null) {
        print('Empty items');
      }

      for (var item in pages.items!) {
        if (item is PlaylistSimple) {
          var playlist = PlaylistData(
            id: item.id!,
            name: item.name!,
            collaborative: item.collaborative ?? false,
            href: item.href!,
            snapshotId: item.snapshotId ?? '',
            type: item.type ?? 'playlist',
            uri: item.uri!,
            description: item.description!,
            tracksData: item.tracksLink!,
            images: item.images?.map((img) => img.url!).toList() ?? [],
          );

          featuredList.add(playlist);
        }
      }
    }
    return featuredList;
  }

  static Future<List<Track>> fetchTopSongs() async {
    var searchResult = await spotify!.search.get('linkin').first(10);
    List<Track> topSongsList = [];

    for (var pages in searchResult) {
      if (pages.items == null) {
        print('Empty items');
      }

      for (var item in pages.items!) {
        if (item is Track) {
          // print(item.album!.images![0].url);

          topSongsList.add(item);
        }
      }
    }
    return topSongsList;
  }

  static Future<List<Track>> fetchTracksForAlbum(String albumName) async {
    var searchResult =
        await spotify!.search.get(albumName.substring(0, 2)).first(10);
    List<Track> albumSongsList = [];

    for (var pages in searchResult) {
      if (pages.items == null) {
        print('Empty items');
      }

      for (var item in pages.items!) {
        if (item is Track) {
          // print(item.album!.images![0].url);

          albumSongsList.add(item);
        }
      }
    }
    return albumSongsList;
  }
}
