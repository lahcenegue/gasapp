import 'ads_model.dart';

class AdsViewModel {
  final AdsModel _adsModel;
  AdsViewModel({required AdsModel adsModel}) : _adsModel = adsModel;

  String get send {
    return _adsModel.send!;
  }

  String get link {
    return _adsModel.adslink!;
  }

  String get image {
    return _adsModel.images!;
  }

  String get adsImage {
    return _adsModel.adsimage!;
  }
}
