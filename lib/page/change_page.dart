import '../include.dart';

class ChangePage extends StatefulWidget {
  @override
  _ChangePageState createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('换乘'),
    );
  }
}
