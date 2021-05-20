// class Config {
//   // static List<PointModel> _chartDataList = [];
//   static bool _isDataloaded = false;

//   static isLoaded() {
//     return _isDataloaded;
//   }

//   static loadChartDataList() async {
//     // fetch data from web ...
//     await loadFromWeb();
//     _isDataloaded = true;
//   }

//   static loadFromWeb() {
//     // but here i will add test data
//     _chartDataList.add(PointModel(pointX: 0, pointY: 24));
//     _chartDataList.add(PointModel(pointX: 12, pointY: 40));
//     _chartDataList.add(PointModel(pointX: 20, pointY: 18));
//     _chartDataList.add(PointModel(pointX: 23, pointY: 30));
//     _chartDataList.add(PointModel(pointX: 40, pointY: 12));
//     _chartDataList.add(PointModel(pointX: 60, pointY: 15));
//   }

//   static getChartDataList() {
//     if (!_isDataloaded) loadChartDataList();
//     return _chartDataList;
//   }
// }
