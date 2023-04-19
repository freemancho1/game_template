class Song {
  final String filename;
  final String name;
  final String? artist;
  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}

// Todo: 어떻게 사용하는지 확인할 것.
const Set<Song> songs = {
  /// 파일이름에 공백이 있으면 iOS에서 작동이 안되기 때문에 공백없이 사용함
  Song('Mr_Smith-Azul.mp3', 'Azul', artist: 'Mr Smith'),
  Song('Mr_Smith-Sonorus.mp3', 'Sonorus', artist: 'Mr Smith'),
  Song('Mr_Smith-Sunday_Solitude.mp3', 'SundaySolitude', artist: 'Mr Smith'),
};