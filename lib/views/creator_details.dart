import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dealflow_coding_assignment/models/creator.dart';
import 'package:flutter/material.dart';

class CreatorDetails extends StatelessWidget {
  final Creator creator;

  CreatorDetails(this.creator);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Creator Profile",
            style: const TextStyle(
                fontSize: 28.0,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        backgroundColor: const Color(0xffebcbf4),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const CircleAvatar(
            radius: 10,
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xff710193),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xffebcbf4),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 2 / 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xff710193))),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          foregroundImage: CachedNetworkImageProvider(
                              "https://source.unsplash.com/random/200x<${300 + (int.parse(creator.id!))}>" /*context.watch<HomeController>().creatorsList[index].avatar!*/),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Center(
                      child: Text(
                        "${creator.name!} ${creator.lastName!}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        height: 100,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Net Worth",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              Text(
                                "\$${creator.netWorth!.toString()}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        height: 100,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              Text(
                                creator.followers!.toString(),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 12),
              child: Text(
                "Bio",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 12),
              child: Text(
                creator.bio!,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 12),
              child: Text(
                "Latest posts",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://picsum.photos/id/${Random().nextInt(200)}/200/300',
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width / 3 - 15,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://picsum.photos/id/${Random().nextInt(200)}/200/300',
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width / 3 - 15,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://picsum.photos/id/${Random().nextInt(200)}/200/300',
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width / 3 - 15,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 12.0),
              child: Text(
                "Contact",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 12),
              child: Text(
                creator.email!,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff710193),
                  decoration: TextDecoration.underline
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget locationDisplay(String? country) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, right: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: const Color(0xff710193),
        ),
        Text(
          country!,
          textAlign: TextAlign.end,
        )
      ],
    ),
  );
}
