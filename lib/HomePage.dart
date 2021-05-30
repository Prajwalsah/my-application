import 'package:authentification/Start.dart';
import 'package:authentification/drawer_screen/main_drawer.dart';
import 'package:authentification/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:authentification/models/channel_model.dart';
import 'package:authentification/models/video_model.dart';
import 'package:authentification/services/api_service.dart';
import 'video_screen.dart';
import 'package:authentification/bottom_bar/report.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCBZQJdIqdOmyVfZnCq7C5JA');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel.subscriberCount} subscribers',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),

      drawer: MainDrawer(),

      body: _channel != null
          ? NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollDetails) {
          if (!_isLoading &&
              _channel.videos.length != int.parse(_channel.videoCount) &&
              scrollDetails.metrics.pixels ==
                  scrollDetails.metrics.maxScrollExtent) {
            _loadMoreVideos();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: 1 + _channel.videos.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _buildProfileInfo();
            }
            Video video = _channel.videos[index - 1];
            return _buildVideo(video);
          },
        ),
      )
          : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor, // Red
          ),
        ),
      ),
    );
  }
}

































// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//
//
//   int currentIndex = 0;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User user;
//   bool isloggedin = false;
//
//   checkAuthentification() async {
//     _auth.authStateChanges().listen((user) {
//       if (user == null) {
//         Navigator.of(context).pushReplacementNamed("start");
//       }
//     });
//   }
//
//   getUser() async {
//     User firebaseUser = _auth.currentUser;
//     await firebaseUser?.reload();
//     firebaseUser = _auth.currentUser;
//
//     if (firebaseUser != null) {
//       setState(() {
//         this.user = firebaseUser;
//         this.isloggedin = true;
//       });
//     }
//   }
//   signOut() async {
//     _auth.signOut();
//
//     final googleSignIn = GoogleSignIn();
//     await googleSignIn.signOut();
//   }
//   @override
//   void initState() {
//     super.initState();
//     this.checkAuthentification();
//     this.getUser();
//   }
//
//
//   _buildProfileInfo() {
//     return Container(
//       margin: EdgeInsets.all(20.0),
//       padding: EdgeInsets.all(20.0),
//       height: 100.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             offset: Offset(0, 1),
//             blurRadius: 6.0,
//           ),
//         ],
//       ),
//       child: Row(
//         children: <Widget>[
//           CircleAvatar(
//             backgroundColor: Colors.white,
//             radius: 35.0,
//             backgroundImage: NetworkImage(_channel.profilePictureUrl),
//           ),
//           SizedBox(width: 12.0),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   _channel.title,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   '${_channel.subscriberCount} subscribers',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: BottomNavyBar(
//           selectedIndex: currentIndex,
//           onItemSelected: (index){
//             setState(() {
//               currentIndex = index;
//             });
//           },
//           items: <BottomNavyBarItem>[
//             BottomNavyBarItem(
//               icon: Icon(Icons.home),
//               title: Text('Home'),
//               activeColor: Colors.green,
//               inactiveColor: Colors.black,
//             ),
//             BottomNavyBarItem(
//               icon: Icon(Icons.calculate),
//               title: Text('Report'),
//               activeColor: Colors.green,
//               inactiveColor: Colors.black,
//             ),
//             BottomNavyBarItem(
//               icon: Icon(Icons.history),
//               title: Text('History'),
//               activeColor: Colors.green,
//               inactiveColor: Colors.black,
//             )
//           ],
//         ),
// //         appBar: AppBar(
//           backgroundColor: Colors.green[700],
//           actions: <Widget>[
//           ],
//           title: Text("GeoMit"),
//         ),
//         drawer: MainDrawer(),
//         //bottomNavigationBar: BottomTab(),
//
//         body: Container(
//       child: !isloggedin
//           ? CircularProgressIndicator()
//           : Column(
//               children: <Widget>[
//                 SizedBox(height: 40.0),
//                 Container(
//                   height: 300,
//                   // child: Image(
//                   //   image: AssetImage("images/home.jpg"),
//                   //   fit: BoxFit.contain,
//                   // ),
//                 ),
//                 Container(
//                   child: Text(
//                     "Hello ${user.displayName} you are Logged in as ${user.email}",
//                     style:
//                         TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 RaisedButton(
//                   padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
//                   onPressed: signOut,
//                   child: Text('Signout',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold)),
//                   color: Colors.green,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                 )
//               ],
//             ),
//     )
//     );
//   }
// }
//
