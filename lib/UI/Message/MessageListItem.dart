import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama/Utilities/MSwippWidhet.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MessageListItem extends StatelessWidget {
  final String imageURL;
  final String fullName;
  final DateTime date;
  final String title;
  final String post;
  final bool isSeen;

  const MessageListItem(
      {Key key,
      this.imageURL: "",
      this.fullName,
      this.date,
      this.title,
      this.post,
      this.isSeen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // OnSlide(
        //     items: <ActionItems>[
        //       // new ActionItems(
        //       //     icon: Icon(
        //       //       Icons.delete,
        //       //       color: Colors.red,
        //       //     ),
        //       //     onPress: () {
        //       //       var a = 1;
        //       //     }),
        //       new ActionItems(
        //           icon: Icon(Icons.reply_all, color: Colors.green),
        //           onPress: () {
        //             var b = 1;
        //           }),
        //       new ActionItems(
        //           icon: Icon(Icons.replay, color: Colors.green),
        //           onPress: () {
        //             var b = 1;
        //           })
        //     ],
        //     child:
        Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            //decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40)
            //borderRadius: BorderRadius.all(Radius.circular(13.0))
            // )
            ,
            child: (this.imageURL != null && this.imageURL.isNotEmpty
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 63,
                    width: 63,
                    imageUrl:
                        //"https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png",
                        this.imageURL,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : new Image.asset(
                    'assets/images/no-user.png',
                    fit: BoxFit.cover,
                    height: 63,
                    width: 63,
                  )),
            //     new Image.asset(
            //   'assets/images/no-user.png',
            //   fit: BoxFit.cover,
            //   height: 63,
            //   width: 63,
            // )
          ),
          // Container(
          //   height: 70,
          //   width: 70,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: CachedNetworkImageProvider(
          //               "https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png")),
          //       borderRadius: BorderRadius.all(Radius.circular(13.0))),
          // ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(3, 0, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.title,
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    this.fullName.isNotEmpty ? this.fullName : "",
                    //"مدیر کل امور اداری و منابع انسانی (محمدتقی احمدی دوست مقدم کودهی)",
                    maxLines: 5,
                    style: TextStyle(fontSize: 12, color: Colors.green[800]),
                  ),
                  (this.post.isNotEmpty
                      ? Text(this.post,
                          style:
                              TextStyle(fontSize: 11, color: Colors.blue[300]))
                      : Container(
                          width: 0,
                          height: 0,
                        )),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        format1(Jalali.fromDateTime(this.date)) +
                            " " +
                            this.date.hour.toString() +
                            ":" +
                            this.date.minute.toString(),
                        //"1397/05/25",
                        style: TextStyle(fontSize: 12),
                      ),
                      // Icon(
                      //   Icons.email,
                      //   color: Colors.red,
                      //   size: 18.0,
                      // ),
                      Icon(
                        this.isSeen ? Icons.drafts : Icons.email,
                        color: this.isSeen ? Colors.green : Colors.red,
                        size: 18.0,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    )
        // )
        ;
  }

  String format1(Date d) {
    final f = d.formatter;

    return '${f.wN} ${f.d} ${f.mN} ${f.yyyy}';
  }
}
