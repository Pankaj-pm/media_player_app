import 'package:assets_audio_player/assets_audio_player.dart';

List<Audio> files = [
  Audio.network(
    'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3',
    metas: Metas(
        id: 'Online',
        title: 'Online',
        artist: 'Florent Champigny',
        album: 'OnlineAlbum',
        image: MetasImage.asset("assets/images/country.jpg")),
  ),
  Audio.liveStream(
    'http://mediaserv30.live-streams.nl:8086/live',
    metas: Metas(
        id: 'Online',
        title: 'Youtube',
        artist: 'Florent Champigny',
        album: 'OnlineAlbum',
        image: MetasImage.asset("assets/images/country.jpg")),
  ),
  Audio(
    'assets/audios/rock.mp3',
    //playSpeed: 2.0,
    metas: Metas(
      id: 'Rock',
      title: 'Rock',
      artist: 'Florent Champigny',
      album: 'RockAlbum',
      image: MetasImage.network('https://static.radio.fr/images/broadcasts/cb/ef/2075/c300.png'),
    ),
  ),
  Audio(
    'assets/audios/2 country.mp3',
    metas: Metas(
      id: 'Country',
      title: 'Country',
      artist: 'Florent Champigny',
      album: 'CountryAlbum',
      image: MetasImage.asset('assets/images/country.jpg'),
    ),
  ),
  Audio(
    'assets/audios/electronic.mp3',
    metas: Metas(
      id: 'Electronics',
      title: 'Electronic',
      artist: 'Florent Champigny',
      album: 'ElectronicAlbum',
      image: MetasImage.network(
          'https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/12/attachment_68585523.jpg'),
    ),
  ),
  Audio(
    'assets/audios/hiphop.mp3',
    metas: Metas(
      id: 'Hiphop',
      title: 'HipHop',
      artist: 'Florent Champigny',
      album: 'HipHopAlbum',
      image:
      MetasImage.network('https://beyoudancestudio.ch/wp-content/uploads/2019/01/apprendre-danser.hiphop-1.jpg'),
    ),
  ),
  Audio(
    'assets/audios/pop%20test.mp3',
    metas: Metas(
      id: 'Pop',
      title: 'Pop',
      artist: 'Florent Champigny',
      album: 'PopAlbum',
      image: MetasImage.network(
          'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
    ),
  ),
  Audio(
    'assets/audios/instrumental.mp3',
    metas: Metas(
      id: 'Instrumental',
      title: 'Instrumental',
      artist: 'Florent Champigny',
      album: 'InstrumentalAlbum',
      image: MetasImage.network(
          'https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/12/attachment_68585523.jpg'),
    ),
  ),
];