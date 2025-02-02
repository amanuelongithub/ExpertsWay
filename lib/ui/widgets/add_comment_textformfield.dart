import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expertsway/models/comments_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' as material;

// ignore: must_be_immutable
class AddCommentTextFormField extends StatelessWidget {
  TextEditingController commentController = TextEditingController();

  AddCommentTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Com>(builder: (context, data, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/images/p2.jpg",
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CupertinoTextField(
                    minLines: 2,
                    maxLines: 3,
                    controller: commentController,
                    placeholder: "Share something Nardos Tamirat",
                    placeholderStyle: const TextStyle(fontSize: 14),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                        color: material.Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 25,
                            offset: Offset(0, 10),
                            color: Color(0x1A636363),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                onPressed: () {
                  data.addComment(Comment(
                    date: "8",
                    firstName: "Nardos Tamirat",
                    imageUrl: "assets/images/p2.jpg",
                    like: 1,
                    liked: false,
                    disLike: 3,
                    reply: [],
                    message: commentController.text,
                  ));
                },
                child: const Text("Post"))
          ],
        ),
      );
    });
  }
}
