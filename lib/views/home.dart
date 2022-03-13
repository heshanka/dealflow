import 'package:dealflow_coding_assignment/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'creator_details.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      FocusScope.of(context).requestFocus(new FocusNode());},
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 11, left: 16, bottom: 20),
                child: CircleAvatar(
                  backgroundColor: Color(0xffebcbf4),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: Color(0xff710193),),
                    onPressed: () { Navigator.pop(context);},
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: const Text(
                "Explore",
                style: TextStyle(
                    fontSize: 28.0,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "50+ Creators",
                style: TextStyle(
                    fontSize: 28.0,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 10),
              child: TextFormField(
                autocorrect: false,
                controller: context.watch<HomeController>().filterController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                focusNode: context.watch<HomeController>().filterNode,
                onFieldSubmitted: (value) async {
                  await context.read<HomeController>().filterCreatorsList(
                      context.read<HomeController>().filterController.text);
                },
                onChanged: (value) async {
                  if(value.isEmpty){
                    await context.read<HomeController>().filterCreatorsList(
                        context.read<HomeController>().filterController.text);
                  }
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_rounded,
                  ),
                  labelText: 'Enter filter term',
                  labelStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: context.watch<HomeController>().creatorsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 100,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatorDetails(context
                                    .watch<HomeController>()
                                    .creatorsList[index])),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 15),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  foregroundImage: CachedNetworkImageProvider(
                                      "https://source.unsplash.com/random/200x<${300 + (int.parse(context.watch<HomeController>().creatorsList[index].id!))}>" /*context.watch<HomeController>().creatorsList[index].avatar!*/),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: locationDisplay(context
                                            .watch<HomeController>()
                                            .creatorsList[index]
                                            .country)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 0,
                                      ),
                                      child: Text(
                                        "${context.watch<HomeController>().creatorsList[index].name!} ${context.watch<HomeController>().creatorsList[index].lastName!}",
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 0,
                                      ),
                                      child: Text(
                                        "Content type: ${context.watch<HomeController>().creatorsList[index].company!}",
                                        style: const TextStyle(
                                            fontSize: 14.0, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ); /*ListTile(
                        leading: Icon(Icons.list),
                        trailing: Text(context.watch<HomeController>().creatorsList[index].name!),
                        title:Text("List item $index")
                    );*/
                  }),
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
        Icon(
          Icons.location_on_outlined,
          color: Color(0xff710193),
        ),
        Text(
          country!,
          textAlign: TextAlign.end,
        )
      ],
    ),
  );
}
