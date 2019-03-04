import '../include.dart';

typedef OnBusStationsCallBack = void Function(StationBean station);

class BusStationsDialog extends BaseDialog {
  final BusBean bus;
  final OnBusStationsCallBack onSelected;

  BusStationsDialog({@required this.bus, @required this.onSelected});

  @override
  Widget buildBody(BuildContext context) {
    return BusStationsView(
      bus: bus,
      onSelected: (bean) {
        onSelected(bean);
        close(context);
      },
    );
  }
}

class BusStationsView extends StatefulWidget {
  final BusBean bus;
  final OnBusStationsCallBack onSelected;

  const BusStationsView({Key key, this.bus, this.onSelected}) : super(key: key);

  @override
  _BusStationsViewState createState() => _BusStationsViewState();
}

class _BusStationsViewState extends State<BusStationsView> {
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
          _buildStations(context),
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
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Text(
              widget.bus.startPoint,
              style: TextStyle(color: AppColors.COLOR_FFF, fontSize: 14),
            ),
          ),
          Center(
            child: Text(
              widget.bus.shotName + ' ' + AppStrings.getLocale(context).busUnit,
              style: TextStyle(
                color: AppColors.COLOR_FFF,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Text(
              widget.bus.endPoint,
              style: TextStyle(color: AppColors.COLOR_FFF, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStations(BuildContext context) {
    return Container(
      height: 320,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: GridView.builder(
          itemBuilder: (context, pos) {
            return _buildOneStation(pos);
          },
          itemCount: widget.bus.stations.station.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3),
        ),
      ),
    );
  }

  Widget _buildOneStation(int pos) {
    return GestureDetector(
      onTap: (){
        widget.onSelected(widget.bus.stations.station[pos]);
      },
      child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
                  alignment: Alignment.center,
                  child: Text(widget.bus.stations.station[pos].no),
                  constraints: BoxConstraints.expand(width: 30, height: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.COLOR_7FDA7C, width: 4),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    widget.bus.stations.station[pos].name,
                    maxLines: 1,
                    minFontSize: 10,
                    style: TextStyle(color: AppColors.COLOR_333,fontSize: 16),
                  ),
                ),
              ],
            ),
    );
  }
}
