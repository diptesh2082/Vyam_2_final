class BoardInfo {
  final String imageAssets;

  BoardInfo(this.imageAssets);
}

class OptionsInfo {
  final String imageAssets;
  final String type;

  OptionsInfo(this.imageAssets, this.type);
}

class ProductGym {
  final String imageAssets;
  final String name;
  final String address;
  final String rating;
  final String distance;

  ProductGym(
      {required this.imageAssets, required this.name, required this.address, required this.rating, required this.distance});
}
