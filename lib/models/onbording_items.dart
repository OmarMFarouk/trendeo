import 'package:trendeo/core/image_app.dart';
import 'package:trendeo/models/onbording_info.dart';
   
 final onbordingItems = OnbordingItems();
class OnbordingItems {
  List<OnbordingInfo> items = [
    // 1 - The advantage of seeing other people's ideas
    OnbordingInfo(
      image: imageApp.viowPost,
      titel: "Watch other people's ideas",
      description:
          "You can see everything others share on Trindro freely and easily...another world",
    ),

    // 2 - The advantage of sharing your ideas with others
    OnbordingInfo(
      image: imageApp.sharePost,
      titel: "Share your thoughts too",
      description:
          "You can now share all your thoughts and everything you think about so that others can see it",
    ),

    // 3 - Feature of artificial intelligence conversation
    OnbordingInfo(
      image: imageApp.chatAi,
      titel: "Enjoy trendeo AI chat",
      description:
          "You can now share all your thoughts and everything you think about so that others can see it",
    ),

    // 4 - Conversations feature
    OnbordingInfo(
      image: imageApp.chatPeople,
      titel: "Enjoy a text conversation",
      description:
          "The best and fastest experience for text conversations compared to other applications",
    ),

    // 5 - Video calling feature
    OnbordingInfo(
      image: imageApp.videoCall,
      titel: "Fantasy video call",
      description:
          "Voice and video calls are one of the most important features of the application. Where accuracy and speed",
    ),

    // 6 - High security feature of the application
    OnbordingInfo(
      image: imageApp.secureAccount,
      titel: "Highest protection",
      description:
          "Trendeo cares about protecting your personal information and conversations.",
    ),
  ];
}

final controller = OnbordingItems();
