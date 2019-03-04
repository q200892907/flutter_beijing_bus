import '../include.dart';

typedef OnBusDirectionCallBack = void Function(LineBean lineBean);

class BusDirectionDialog extends BaseDialog {
  final String lineName;
  final BusType busType;
  final LineBean line;
  final OnBusDirectionCallBack onSelected;

  BusDirectionDialog({@required this.lineName, @required this.busType, this.line, @required this.onSelected});

  @override
  Widget buildBody(BuildContext context) {
    Map lineMap;
    for (int i = 0; i < BusUtil.instance.allBus[busType].length; i++) {
      Map temp = BusUtil.instance.allBus[busType][i];
      if (temp.keys.first == lineName) {
        lineMap = temp;
        break;
      }
    }
    return BusDirectionView(
      name: lineName,
      line: line,
      lines: lineMap[lineName],
      onSelected: (bean) {
        onSelected(bean);
        close(context);
      },
    );
  }
}

class BusDirectionView extends StatefulWidget {
  final String name;
  final List<LineBean> lines;
  final LineBean line;
  final OnBusDirectionCallBack onSelected;

  const BusDirectionView({Key key, this.name, this.lines, this.line, this.onSelected}) : super(key: key);

  @override
  _BusDirectionViewState createState() => _BusDirectionViewState();
}

class _BusDirectionViewState extends State<BusDirectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.COLOR_FFF,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildTitle(context),
          _buildDirection(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints.expand(width: double.infinity, height: kTextTabBarHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        image: DecorationImage(image: JvtdImage.assetImage(name: AppImages.MAIN_BG), fit: BoxFit.cover),
      ),
      child: Text(
        widget.name + ' ' + AppStrings.getLocale(context).busUnit,
        style: TextStyle(
          color: AppColors.COLOR_FFF,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDirection(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.lines.map((bean) {
        return _buildLine(context, bean);
      }).toList(),
    );
  }

  Widget _buildLine(BuildContext context, LineBean bean) {
    return GestureDetector(
      onTap: () {
        widget.onSelected(bean);
      },
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              StationBoard(
                line: widget.name,
                type: StationType.START,
                name: bean.startPoint,
                width: 80,
              ),
              Container(
                width: 100,
                child: Column(
                  children: <Widget>[
                    Text(
                      bean.startPoint + '\n' + bean.endPoint,
                      style: TextStyle(color: AppColors.COLOR_333, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    JvtdImage.local(name: AppImages.BUS_CROSS, fit: BoxFit.contain, color: AppColors.COLOR_FF796E),
                  ],
                ),
              ),
              StationBoard(
                line: widget.name,
                type: StationType.END,
                name: bean.endPoint,
                width: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
