import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:news/data/values/strings.dart';
import 'package:news/theme/app_colors.dart';
import 'package:news/modules/detail/views/detail_view.dart';
import 'package:news/modules/home/controllers/home_controller.dart';
import 'package:news/modules/home/models/news_model.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
    HomeView({Key? key}) : super(key: key);


   final HomeController homeController = Get.put(HomeController());

  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 50, 163, 255),
        floatingActionButton: FloatingActionButton(onPressed: (){
          homeController.printData();
        }),
        body: Obx(() => SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(children: [
                    SizedBox(
                      height: size.height / 12,
                      width: size.width / 1.1,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: size.width / 4,
                          ),
                          const Text(
                            Strings.newsApp,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    homeController.isLoading.value
                ? SizedBox(
                    height: size.height / 20,
                    width: size.height / 20,
                    child: const CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: homeController.newsList.length,
                        itemBuilder: (context, index) =>
                            listItems(size, context,homeController.newsList[index])))
          ]),
        ),
      ),
    ));
  }
}

Widget listItems(Size size, BuildContext context, NewsModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
    child: GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DetailView(
                model: model,
              ))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: size.width / 1.15,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.black)),
        child: Column(children: [
          Container(
            height: size.height / 4,
            width: size.width / 1.05,
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black, width: 1))),
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: model.imageUrl,
              fit: BoxFit.cover,
              placeholder: (ctx, url) => Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: AppColors.white,
                ),
              ),
              errorWidget: (context, url, error) {
                return Container();
              },
            ),
          ),
          Container(
            width: size.width / 1.1,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              model.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: size.width / 1.1,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              model.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          )
        ]),
      ),
    ),
  );
}
