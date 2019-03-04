import '../include.dart';

class AppTextField {
  static Widget busSearch({
    @required String hint,
    @required String label,
    ValueChanged<String> onChanged,
    VoidCallback onEditingComplete,
    FocusNode focusNode,
    int maxLength = TextField.noMaxLength,
  }) {
    TextEditingController controller = TextEditingController.fromValue(
      TextEditingValue(
        text: label,
        selection: TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: label.length),
        ),
      ),
    );

    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.COLOR_E8E8E8,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(16),
    );
    return Container(
      constraints: BoxConstraints(maxHeight: 32),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLines: 1,
        maxLength: maxLength,
        textInputAction: TextInputAction.search,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        cursorColor: AppColors.COLOR_FFF,
        cursorWidth: 2,
        style: TextStyle(fontSize: 14, color: AppColors.COLOR_FFF),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: AppColors.COLOR_FFF),
          isDense: true,
          suffixIcon: Icon(Icons.search, color: Colors.transparent),
          contentPadding: EdgeInsets.all(8),
          border: inputBorder,
          focusedBorder: inputBorder,
          disabledBorder: inputBorder,
          enabledBorder: inputBorder,
          errorBorder: inputBorder,
          focusedErrorBorder: inputBorder,
          hasFloatingPlaceholder: false,
          hintStyle: TextStyle(fontSize: 12, color: AppColors.COLOR_E8E8E8),
          hintText: hint,
          counter: Container(),
          //此属性可去除计数器
          hintMaxLines: 1,
        ),
        keyboardType: TextInputType.text,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
