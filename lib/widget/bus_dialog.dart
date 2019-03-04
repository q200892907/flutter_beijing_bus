import '../include.dart';

typedef OnCheckBusCallBack = void Function(String busName, BusType busType);

class BusDialog extends BaseDialog {
  final OnCheckBusCallBack onSelected;
  final BusType busType;

  BusDialog({
    @required this.onSelected,
    @required this.busType,
  });

  @override
  double getWidthFactor() {
    return 1;
  }

  @override
  Widget buildBody(BuildContext context) {
    return _SelectBusView(
      onSelected: (name,type){
        onSelected(name,type);
        close(context);
      },
      busType: busType,
    );
  }
}

class _SelectBusView extends StatefulWidget {
  final OnCheckBusCallBack onSelected;
  final BusType busType;

  const _SelectBusView({Key key, this.onSelected, this.busType}) : super(key: key);

  @override
  _SelectBusViewState createState() => _SelectBusViewState();
}

class _SelectBusViewState extends State<_SelectBusView> {
  String _inputBus = '';
  List<String> _busTypes = [];
  bool _isFirst = true;
  BusType _selectType;
  List<Map<String, List<LineBean>>> _selectLines;

  @override
  Widget build(BuildContext context) {
    if (_isFirst) {
      _busTypes = [
        AppStrings.getLocale(context).normalBus + '\n(' + BusUtil.instance.allBus[BusType.NORMAL].length.toString() + ')',
        AppStrings.getLocale(context).expressBus + '\n(' + BusUtil.instance.allBus[BusType.EXPRESS].length.toString() + ')',
        AppStrings.getLocale(context).nightBus + '\n(' + BusUtil.instance.allBus[BusType.NIGHT].length.toString() + ')',
        AppStrings.getLocale(context).airportBus + '\n(' + BusUtil.instance.allBus[BusType.AIRPORT].length.toString() + ')',
      ];
      _selectBusType(widget.busType.index);
      _isFirst = false;
    }
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      constraints: BoxConstraints.expand(width: double.infinity, height: 560),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.COLOR_FFF,
      ),
      child: Column(
        children: <Widget>[
          _buildTitle(context),
          _buildBusList(),
        ],
      ),
    );
  }

  Expanded _buildBusList() {
    return Expanded(
      child: Row(
        children: <Widget>[
          _buildBusTypeView(),
          Container(
            width: .5,
            color: AppColors.COLOR_E8E8E8,
          ),
          _buildBusGridView(),
        ],
      ),
    );
  }

  Widget _buildBusGridView() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _inputBus.isEmpty ? 2 : 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, pos) {
            return GestureDetector(
              onTap: (){
                widget.onSelected(_selectLines[pos].keys.first,_selectLines[pos].values.first.first.busType(context));
              },
              child: Container(
                constraints: BoxConstraints.expand(width: 100, height: 100),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: JvtdImage.local(name: AppImages.BUS_HALF, color: BusUtil.busColor(pos), width: 30, height: 60, fit: BoxFit.contain),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16,right: 16),
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            AutoSizeText(
                              _selectLines[pos].keys.first,
                              maxLines: 1,
                              style: TextStyle(color: AppColors.COLOR_333, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              AppStrings.getLocale(context).busUnit,
                              style: TextStyle(color: BusUtil.busColor(pos), fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: _selectLines.length,
        ),
      ),
    );
  }

  Widget _buildBusTypeView() {
    return SizedBox(
      width: _inputBus.isEmpty ? 108 : 0,
      child: ListView.builder(
        itemBuilder: (context, pos) {
          return Column(
            children: <Widget>[
              ListTile(
                dense: true,
                title: Row(
                  children: <Widget>[
                    Container(
                      color: _selectType.index == pos ? AppColors.COLOR_THEME : Colors.transparent,
                      width: 4,
                      height: 16,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _busTypes[pos],
                        style: TextStyle(color: AppColors.COLOR_333, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 4),
                  ],
                ),
                onTap: () {
                  _selectBusType(pos);
                },
                contentPadding: EdgeInsets.zero,
              ),
              Container(height: .5, color: AppColors.COLOR_E8E8E8),
            ],
          );
        },
        itemCount: _busTypes.length,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(width: double.infinity, height: 96),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        image: DecorationImage(image: JvtdImage.assetImage(name: AppImages.MAIN_BG), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            AppStrings.getLocale(context).pleaseSelectLine,
            style: TextStyle(
              color: AppColors.COLOR_FFF,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: AppTextField.busSearch(
              hint: AppStrings.getLocale(context).searchLine,
              label: _inputBus,
              onChanged: _changeBus,
            ),
          ),
        ],
      ),
    );
  }

  void _changeBus(String value) {
    setState(() {
      _inputBus = value;
      if (_inputBus == '') {
        _selectBusType(_selectType);
      } else {
        _selectLines = BusUtil.instance.query(_inputBus);
      }
    });
  }

  void _selectBusType(pos) {
    setState(() {
      if (pos == BusType.NORMAL.index) {
        _selectType = BusType.NORMAL;
      } else if (pos == BusType.AIRPORT.index) {
        _selectType = BusType.AIRPORT;
      } else if (pos == BusType.EXPRESS.index) {
        _selectType = BusType.EXPRESS;
      } else {
        _selectType = BusType.NIGHT;
      }
      _selectLines = BusUtil.instance.allBus[_selectType];
    });
  }
}
