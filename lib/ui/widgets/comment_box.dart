import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expertsway/models/comments_data.dart';
import 'package:expertsway/ui/widgets/reply_dialog.dart';

Widget commentBox(
    {required Comment comm,
    required BuildContext context,
    required commentIndex,
    required Com data}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                comm.imageUrl,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              )),
          const SizedBox(
            width: 10,
          ),
          Text(
            comm.firstName,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "${comm.date} month ago",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, color: Colors.black45),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Text(comm.message,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 14, color: Colors.black87)),
      const SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: comm.liked ? Colors.blue : Colors.black,
                )),
            const SizedBox(
              width: 20,
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return replyDialog(
                                commentIndex: commentIndex,
                                data: data,
                                context: context);
                          });
                    },
                    child: const Text("Reply")),
                // SizedBox(width: 5,),
                // comm.reply.length == 0 ? SizedBox() : Text(comm.reply.length.toString(), style: TextStyle(fontSize: 18),)
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            const Text("Report"),
          ],
        ),
      )
    ],
  );
}
