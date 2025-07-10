import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/chatbot/data_chat_bot.dart';
import 'package:p/screens/chatbot/models/suggest_text.dart';
import 'package:p/screens/chatbot/widgets/chat_message.dart';
import 'package:p/screens/chatbot/widgets/suggest_item.dart';
import 'package:p/screens/events_details/presentation/pages/event_details_view_body.dart';
import 'package:p/screens/trip_details/views/trip_details_view_body.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final signalR = SignalRService();
  final TextEditingController controller = TextEditingController();
  List<ChatMessage> messages = [];
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    signalR.startConnection();

    signalR.onMessageReceived = (msg) {
      setState(() {
        messages.add(msg); // الآن msg هو ChatMessage
      });
      _scrollToBottom();
    };
  }
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Future<void> _startChat() async {
  //   await signalR.startConnection();
  //   signalR.listenToMessages((user, message) {
  //     setState(() {
  //       messages.add(ChatMessage(
  //         sender: user,
  //         message: message,
  //         timestamp: DateTime.now(),
  //       ));
  //     });
  //   });
  // }
  //
  // void _sendMessage() {
  //   final text = controller.text.trim();
  //   if (text.isEmpty) return;
  //
  //   signalR.sendMessage(text); // ← بدون user
  //
  //   setState(() {
  //     messages.add(ChatMessage(
  //       sender: 'Me',
  //       message: text,
  //       timestamp: DateTime.now(),
  //     ));
  //     controller.clear();
  //   });
  // }



  Widget _buildChatBubble(ChatMessage msg) {
    final isMe = msg.sender == 'Me';

    return Container(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe)
                CircleAvatar(
                  backgroundColor: ColorApp.primaryColor,
                  radius: 20.r,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/ai.png",
                      fit: BoxFit.cover,
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                ),
              Flexible(
                child: BubbleSpecialTwo(
                  text: msg.message,
                  color: isMe
                      ? Colors.grey.withOpacity(.3)
                      : ColorApp.primaryColor,
                  tail: true,
                  isSender: isMe,
                  textStyle: TextStyle(
                    color: isMe ? Colors.black : Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              if (isMe)
                CircleAvatar(
                  radius: 20.r,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/profile.jpg",
                      fit: BoxFit.cover,
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                ),
            ],
          ),

          // 🕒 Timestamp
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('MM/dd/yyyy, hh:mm a')
                      .format(msg.timestamp)
                      .toString()
                      .substring(12),
                  style: TextStyle(
                      color: Colors.black.withOpacity(.5), fontSize: 11.sp),
                ),
                Icon(
                  Icons.check,
                  color: Colors.black.withOpacity(.5),
                  size: 17.w,
                )
              ],
            ),
          ),

          if (!isMe && (msg.events != null || msg.travels != null))
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Column(
                children: [
                  if (msg.events != null) ..._buildCards(msg.events!, 'event'),
                  if (msg.travels != null) ..._buildCards(msg.travels!, 'travel'),
                ],
              ),
            ),

        ],
      ),
    );
  }
  List<Widget> _buildCards(List<dynamic> items, String type) {
    return items.map((item) {
      final map = item as Map<String, dynamic>;

      final imageUrl = type == 'event'
          ? map['image']
          : map['coverImageUrl'];

      final title = map['title'] ?? 'No Title';

      final subtitle = type == 'event'
          ? (map['dates'] ??map["date"] )
          : (map['description'] ?? 'No Description');

      return GestureDetector(
        onTap: () {
          if (type == 'event') {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => EventDetailsViewBody(id: map['id'].toString()),
            ));
          } else {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => TripDetailsViewBody(id: map['id'].toString()),
            ));
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  imageUrl ?? '',
                  width: 90.w,
                  height: 70.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 90.w,
                    height: 70.h,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
  }



  @override
  void dispose() {
    signalR.stopConnection();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r),
            ),
          ),
          backgroundColor: ColorApp.primaryColor,
          toolbarHeight: 80.h,
          leading: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new,
                    color: ColorApp.secondaryColor, size: 30.w),
              ),
              Image.asset("assets/images/ai.png"),
            ],
          ),
          leadingWidth: 130.w,
          titleSpacing: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Main Title",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.sp),
              ),
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.lightGreen, size: 13.w),
                  Text("Online",
                      style:
                          TextStyle(color: Colors.lightGreen, fontSize: 12.sp)),
                ],
              )
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.remove_circle_outline_outlined,
                    color: Colors.white),
              ),
            )
          ],
        ),
        backgroundColor: ColorApp.secondaryColor,
        body: Column(
          children: [
            SizedBox(height: 15.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (_, index) {
                      return _buildChatBubble(messages[index]);
                    },
                  ),

              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 0.h),
                  // DefaultTabController(
                  //   length: suggestLable.length,
                  //   child: TabBar(
                  //     tabs: suggestLable
                  //         .map((e) => SuggestItem(lable: e.suggestion))
                  //         .toList(),
                  //     dividerColor: Colors.transparent,
                  //     unselectedLabelColor: Colors.black,
                  //     isScrollable: true,
                  //     indicatorColor: Colors.transparent,
                  //     labelStyle: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 15.sp,
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: TextFormField(
                      controller: controller,
                      cursorColor: ColorApp.primaryColor,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            final text = controller.text.trim();
                            if (text.isEmpty) return;

                            signalR.sendMessage(text);

                            setState(() {
                              messages.add(ChatMessage(
                                sender: 'Me',
                                message: text,
                                timestamp: DateTime.now(),
                              ));
                              controller.clear();
                            });
                            _scrollToBottom();
                          }
,
                          icon: Icon(
                            Icons.send_outlined,
                            color: Colors.blue.withOpacity(.7),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        fillColor: Colors.grey.withOpacity(.3),
                        filled: true,
                        hintText: "Type your message here",
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(.5)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
