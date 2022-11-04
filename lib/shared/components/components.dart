import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        color: defaultColor,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );


Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: (){
        function();
      },
      child: Text(
        text.toUpperCase(),
      ),
    );


Widget defaultFormField({
  required TextEditingController controller,
  FormFieldValidator<String>? validate,
  required TextInputType type,
  bool isPassword = false,
  bool isClickable = true,
  VoidCallback? onTap,
  ValueChanged<String>? onChange,
  ValueChanged<String>? onSubmit,
  String? label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      validator: validate,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: ()
          {
            suffixPressed!();
          },
          icon: Icon(suffix),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );


void showToast({
    required String text,
    required ToastStates state,
})
{
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


enum ToastStates { SUCCESS, ERROR, WARNING }


Color chooseToastColor (ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);
