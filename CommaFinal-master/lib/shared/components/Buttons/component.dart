import 'package:comma/modules/chat/chat1.dart';
import 'package:comma/modules/chat/chat2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

defaultNavigateTo({context, screen}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
void defaultFinishNavigate({context, widget}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}
Widget defaultText({text, color,maxLines, size, bool bold = false, textAlign = TextAlign.center })=> Text(
  text,
  textAlign: textAlign,
  maxLines: maxLines,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
    fontFamily: 'Plus Jakarta Sans',
      color: HexColor(color),
      fontWeight: (bold == true) ? FontWeight.bold : FontWeight.normal,
      fontSize: size
  ),
);
Widget defaultTextFormField({
  controller,
  onFieldSubmitted,
  onChanged,
  validator,
  bool obscureText = false,
  labelText,
  suffixIcon,
  prefixIcon
})=> TextFormField(
  controller: controller,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: onChanged,
  validator: validator,
  obscureText: obscureText,
  decoration: InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.black38),
  ),
);

defaultAccessButton({text, function}) => MaterialButton(
  onPressed: function,
  child: Container(
    height: 50.0,
    alignment: Alignment.center,
    width: double.infinity,
    decoration: BoxDecoration(
        color: HexColor('#265AE8'),
        borderRadius: BorderRadius.circular(5.0)),
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
  ),
);
Widget defaultButton({
  double Width = 120,
  Color background = Colors.blueAccent,
  required function,
}) =>
    Container(
      width: Width,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          "بحث",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget defaultTextForm({
  required IconData,
  required labelText,
  required TextInputType,
}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: TextInputType,
        decoration: InputDecoration(
          iconColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent)),
          labelText: labelText,
          border: OutlineInputBorder(),
          prefixIcon: IconData,
        ),
      ),
    );

Widget defaultFormField() => TextFormField(
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: "C1234567",
        border: InputBorder.none,
      ),
    );

Widget ContainerProfile({
  double width = 150,
  double Height = 60,
  required Function function,
  required String text,
  required Icon icon,
}) =>
    Row(
      children: [
        InkWell(
          onTap: (){
            function();
          },
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: Height,
            decoration: BoxDecoration(
              color: Color(0XFF265AE8).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              TextButton.icon(
                  onPressed: () {
                    function();
                  },
                  icon: icon,
                  label: Text(
                    text,
                    style: TextStyle(
                        fontSize: 15,
                        color: HexColor('#000000'),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Mulish"),
                  ))
            ]),
          ),
        ),
      ],
    );
