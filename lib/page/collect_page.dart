import '../include.dart';
import '../widget/bus_collect_list_view.dart';
class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends AppPageState<CollectPage>{
  @override
  String appBarTitle(BuildContext context) {
    return AppStrings.getLocale(context).myCollect;
  }

  @override
  Widget buildBody(BuildContext context) {
    return BusCollectListView();
  }
}
