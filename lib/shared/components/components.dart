import 'package:flutter/material.dart';

Widget defaultButton({
   double width=double.infinity,
   Color color=Colors.blue,
   bool isUpperCase=true,
   double radius=10,
   required Function funtion,
   required String text,
})=>
    Container(
    width: width,
    color:color,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
         radius,
      ),
    ),
    child: MaterialButton(
      onPressed:(){},
      child: Text(
        text,
        style:TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),),),
      
  );
Widget defaultFormField(
{
 required TextEditingController controller,
 required TextInputType type,
 required Function  validate,

})=>
    TextFormField(
  controller: controller,
  keyboardType:type,
  decoration: InputDecoration(
    labelText: 'Email Address',
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
  validator: (value){
    if(value!.isEmpty)
    {
      return 'email address must not be empty';
    }
    return null;
  },
  onFieldSubmitted: (value)
  {
    print(value);
  },
);
