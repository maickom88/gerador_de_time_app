import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';

class CardInfoGame extends StatelessWidget {
  const CardInfoGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.lightColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(' 🏆', style: TextStyle(fontSize: 20.0))
                  .withRightPadding(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: AppColor.textLight)),
                  ),
                  child: const Text('Total de vitorias',
                      style: TextStyle(color: AppColor.textLight)),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text(' ⚽️', style: TextStyle(fontSize: 20.0))
                  .withRightPadding(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: AppColor.textLight)),
                  ),
                  child: const Text('Total de gols marcados',
                      style: TextStyle(color: AppColor.textLight)),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text('-⚽️', style: TextStyle(fontSize: 20.0))
                  .withRightPadding(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: AppColor.textLight)),
                  ),
                  child: const Text('Saldo de gols negativos',
                      style: TextStyle(color: AppColor.textLight)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
