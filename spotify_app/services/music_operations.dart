

import 'package:spotify_app_final/models/music.dart';

class MusicOperations {
  MusicOperations._();
  static List<Music> getMusic() {
    return <Music>[
      Music(
          title: 'Toofan',
          image: 'https://c.ndtvimg.com/2021-03/6kl5pk58_farhans-toofan_625x300_10_March_21.jpg',
          description: 'Dekh Toofan Aaya Hai',
          audio: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'),
      Music(
          title: 'Gully Boy',
          image: 'https://c-cl.cdn.smule.com/rs-s95/arr/44/ec/a14c9db3-f454-4a86-80f0-ac9d42f6e87c_256.jpg',
          description: 'Apna Time Aayega',
          audio: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/ad/53/bf/ad53bf8c-9bf2-90d7-05d4-ec34186f33ff/mzaf_13379019530104319252.plus.aac.p.m4a'),
      Music(
          title: 'Ae Dil Hai Mushkil ',
          image: 'https://c-cl.cdn.smule.com/rs-s-sf-4/arr/5e/ac/80498fa2-60ab-4c61-bf43-61b3df15f546.jpg',
          description: 'Ae Dil Hai Mushkil ',
          audio: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/09/17/bb/0917bbe1-58c3-6252-d00e-9b70d42ef5dc/mzaf_2269500085377778268.plus.aac.p.m4a'),
      Music(
          title: 'Bajirao Mastani',
          image: 'https://c-cl.cdn.smule.com/rs-s92/arr/35/61/65d550a8-6d4e-4837-a067-c65b9e548ad7.jpg',
          description: 'Malhari',
          audio: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/71/f8/b2/71f8b2fd-b62b-55e2-cc4b-d3b0a4e5f0f8/mzaf_16351999812808951944.plus.aac.p.m4a')
    ];
  }
}
