import '../include.dart';

enum StationType {
  START, //绿色
  END, //蓝色
  BEFORE, //红色
  CURRENT, //蓝色
  AFTER, //黄色
}

class StationBoard extends StatelessWidget {
  final String line;
  final String name;
  final StationType type;
  final double width;

  const StationBoard({
    Key key,
    @required this.line,
    @required this.type,
    @required this.name,
    this.width = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scale = width / 100;
    return Container(
      width: width,
      alignment: Alignment.bottomCenter,
      child: AspectRatio(
        child: Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(width: width,height: width /400 * 450),
              child: JvtdImage.local(
                name: AppImages.STATION_BOARD,
                fit: BoxFit.contain,
                color: boardColor(),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 400 / 100,
                  child: Container(
                    padding: EdgeInsets.only(left: 4 * scale, right: 4 * scale),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: AutoSizeText(
                            line,
                            minFontSize: 2,
                            maxLines: 1,
                            style: TextStyle(
                              color: AppColors.COLOR_FFF,
                              fontSize: 12 * scale,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          flex: 1,
                        ),
                        SizedBox(
                          width: 4 * scale,
                        ),
                        Expanded(
                          child: MarqueeWidget(
                            text: name,
                            ratioOfBlankToScreen: 0.05 * scale,
                            textStyle: TextStyle(
                              color: AppColors.COLOR_FFF,
                              fontSize: 12 * scale,
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                AspectRatio(
                  child: JvtdImage.local(name: AppImages.ORBITAL, fit: BoxFit.fill, color: orbitalColor()),
                  aspectRatio: 400 / 60,
                ),
              ],
            )
          ],
        ),
        aspectRatio: 400 / 450,
      ),
    );
  }

  Color boardColor() {
    if (type == StationType.START || type == StationType.CURRENT) {
      return AppColors.COLOR_7FDA7C;
    } else {
      return AppColors.COLOR_69A5FF;
    }
  }

  Color orbitalColor() {
    if (type == StationType.START|| type == StationType.CURRENT) {
      return AppColors.COLOR_51B64A;
    } else{
      return AppColors.COLOR_THEME;
    }
  }
}
