import 'dart:io';

import 'package:find_the_words/features/auth/presentation/points_bloc/points_bloc.dart';
import 'package:find_the_words/features/auth/presentation/widgets/earn_points/reward_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../../core/constants/game_values.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_size.dart';
import '../../earn_points_bloc/earn_points_bloc.dart';
import 'timer_alert_dialog.dart';

class EarnPointsButton extends StatefulWidget {
  const EarnPointsButton({super.key});

  @override
  State<EarnPointsButton> createState() => _EarnPointsButtonState();
}

class _EarnPointsButtonState extends State<EarnPointsButton> {
  RewardedAd? _rewardedAd;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          setState(() {
            _rewardedAd = ad;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          setState(() {
            _rewardedAd = null;
          });
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  void loadRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createRewardedAd();
      }, onAdFailedToShowFullScreenContent: ((ad, error) {
        ad.dispose();
        createRewardedAd();
      }));

      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        giveReward();
      });
      _rewardedAd = null;
    }
  }

  void giveReward() {
    BlocProvider.of<PointsBloc>(context).add(
      const ChangePoints(
        points: earnPoints,
        isMinus: false,
      ),
    );
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return RewardAlertDialog(context: context);
      },
    );
  }

  @override
  void initState() {
    createRewardedAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EarnPointsBloc, EarnPointsState>(
      listener: (context, state) {
        if (state is EarnPointsCanWatch) {
          loadRewardedAd();
        } else if (state is EarnPointsTooEarly) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return TimerAlertDialog(
                context: context,
                timer: state.timer.toString(),
              );
            },
          );
        }
      },
      child: Transform.scale(
        scale: 0.8,
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<EarnPointsBloc>(context).add(WatchAd());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: calculateSize(
                  context,
                  2,
                ),
              ),
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
            ),
            child: Center(child: BlocBuilder<EarnPointsBloc, EarnPointsState>(
              builder: (context, state) {
                return state is EarnPointsLoading
                    ? SizedBox(
                        width: calculateSize(context, 30),
                        height: calculateSize(context, 30),
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '+ $earnPoints ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Theme.of(context).colorScheme.surface,
                            size: calculateSize(
                              context,
                              Theme.of(context).primaryIconTheme.size! * .8,
                            ),
                          ),
                        ],
                      );
              },
            )),
          ),
        ),
      ),
    );
  }
}
