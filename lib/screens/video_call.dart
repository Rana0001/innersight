import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:innersight/app/constant.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

class Meeting extends StatefulWidget {
  static String routeName = "/meeting";
  const Meeting({Key? key}) : super(key: key);

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "InnerSight Consultant Room");
  final subjectText = TextEditingController(text: "Psychologtheraphy Class");
  final tokenText = TextEditingController();
  final userDisplayNameText = TextEditingController();
  final userEmailText = TextEditingController(text: Constant.patient.email);
  final userAvatarUrlText =
      TextEditingController(text: Constant.patient.profileUrl);

  bool isAudioMuted = true;
  bool isAudioOnly = false;
  bool isVideoMuted = true;

  String? callType;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    callType = ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 48,
        leadingWidth: 48,
        title: const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'Meeting Room',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )),
        leading: Container(
          height: 30,
          width: 30,
          margin: const EdgeInsets.only(left: 16, top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            padding: const EdgeInsets.only(left: 7),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 13,
              color: Color(0xff677294),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              const Spacer(flex: 59),
              const Spacer(flex: 1),
              SvgPicture.asset(
                'assets/svg/meetImage.svg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
              const Spacer(flex: 65),
              Container(
                margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: const Text(
                  "Join the Meet",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(flex: 65),
              Container(
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xfff3f3f3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: userDisplayNameText,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon: Icon(Icons.person, color: Colors.black),
                      hintText: "Enter your name"),
                ),
              ),
              const Spacer(flex: 58),
              const SizedBox(
                width: 350,
                child: Text(
                  "Meet Guidelines -\n1) For privacy reasons you may change your name if you want.\n2) By default your audio & video are muted.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff898989),
                  ),
                ),
              ),
              const Spacer(flex: 58),
              Row(
                children: [
                  const Spacer(flex: 32),
                  GestureDetector(
                    onTap: () {
                      _onAudioMutedChanged(!isAudioMuted);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          color: isAudioMuted
                              ? const Color(0xffD64467)
                              : const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.06),
                                offset: const Offset(0, 4)),
                          ]),
                      width: 72,
                      height: 72,
                      child: Icon(
                        isAudioMuted
                            ? Icons.mic_off_sharp
                            : Icons.mic_none_sharp,
                        color: isAudioMuted ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(flex: 16),
                  callType != "Video"
                      ? const Text("")
                      : GestureDetector(
                          onTap: () {
                            _onVideoMutedChanged(!isVideoMuted);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                color: isVideoMuted
                                    ? const Color(0xffD64467)
                                    : const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.06),
                                      offset: const Offset(0, 4)),
                                ]),
                            width: 72,
                            height: 72,
                            child: Icon(
                              isVideoMuted
                                  ? Icons.videocam_off_sharp
                                  : Icons.videocam,
                              color: isVideoMuted ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                  const Spacer(flex: 16),
                  GestureDetector(
                    onTap: () {
                      _joinMeeting(); // Join meet on tap
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            color: const Color(0xffAA66CC),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.06),
                                  offset: const Offset(0, 4)),
                            ]),
                        width: 174,
                        height: 72,
                        child: const Center(
                          child: Text(
                            "JOIN MEET",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                  const Spacer(flex: 32),
                ],
              ),
              const Spacer(flex: 38),
            ],
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value!;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value!;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value!;
    });
  }

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    Map<String, Object> featureFlags = {};

    // Define meetings options here
    var options = JitsiMeetingOptions(
      roomNameOrUrl: roomText.text,
      serverUrl: serverUrl,
      subject: subjectText.text,
      token: tokenText.text,
      isAudioMuted: isAudioMuted,
      isAudioOnly: isAudioOnly,
      isVideoMuted: isVideoMuted,
      userDisplayName: userDisplayNameText.text,
      userEmail: userEmailText.text,
      featureFlags: featureFlags,
    );

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
            "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
            "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText),
    );
  }
}
