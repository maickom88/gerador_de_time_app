import 'package:flutter/material.dart';
import 'animation.dart';
import '../theme/theme.dart';

class CircleTeams extends StatelessWidget {
  const CircleTeams({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            right: 85,
            child: FadeAnimation(
              delay: 0.3,
              directionType: DirectionType.translateX,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.lightColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            right: 60,
            child: FadeAnimation(
              delay: 0.6,
              directionType: DirectionType.translateX,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.lightColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            right: 30,
            child: FadeAnimation(
              delay: 0.9,
              directionType: DirectionType.translateX,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(
            delay: 1.2,
            directionType: DirectionType.translateX,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.dstATop),
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                  ),
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      '2+',
                      style: AppTypography.t22WithW800()
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
