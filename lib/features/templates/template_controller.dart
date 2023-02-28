// import 'dart:async';
// import 'package:confetti/confetti.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:wakelock/wakelock.dart';
// import 'package:toffee_ride/controllers/audio_controller.dart';
// import 'package:toffee_ride/features/templates/template_analytics_helper.dart';
// import 'package:toffee_ride/mixins/base64_mixin.dart';
// import 'package:toffee_ride/mixins/snackbar_mixin.dart';
// import 'package:toffee_ride/models/activity_model.dart';
// import 'package:toffee_ride/features/templates/template_context.dart';
// import 'package:toffee_ride/models/dto/route_dtos/template_response_parameters.dart';
// import 'package:toffee_ride/repository/repository.dart';
// import 'package:toffee_ride/services/user_settings.dart';
// import 'package:toffee_ride/utils/analytics/toffeeride_analytics.dart';
// import 'package:toffee_ride/utils/analytics/tr_learning_analytics.dart';
// import 'package:toffee_ride/utils/utils.dart';

// import '../../mixins/base64_mixin.dart';
// import '../../mixins/snackbar_mixin.dart';

// enum AnalyticsEventSource {
//   system,
//   userClick,
//   userClickPageForward,
//   userClickPageBackward,
//   userClickExitForward,
//   userClickExitBackward,
//   userClickExitSkip,
// }

// extension AnalyticsEventSourceExtension on AnalyticsEventSource {
//   String get desciption {
//     switch (this) {
//       case AnalyticsEventSource.system:
//         return 'system';
//       case AnalyticsEventSource.userClick:
//         return 'user_click';
//       case AnalyticsEventSource.userClickPageForward:
//         return 'user_click_page_forward';
//       case AnalyticsEventSource.userClickPageBackward:
//         return 'user_click_page_backward';
//       case AnalyticsEventSource.userClickExitForward:
//         return 'user_click_exit_forward';
//       case AnalyticsEventSource.userClickExitBackward:
//         return 'user_click_exit_backward';
//       case AnalyticsEventSource.userClickExitSkip:
//         return 'user_click_exit_skip';
//     }
//   }
// }

// class TemplateController extends SuperController
//     with SnackbarMixin, Base64Mixin {
//   //late ActivityPlayingContext _activityPlayingCtx;

//   //ActivityModel get activity => _activityPlayingCtx.activity;

//   //List get knowledgeShots => DbRepository.to.getKnowledgesForActivity(activity);

//   final _isEnableInteraction = true.obs;
//   bool get isEnableInteraction => _isEnableInteraction.value;

//   final _isEnableRepeatButton = false.obs;
//   bool get isEnableRepeatButton => _isEnableRepeatButton.value;

//   final _isEnableToffeeShotButton = false.obs;
//   bool get isEnableToffeeShotButton => _isEnableToffeeShotButton.value;

//   final _isEnableGoBackButton = true.obs;
//   bool get isEnableGoBackButton => _isEnableGoBackButton.value;

//   final _isEnableDoneButton = true.obs;
//   bool get isEnableDoneButton => _isEnableDoneButton.value;

//   final _isEnableSkipButton = true.obs;
//   bool get isEnableSkipButton => _isEnableSkipButton.value;

//   final _isShowContinueButton = false.obs;
//   bool get isShowContinueButton => _isShowContinueButton.value;

//   final _isShowSkipButton = false.obs;
//   bool get isShowSkipButton => _isShowSkipButton.value;

//   //final audioPlayer = AudioPlayer();
//   //AudioPlayer? audioPlayer;

//   bool isAudioPlayingWhenGoesToBackground = false;

//   late final ConfettiController confettiController =
//       ConfettiController(duration: 0.30.seconds);

//   //streams
//   StreamSubscription? _streamAudio;

//   bool isCompleted = false; //to check the status
//   bool isSuccess = false; //to check the status
//   num chance = 0; //to check the status

//   @override
//   void onInit() {
//     super.onInit();
//     //Wakelock.enable();
//     onTemplateControllerInit();
//   }

//   @override
//   void onClose() {
//     //Wakelock.disable();
//     onTemplateControllerClose();
//     super.onClose();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//     onTemplateControllerReady();
//   }

//   @override
//   void onDetached() {
//     isAudioPlayingWhenGoesToBackground = audioPlayer?.playing ?? false;

//     //audioPlayer?.stop();
//   }

//   @override
//   void onInactive() {}

//   @override
//   void onPaused() {
//     isAudioPlayingWhenGoesToBackground = audioPlayer?.playing ?? false;

//    // audioPlayer?.stop();
//   }

//   @override
//   void onResumed() {
//     if (isAudioPlayingWhenGoesToBackground) playAudioPlayer();
//   }

//   onTemplateControllerInit() {
//     _activityPlayingCtx = Get.arguments;

//     // //start activity - AnalyticsEventSource.userClick
//     // TRAnalytics.onLearnEvent(
//     //     event: ActivtyAnalyticsHelper.getStartActivityEvent(
//     //         _activityPlayingCtx, AnalyticsEventSource.userClick.desciption));

//     //start test/lesson - only if its not jigsaw
//     if (!_activityPlayingCtx.activity.isActivityJigsaw) {
//       _addTestLearnStartToAnalytics(
//           eventSource: AnalyticsEventSource.userClick);
//     }
//   }

//   onTemplateControllerReady() {
//     _isEnableToffeeShotButton(knowledgeShots.isNotEmpty);
//   }

//   onTemplateControllerClose() {
//     _streamAudio?.cancel();
//     audioPlayer?.dispose();
//   }

//   actionOnAudioStreamEnding() {}

//   onTemplateAfterToffeeshotAction() {}

//   // playAudioPlayer({AudioSource? source}) async {
//   //   final audioSource = source ?? audioPlayer?.audioSource;
//   //   final speed = audioPlayer?.speed ?? UserSettings.playBackRate.toDouble();

//   //   if (audioPlayer == null || GetPlatform.isWindows) {
//   //     audioPlayer?.stop();
//   //     audioPlayer = AudioPlayer();

//   //     _streamAudio?.cancel();
//   //     _streamAudio = audioPlayer!.playerStateStream.listen((state) {
//   //       switch (state.processingState) {
//   //         case ProcessingState.completed:
//   //           if (!audioPlayer!.hasNext) {
//   //             _enableDisableRepeatButton(true);
//   //             actionOnAudioStreamEnding();
//   //           }
//   //           break;
//   //         default:
//   //           break;
//   //       }
//   //     });
//   //   }

//   //   if (source != null) {
//   //     await audioPlayer?.setAudioSource(source);
//   //     await audioPlayer?.setSpeed(speed);
//   //     await audioPlayer?.play();
//   //   } else if (audioSource != null && audioPlayer?.audioSource == null) {
//   //     await audioPlayer?.setAudioSource(audioSource);
//   //     await audioPlayer?.setSpeed(speed);
//   //     await audioPlayer?.play();
//   //   } else if (audioPlayer?.audioSource != null) {
//   //     await audioPlayer?.seek(0.seconds);
//   //     await audioPlayer?.play();
//   //   }
//   // }

//   pauseAudioPlayer() async {
//     await audioPlayer?.pause();
//   }

//   // goBack(AnalyticsEventSource eventSource) async {
//   //   //activity end
//   //   TRAnalytics.onLearnEvent(
//   //       event: ActivtyAnalyticsHelper.getFinishActivityEvent(
//   //           _activityPlayingCtx,
//   //           eventSource.desciption,
//   //           _activityPlayingCtx.activity.isTestActivity
//   //               ? isSuccess && chance == 1
//   //                   ? TRLearnTestStatus.passed
//   //                   : TRLearnTestStatus.failed
//   //               : TRLearnTestStatus.na,
//   //           _activityPlayingCtx.activity.isTestActivity ? chance.toInt() : 0));

//   //   Get.back(
//   //       result: TemplateResponseParameters(
//   //           isCompleted: isCompleted,
//   //           isSuccess: activity.isTestActivity
//   //               ? isSuccess
//   //                   ? chance == 1
//   //                   : false
//   //               : isSuccess));
//   // }

//   // startAudios(
//   //     {required List<String> base64Urls,
//   //     List<String> assetUrls = const []}) async {
//   //   final audioPlaylist =
//   //       ConcatenatingAudioSource(children: [], useLazyPreparation: true);

//   //   if (assetUrls.isNotEmpty) {
//   //     for (String assetUrl in assetUrls) {
//   //       audioPlaylist.add(AudioSource.uri(Uri.parse('asset:///$assetUrl')));
//   //     }
//   //   }

//   //   if (base64Urls.isNotEmpty) {
//   //     //play audio
//   //     for (String base64Url in base64Urls) {
//   //       final audioBase64 = await DbRepository.to.getBase64(base64Url);

//   //       dynamic audioBytes;
//   //       if (audioBase64 != null) {
//   //         audioBytes = dataFromBase64String(audioBase64);
//   //       }

//   //       if (audioBytes != null) {
//   //         audioPlaylist.add(CustomAudioSource(buffer: audioBytes));
//   //         await Future.delayed(Duration.zero);
//   //       }
//   //     }
//   //   }

//   //   if (audioPlaylist.children.isNotEmpty) {
//   //     await playAudioPlayer(source: audioPlaylist);
//   //   }
//   // }

//   // startAudio(String base64Url) async {
//   //   if (base64Url.isNotEmpty) {
//   //     //play audio
//   //     final audioBase64 = await DbRepository.to.getBase64(base64Url);

//   //     dynamic audioBytes;
//   //     if (audioBase64 != null) {
//   //       audioBytes = dataFromBase64String(audioBase64);
//   //     }

//   //     if (audioBytes != null) {
//   //       playAudioPlayer(source: CustomAudioSource(buffer: audioBytes));
//   //     }
//   //   }
//   // }

//   _enableDisableRepeatButton(bool isEnable) {
//     if (!isEnableGoBackButton) {
//       //in case audio completed after disabling all buttons
//       return;
//     }

//     if (isEnable) {
//       _isEnableRepeatButton(audioPlayer?.audioSource != null);
//     } else {
//       _isEnableRepeatButton(false);
//     }
//   }

//   _enableDisableButtons(bool isEnable) {
//     if (isEnable) {
//       _isEnableRepeatButton(audioPlayer?.audioSource != null);
//       _isEnableToffeeShotButton(knowledgeShots.isNotEmpty);
//       _isEnableGoBackButton(true);
//       _isEnableDoneButton(true);
//       _isEnableSkipButton(true);

//       _isShowSkipButton(chance > 0);
//     } else {
//       _isEnableRepeatButton(false);
//       _isEnableToffeeShotButton(false);
//       _isEnableGoBackButton(false);
//       _isEnableDoneButton(false);
//       _isEnableSkipButton(false);
//     }
//     _isEnableInteraction(isEnable);
//   }

//   //to force enable from jigsaw
//   enableSkipButton(bool isEnable) {
//     _isEnableSkipButton(isEnable);
//     _isShowSkipButton(isEnable);
//   }

//   // _goToToffeeShot(
//   //     {required AnalyticsEventSource eventSource,
//   //     VoidCallback? onSuccess,
//   //     VoidCallback? onFailed}) async {
//   //   //toffeshot start
//   //   TRAnalytics.onLearnEvent(
//   //       event: ActivtyAnalyticsHelper.getStartToffeeShotEvent(
//   //           _activityPlayingCtx, eventSource.desciption));

//   //   final response = await Get.toNamed('/toffee_shot',
//   //       arguments: ToffeeShotLearningContext(
//   //           activity: activity,
//   //           lessonDetail: _activityPlayingCtx.lessonDetail,
//   //           isContinue: isCompleted && isSuccess ? true : false));

//   //   if (response) {
//   //     //toffeshot end
//   //     TRAnalytics.onLearnEvent(
//   //         event: ActivtyAnalyticsHelper.getFinishToffeeShotEvent(
//   //             _activityPlayingCtx,
//   //             isCompleted && isSuccess
//   //                 ? AnalyticsEventSource.userClickExitForward.desciption
//   //                 : AnalyticsEventSource.userClickExitBackward.desciption,
//   //             chance.toInt()));

//   //     if (isCompleted) {
//   //       _enableDisableButtons(true);
//   //       if (isSuccess) {
//   //         onSuccess?.call();
//   //       } else {
//   //         //test start
//   //         _addTestLearnStartToAnalytics(
//   //             eventSource: AnalyticsEventSource.system);

//   //         onFailed?.call();
//   //       }
//   //     }
//   //   }
//   // }

//   _playConfetti() {
//     confettiController.play();
//   }

//   // onTappedBackButton() {
//   //   if (!isEnableGoBackButton) {
//   //     return;
//   //   }

//   //   //go back with na status test && chance ++
//   //   chance++;

//   //   _addTestLearnEndToAnalytics(
//   //       status: TRLearnTestStatus.na,
//   //       eventSource: AnalyticsEventSource.userClickExitBackward,
//   //       noOfAttempts: chance.toInt());

//   //   goBack(AnalyticsEventSource.userClickExitBackward);
//   // }

//   onTappedContinueButton() {
//     if (!isShowContinueButton) {
//       return;
//     }

//     //chance++; rhyme and lesson calls this func. chance is taking care there
//   //   _addTestLearnEndToAnalytics(
//   //       status: TRLearnTestStatus.na,
//   //       eventSource: AnalyticsEventSource.userClickExitForward,
//   //       noOfAttempts: chance.toInt());

//   //   goBack(AnalyticsEventSource.userClickExitForward);
//   // }

//   // onTappedRepeatButton() async {
//   //   if (!isEnableRepeatButton) {
//   //     return;
//   //   }
//   //   _repeatAudio();
//   // }

//   // _repeatAudio() async {
//   //   if (audioPlayer?.audioSource != null) {
//   //     _enableDisableRepeatButton(false);

//   //     await playAudioPlayer();
//   //   }
//   // }

//   // onTappedToffeeShotButton() {
//   //   if (!isEnableToffeeShotButton) {
//   //     return;
//   //   }

//   //   //in case audio is playing
//   //   audioPlayer?.stop();

//   //   //mark as completed and wrong
//   //   isSuccess = false;
//   //   isCompleted = true;
//   //   chance++;

//   //   //test end
//   //   _addTestLearnEndToAnalytics(
//   //       status: TRLearnTestStatus.failed,
//   //       eventSource: AnalyticsEventSource.userClick,
//   //       noOfAttempts: chance.toInt());

//   //   _goToToffeeShot(
//   //       eventSource: AnalyticsEventSource.userClick,
//   //       onFailed: () {
//   //         onTemplateAfterToffeeshotAction();
//   //         _repeatAudio();
//   //       });
//   // }

//   // onTappedSkipButton() {
//   //   if (!isShowSkipButton && !isEnableSkipButton) {
//   //     return;
//   //   }

//   //   //mark as completed and wrong
//   //   isSuccess = false;
//   //   isCompleted = true;
//   //   chance++;

//   //   //test end
//   //   _addTestLearnEndToAnalytics(
//   //       status: TRLearnTestStatus.failed,
//   //       eventSource: AnalyticsEventSource.userClickExitSkip,
//   //       noOfAttempts: chance.toInt());

//   //   goBack(AnalyticsEventSource.userClickExitSkip);
//   // }

//   // completedActivity({VoidCallback? onSuccess, VoidCallback? onFailed}) {
//   //   // if (chance == 1) {
//   //   //   firstAttempt = isSuccess ? 'CorrectAnswer' : 'WrongAnswer';
//   //   // }

//   //   //test end
//   //   _addTestLearnEndToAnalytics(
//   //       status: isSuccess ? TRLearnTestStatus.passed : TRLearnTestStatus.failed,
//   //       eventSource: AnalyticsEventSource.userClick,
//   //       noOfAttempts: chance.toInt());

//   //   //disable all buttons
//   //   _enableDisableButtons(false);

//   //   //in case audio is playing
//   //   audioPlayer?.stop();

//   //   if (isSuccess) {
//   //     _playConfetti();
//   //   }

//   //   //play sound
//   //   AudioController.to.play(
//   //       soundType: isSuccess ? SoundType.rightAnswer : SoundType.wrongAnswer);

//   //   if (onSuccess != null) {
//   //     onSuccess.call();
//   //   }

//   //   Future.delayed(Duration(seconds: isSuccess ? 3 : 1), () {
//   //     //go to toffee shot if available or go back while success
//   //     (knowledgeShots.isNotEmpty && !(isSuccess && chance > 1))
//   //         ? _goToToffeeShot(
//   //             eventSource: AnalyticsEventSource.system,
//   //             onSuccess: () =>
//   //                 goBack(AnalyticsEventSource.userClickExitForward),
//   //             onFailed: () {
//   //               onFailed?.call();
//   //               _repeatAudio();
//   //             })
//   //         : isSuccess
//   //             ? goBack(AnalyticsEventSource.userClick)
//   //             : () async {
//   //                 //delay
//   //                 await Future.delayed(1.seconds);
//   //                 //reset. wont go to toffeeshot
//   //                 _enableDisableButtons(true);
//   //                 onFailed?.call();
//   //                 _repeatAudio();
//   //               }();
//   //   });
//   // }

//   showContinueButton(bool isShow) {
//     _isShowContinueButton(isShow);
//   }

//   //Analytics Test/Learn start
//   // _addTestLearnStartToAnalytics({required AnalyticsEventSource eventSource}) {
//   //   if (_activityPlayingCtx.activity.isTestActivity) {
//   //     TRAnalytics.onLearnEvent(
//   //         event: ActivtyAnalyticsHelper.getStartTestEvent(
//   //             _activityPlayingCtx, eventSource.desciption));
//   //   } else {
//   //     TRAnalytics.onLearnEvent(
//   //         event: ActivtyAnalyticsHelper.getStartLearnEvent(
//   //             _activityPlayingCtx, eventSource.desciption));
//   //   }
//   // }

//   //Analytics Test/Learn end
//   _addTestLearnEndToAnalytics(
//       {required TRLearnTestStatus status,
//       required AnalyticsEventSource eventSource,
//       required int noOfAttempts}) {
//     if (_activityPlayingCtx.activity.isTestActivity) {
//       TRAnalytics.onLearnEvent(
//           event: ActivtyAnalyticsHelper.getTestFinishEvent(_activityPlayingCtx,
//               eventSource.desciption, status, noOfAttempts));
//     } else {
//       TRAnalytics.onLearnEvent(
//           event: ActivtyAnalyticsHelper.getLearnFinishEvent(
//               _activityPlayingCtx, eventSource.desciption));
//     }
//   }

//   //Analytics jigsaw test start
//   jigsawAnalyticsStartTest(String level) {
//     _activityPlayingCtx.setActivityComplexityLevel(level);
//     _addTestLearnStartToAnalytics(eventSource: AnalyticsEventSource.userClick);
//   }

//   //Analytics mathwiz test&activity end
//   mathwizLearningAnalyticsWhenCompleted(
//       {required AnalyticsEventSource eventSource,
//       required bool isCompleted,
//       required int finalScore}) {
//     _addTestLearnEndToAnalytics(
//         status: !isCompleted
//             ? TRLearnTestStatus.failed
//             : finalScore > 50
//                 ? TRLearnTestStatus.passed
//                 : TRLearnTestStatus.failed,
//         eventSource: eventSource,
//         noOfAttempts: chance.toInt());

//     TRAnalytics.onLearnEvent(
//         event: ActivtyAnalyticsHelper.getFinishActivityEvent(
//             _activityPlayingCtx,
//             eventSource.desciption,
//             !isCompleted
//                 ? TRLearnTestStatus.failed
//                 : finalScore > 50
//                     ? TRLearnTestStatus.passed
//                     : TRLearnTestStatus.failed,
//             chance.toInt()));
//   }

//   //lesson user skip forward or backward
//   userSkipLessonActivityAnalytics(
//       {required AnalyticsEventSource eventSource, required String level}) {
//     _activityPlayingCtx.setActivityComplexityLevel(level);
//     TRAnalytics.onLearnEvent(
//         event: ActivtyAnalyticsHelper.getLearnSkipEvent(
//             _activityPlayingCtx, eventSource.desciption));
//   }
// }
