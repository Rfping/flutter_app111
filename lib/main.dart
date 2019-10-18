import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: Scaffold(
       appBar:AppBar(title:Text('丢骰子') ,
        centerTitle: true,
        backgroundColor: Colors.green,
       
      ),
      
       body:MyHomePage(),
    backgroundColor: Colors.green
    ));
  }
}
      

class MyHomePage extends StatefulWidget {  
  @override  
  _MyHomePageState createState() => _MyHomePageState();
  }
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {  
  var diceleft = 1, diceright = 1;  
  static AudioCache audioCache = AudioCache();  
  static AudioPlayer audioPlayerWithCache;  
  static AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);  
  
  @override  
  Widget build(BuildContext context) {    
    return Center(      
      child: Row(        
        children: <Widget>[          
          Expanded(            
            child: FlatButton(              
              child: Image.asset('images/dice$diceleft.png'),              
              onPressed: _buttonClick,            
              ),          
            ),          
          Expanded(            
            child: FlatButton(              
              child: Image.asset('images/dice$diceright.png'),              
              onPressed: _buttonClick,            
              ),          
            ),        
          ],      
        ),    
      );  
    } 
@override  
void initState() {    
  super.initState();    
  _buttonClick();    
  WidgetsBinding.instance.addObserver(this);    
  _playCacheAudio();    
  print('播放背景音乐成功');  
  }  
  
@override  
void dispose() {    
  super.dispose();   
   _pauseCacheAudio();    
   print('dispose - do stop music');    
   WidgetsBinding.instance.removeObserver(this);  
   }  
   
@override  
void didChangeAppLifecycleState(AppLifecycleState state) {    
  switch (state) {      
    case AppLifecycleState.inactive:
    _stopHttpsAudio();        
    break;      
    case AppLifecycleState.resumed:        
    _resumeCacheAudio();        
    break;      
    case AppLifecycleState.paused:        
    _pauseCacheAudio();        
    break;      
    case AppLifecycleState.suspending: 
    _playHttpsAudio();       
    break;    
    }  
  }  
  
  _playCacheAudio() async {    
    audioPlayerWithCache =        
    await audioCache.loop('backgroundAudio.mp3', volume: 0.5);  
    }  

  _pauseCacheAudio() async {    
    audioPlayerWithCache.pause();  
    }  
      
  _resumeCacheAudio() async {    
    await audioPlayerWithCache.resume();  
    }
  _playHttpsAudio() async {    
      int result = await audioPlayer.play(        
        'https://netx-teaching-resource.oss-cn-shenzhen.aliyuncs.com/flutter/video/backgroundAudio.mp3');    
      if (result == 1) {      
          // success      
      audioPlayer.setReleaseMode(ReleaseMode.LOOP);    
    }  
  }  
  _stopHttpsAudio() async {   
       int result = await audioPlayer.stop();    
       if (result == 1) {      
         // success      
         audioPlayer.setReleaseMode(ReleaseMode.RELEASE);    
         }  
        }  
        
      void _buttonClick() {    
        print('button click');    
        AudioCache audioPlayer1 = AudioCache();    
        audioPlayer1.play('throwdice.mp3');    
        
        setState(() {      
          this.diceleft = Random().nextInt(6) + 1;      
          this.diceright = Random().nextInt(6) + 1;    
        });  
      }
     }







