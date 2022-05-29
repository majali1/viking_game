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

enum SessionTime { min15, min30, min45, min60 }
extension SessionTimeExtension on SessionTime {
  int get value {
    switch(this){
      case SessionTime.min15:
        return 15;
      case SessionTime.min30:
        return 30;
      case SessionTime.min45:
        return 45;
      case SessionTime.min60:
        return 60;
    }
  }
}
