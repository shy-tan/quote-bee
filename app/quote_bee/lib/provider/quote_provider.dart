import 'package:flutter/material.dart';
import 'package:quote_bee/db_helper/db_helper.dart';
import '../model/quote_model.dart';

class QuoteProvider extends ChangeNotifier {
  List<QuoteModel> quoteItems = [];

  List<QuoteModel> mapDataListToModel(List<Map> dataList) {
    return dataList
        .map(
          (item) => QuoteModel(
            index: item['index'],
            date: item['Date'],
            tweet: item['Tweet'],
            url: item['URL'],
            likeCount: item['Like Count'],
            retweetCount: item['Retweet Count'],
            favourite: item['Favourite'],
          ),
        )
        .toList();
  }

  // call and implement sql select function
  Future<void> selectData(int index) async {
    if (index == 0) {
      final dataList = await DBHelper.selectRandom();
      quoteItems = mapDataListToModel(dataList);
    } else if (index == 1) {
      final dataList = await DBHelper.selectMostLiked();
      quoteItems = mapDataListToModel(dataList);
    } else if (index == 2) {
      final dataList = await DBHelper.selectMostRetweeted();
      quoteItems = mapDataListToModel(dataList);
    } else {
      final dataList = await DBHelper.selectFavourites();
      quoteItems = mapDataListToModel(dataList);
    }

    notifyListeners();
  }

  Future insertFav(String url, int oldfavStatus) async {
    await DBHelper.insertFav(url, oldfavStatus);
    notifyListeners();
  }
}
