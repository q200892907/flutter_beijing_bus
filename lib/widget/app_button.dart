import '../include.dart';

//VerticalButton 创建实体
class VerticalButtonBean {
  final dynamic type;
  final String icon;
  final String title;

  VerticalButtonBean({this.type, this.icon, this.title});
}

class AppButton {
  static VerticalButton verticalButton(
    VerticalButtonBean bean, {
    VoidCallback onPressed,
    double space = 0,
    BoxFit fit = BoxFit.cover,
    double size = 40,
  }) {
    return VerticalButton.icon(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      onPressed: onPressed,
      icon: ConstrainedBox(
        constraints: BoxConstraints.expand(width: size, height: size),
        child: JvtdImage.local(name: bean.icon, fit: fit),
      ),
      label: Text(
        bean.title,
        style: TextStyle(
          color: AppColors.COLOR_333,
          fontSize: 12,
        ),
      ),
      space: space,
    );
  }

  static Widget realTime(
    String imgName,
    title, {
    double height = 32,
    String text,
    String hintText,
    bool arrow = true,
    VoidCallback onPressed,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      height: height,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              JvtdImage.local(name: imgName, width: 20, height: 20, fit: BoxFit.contain),
              SizedBox(width: 2),
              Text(
                title,
                style: TextStyle(color: AppColors.COLOR_333, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                child: Container(
                  color: AppColors.COLOR_E8E8E8,
                  width: 1,
                  margin: EdgeInsets.only(left: 8, right: 8),
                ),
                height: 16,
              ),
              Expanded(
                child: Text(
                  text.isEmpty ? hintText : text,
                  style: text.isEmpty ? TextStyle(color: AppColors.COLOR_CCC, fontSize: 12) : TextStyle(color: AppColors.COLOR_333, fontSize: 14),
                ),
              ),
              Container(
                child: Icon(Icons.arrow_drop_down, color: AppColors.COLOR_999),
                constraints: BoxConstraints.expand(width: 20, height: 20),
              )
            ],
          ),
          Container(color: AppColors.COLOR_E8E8E8,height: 1,margin: EdgeInsets.only(top: 4),),
        ],
      ),
//      child: Container(
//        constraints: BoxConstraints(maxHeight: height),
//        child: TextField(
//          onChanged: onChanged,
//          style: TextStyle(color: AppColors.COLOR_333, fontSize: 14),
//          decoration: InputDecoration(
//            isDense: true,
//            enabled: enabled,
//            hintText: hintText,
//            border: inputBorder,
//            errorBorder: inputBorder,
//            focusedBorder: inputBorder,
//            focusedErrorBorder: inputBorder,
//            disabledBorder: inputBorder,
//            enabledBorder: inputBorder,
//            suffixIcon: arrow
//                ? Container(
//              child: Icon(Icons.arrow_drop_down, color: AppColors.COLOR_999),
//              alignment: Alignment.centerRight,
//              constraints: BoxConstraints.expand(width: 20, height: 20),
//            )
//                : null,
//            hintStyle: TextStyle(color: AppColors.COLOR_CCC, fontSize: 12),
//            counterText: '',
//            prefixIcon: Row(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                JvtdImage.local(name: imgName, width: 20, height: 20, fit: BoxFit.contain),
//                SizedBox(width: 2),
//                Text(
//                  title,
//                  style: TextStyle(color: AppColors.COLOR_333, fontSize: 14, fontWeight: FontWeight.bold),
//                ),
//                SizedBox(
//                  child: Container(
//                    color: AppColors.COLOR_E8E8E8,
//                    width: 1,
//                    margin: EdgeInsets.only(left: 8, right: 8),
//                  ),
//                  height: 16,
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
    );
  }
}
