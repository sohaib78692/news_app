import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:news/data/repository/home/home_repository.dart';
import 'package:news/modules/home/models/news_model.dart';

class HomeController extends GetxController {
  List<NewsModel> newsList = [];
  RxBool isLoading = true.obs;
  HomeRepository homeRepository = HomeRepository();

  @override
  void onInit() {
    getNewsFeed();
    super.onInit();
  }

  getNewsFeed() async {
    newsList = await homeRepository.getNews();
    isLoading.value = false;
  }

  printData(){
    Fluttertoast.showToast(msg: "dummy toast");
  }
}
