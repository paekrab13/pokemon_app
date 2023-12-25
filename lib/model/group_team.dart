import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GroupTeam extends StatelessWidget {
  String? nameTeam;
  String? memberName;
  String? memberImg;
  int indexData;
  GroupTeam({super.key, this.nameTeam, this.memberName, this.memberImg, this.indexData = 0});

  @override
  Widget build(BuildContext context) {
    print('check $indexData');
    return Card(
      color: const Color.fromARGB(255, 165, 68, 255).withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
          child: Column(
        children: [
          const SizedBox(height: 10),
          Text(nameTeam ?? ''),
          const SizedBox(height: 10),
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.4),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: indexData,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CachedNetworkImage(
                            imageUrl: memberImg![indexData],
                            height: 70,
                            fit: BoxFit.fitHeight,
                            placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                )),
                        Text(memberName![indexData],
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ))
                      ],
                    )
                  ],
                );
              })
        ],
      )),
    );
  }
}
