
class Iconspojo {
  String _name;
  String _image;
  int _activeIcon;
  String _iconid;

  Iconspojo(this._name, this._image, this._activeIcon,this._iconid);

  String get name => _name;

  set name(String name) => _name = name;

  String get image => _image;

  set image(String image) => _image = image;

  int get activeIcon => _activeIcon;

  set activeIcon(int active) => _activeIcon = active;

  String get iconId => _iconid;

  set iconid(String image) => _iconid = image;

}