import 'package:flutter/material.dart';
import 'package:songtrace/helpers/STColors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: STColors.darkBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('kishore.jpeg'),
                backgroundColor: STColors.navyBlue,
              ),
              const SizedBox(height: 16),
              const Text(
                'User Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '@bittrozki',
                style: TextStyle(
                  color: STColors.brightOrange,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),

              // Followers and Following Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const ProfileStat(title: 'Followers', count: '1.2K'),
                  VerticalDivider(
                    color: Colors.white.withOpacity(0.5),
                    thickness: 1,
                    width: 20,
                  ),
                  const ProfileStat(title: 'Following', count: '350'),
                ],
              ),
              const SizedBox(height: 32),

              // Playlists Section
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: STColors.navyBlue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Playlists',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5, // Replace with dynamic playlist count
                          itemBuilder: (context, index) {
                            return PlaylistTile(
                              title: 'Playlist ${index + 1}',
                              songCount: '${(index + 1) * 10} songs',
                              imageUrl:
                                  'phonk.png', // Replace with playlist image URL
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String title;
  final String count;

  const ProfileStat({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class PlaylistTile extends StatelessWidget {
  final String title;
  final String songCount;
  final String imageUrl;

  const PlaylistTile({
    required this.title,
    required this.songCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                songCount,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
