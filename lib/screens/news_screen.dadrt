import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/controllers/news_controller.dart';

class NewsScreen extends StatelessWidget {
  final NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Headlines'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.fetchNews();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.newsList.isEmpty) {
          return Center(child: Text('No news found.'));
        } else {
          return ListView.builder(
            itemCount: controller.newsList.length,
            itemBuilder: (context, index) {
              final article = controller.newsList[index];
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // News Image
                    if (article.urlToImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(
                          article.urlToImage!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: Colors.grey[300],
                              child: Icon(Icons.broken_image, size: 50),
                            );
                          },
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // News Title
                          Text(
                            article.title,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),

                          // News Description
                          if (article.description != null)
                            Text(
                              article.description!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          SizedBox(height: 8),

                          // Published At
                          Text(
                            'Published on: ${article.publishedAt.split("T").first}',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),

                          // Source
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Source: ${article.source.name}',
                              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
