import 'package:audioplayers/audio_cache.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:audio_recorder/audio_recorder.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<UploadPage> {
  File selected_media;
  String selected_audio = "";
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioPlayer recordingPlayer;
  AudioCache audioCache;
  AudioCache recordingCache;
  String audio_recording_location;

  //////
  bool recordingButtonPressed = false;

  void _getMedia() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selected_media = image;
    });
  }

  void _openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      selected_media = image;
    });
  }

  void _getAudio() async {
    var audio = await FilePicker.getFilePath(type: FileType.audio);
    setState(() {
      selected_audio = audio;
    });
  }

  void _getRecordAudio() async {
    var audio = await FilePicker.getFilePath(type: FileType.audio);
    setState(() {
      audio_recording_location = audio;
    });
  }

  void initPlayer(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
    recordingPlayer = new AudioPlayer();
    recordingCache =  new AudioCache(fixedPlayer: recordingPlayer);

    // ignore: deprecated_member_use
    advancedPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });

    // ignore: deprecated_member_use
    advancedPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });
  }

  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
    recordingPlayer.seek(newDuration);
  }

  String timeDisplay(double timeInSeconds){
    int first = (timeInSeconds / 60).floor();
    double second = timeInSeconds - (first * 60);
    return first.toString() + ':' + second.toString();
  }

  void startAudioRecording() async {
    bool hasPermissions = await AudioRecorder.hasPermissions;
    audio_recording_location = null;
    if (hasPermissions){
      await AudioRecorder.start(path: audio_recording_location, audioOutputFormat: AudioOutputFormat.AAC);
    }
  }

  void stopAudioRecording() async {
    Recording recording = await AudioRecorder.stop();
    audio_recording_location = recording.path;
  }

  @override
  void initState(){
    super.initState();
    initPlayer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: selected_media != null ? FileImage(selected_media) : NetworkImage('https://i.ytimg.com/vi/EWsk6P_Me9o/maxresdefault.jpg'),
                fit: BoxFit.cover,
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                      startAngle: 180,
                      angleRange: 360,
                      animationEnabled: true,
                      size: 300,
                      infoProperties: InfoProperties(
                          mainLabelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                          ),
                          modifier: (double timeInSeconds){
                            int first = (timeInSeconds / 60).floor();
                            int second = (timeInSeconds - (first * 60)).floor();
                            String secondString = second.toString();
                            if (second < 10) {
                              secondString = '0' + second.toString();
                            }
                            return first.toString() + ':' + secondString;
                          }
                      ),
                      customWidths: CustomSliderWidths(progressBarWidth: 10.0),
                      customColors: CustomSliderColors(
                        trackColor: Colors.grey[900],
                        dotColor: Colors.black,
                      )
                  ),
                  initialValue: _position.inSeconds.toDouble(),
                  min: 0.0,
                  max: _duration.inSeconds.toDouble(),
                  onChangeEnd: (double value) {
                    setState(() {
                      seekToSecond(value.toInt());
                      value = value;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            recordingButtonPressed = false;
                          });
                          advancedPlayer.stop();
                          recordingPlayer.stop();
                          stopAudioRecording();
                        },
                        child: Icon(Icons.stop, size: 35),
                        backgroundColor: Colors.black,
                      ),
                      SizedBox(width: 10.0),
                      FloatingActionButton(
                        splashColor: Colors.black,
                        onPressed: () {
                          Future.delayed(Duration(milliseconds: 1500), () => advancedPlayer.play((selected_audio)));
                          recordingPlayer.play((audio_recording_location));
                        },
                        child: Icon(Icons.play_arrow, color: Colors.black, size: 35),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 10.0),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            recordingButtonPressed = false;
                          });
                          advancedPlayer.pause();
                          recordingPlayer.pause();
                          stopAudioRecording();
                        },
                        child: Icon(Icons.pause, size: 35),
                        backgroundColor: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.white,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          FloatingActionButton(
                            onPressed: () {_openCamera();},
                            child: Icon(Icons.camera_alt),
                            backgroundColor: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(width: 15.0),
                      Column(
                        children: <Widget>[
                          RaisedButton.icon(
                            onPressed: () {
                              setState(() {
                                recordingButtonPressed = true;
                              });
                              startAudioRecording();
                              if (selected_audio != ""){
                                advancedPlayer.play(selected_audio);
                              }
                            },
                            label: Text('RECORD'),
                            color: recordingButtonPressed ? Colors.amber : Colors.red,
                            icon: Icon(Icons.mic),
                          ),
                          SizedBox(height: 10),
                          FloatingActionButton(
                            onPressed: () {_getAudio();},
                            child: Icon(Icons.library_music),
                            backgroundColor: Colors.black,
                          ),
                          FloatingActionButton(
                            onPressed: () {_getRecordAudio();},
                            child: Icon(Icons.audiotrack),
                            backgroundColor: Colors.black,
                          )
                        ],
                      ),
                      SizedBox(width: 15.0),
                      Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          FloatingActionButton(
                            onPressed: () {_getMedia();},
                            child: Icon(Icons.camera_roll),
                            backgroundColor: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        )
    );
  }
}
