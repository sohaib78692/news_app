
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/theme/app_colors.dart';
import 'package:news/modules/home/models/news_model.dart';
import 'package:shimmer/shimmer.dart';

class DetailView extends StatelessWidget {
  final NewsModel model;
  const DetailView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
        return SafeArea(
          child: Scaffold(
              body: Container(
                color: const Color.fromARGB(255, 50, 163, 255),
          height: size.height,
          width: size.width,
          child:  SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment : Alignment.centerLeft,
                  child: IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: size.width/1.05,
                  child: Text(
                    model.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ),

                Container(
                  height: size.height/4,
                  width: size.width/1.05,
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                        imageUrl:model.imageUrl,
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
                SizedBox(
                  width: size.width/1.05,
                  child: Text(
                    model.content,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            )
             ),
              ),
            ),
        );
    
  }
}