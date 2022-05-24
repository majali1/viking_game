enum GamesEnum { TicTacToe, Bullseye, Hunter, Drawing }

extension GamesExtenstion on GamesEnum {
  int get value {
    switch (this) {
      case GamesEnum.TicTacToe:
        return 1;
      case GamesEnum.Bullseye:
        return 2;
      case GamesEnum.Hunter:
        return 3;
      case GamesEnum.Drawing:
        return 4;
    }
  }
}

enum ImagePickerSource { fromGallery, fromCamera }
