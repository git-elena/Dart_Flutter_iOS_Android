import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserProfile extends StatelessWidget {
  UserProfile();

  final List<String> listLabelTopMenu = [
  "Сушi",
  "Роли",
  "Сети",
  "Гункани",
  "Локшина",
  "Запеченi Сушi",
  "Запеченi Роли",
  "Запеченi Сети",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Shop"),
      ),
      body:  Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _MenuTopBar(menuItemsLabel: listLabelTopMenu),
              _UserInfo(),
              _MenuBottomBar(menuRow: [
                MenuRowData("Сушi"),
                MenuRowData("Роли"),
                MenuRowData("Сети"),
              ],),
            ]
        ),
      ),
    );
  }
}

class _MenuTopBar extends StatelessWidget {
  const _MenuTopBar({Key? key, required this.menuItemsLabel}) : super(key: key);

  final List<String> menuItemsLabel;

  @override
  Widget build (BuildContext context) {

    List<Widget> listBarItem =
      menuItemsLabel.map((String text) => _MenuBarItem(caption: text)).toList();

    return SingleChildScrollView (
      scrollDirection: Axis.horizontal,
      child: Container(

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: listBarItem
            //[
          //   _MenuBarItem(caption: "caption"),
          //   _MenuBarItem(caption: "caption"),
          //   Text(menuItemsLabel[1]),
          //   Text(menuItemsLabel[2]),
          //   Text(menuItemsLabel[3]),
          //   Text(menuItemsLabel[4]),
          // ],
        ),
      ),
    );
    //   Container(
    //   color: Colors.white,
    //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //   child: Row (
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //
    //     children: //menuItemsLabel.map((e) => _MenuBarItem(caption: e.toString())),
    //     listBarItem
    //   ),
    // );
  }
}

class _MenuBottomBar extends StatelessWidget {
  const _MenuBottomBar({Key? key, required this.menuRow}) : super(key: key);

  final List<MenuRowData> menuRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          _MenuBarItem(caption: "На головну", width: 100,),
          _MenuBarItem(caption: "До кошика", width: 100),
          _MenuBarItem(caption: "Оператор", width: 100),

        ],
      ),
    );
  }
}

class MenuRowData {
  final String caption;

  MenuRowData(this.caption);

}

class _MenuBarItem extends StatelessWidget {
  const _MenuBarItem({Key? key,
  required this.caption,
   this.width = 60,
   this.height = 40}) : super(key: key);

  final String caption;
  final double width, height;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        SizedBox(width: 10,),
        Container (
          color: Colors.white,

          //width: width,
          //height: height,
          child:  Text(caption),
        ),
        SizedBox(width: 10,),
      ],
    );
  }
}


class _UserInfo extends StatelessWidget {
  const _UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
          children: [
            SizedBox(height: 30),
            _AvatarWidget(),
            SizedBox(height: 30),
            _UserNameWidget(),
            SizedBox(height: 10),
            _UserPhoneWidget(),
            SizedBox(height: 10),
            _UserNickNameWidget(),
            SizedBox(height: 30),

          ]
      ),
    );
  }
}

class _UserNickNameWidget extends StatelessWidget {
  const _UserNickNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child:
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
        ),
        onPressed: () {

      },
        child: Text("@ElenaDaniel"),
      )
      // Column(
      //   children: [
      //     SizedBox(height: 10,),
      //     Text('@ElenaDaniel',
      //       style: TextStyle(
      //
      //         color: Colors.white,
      //
      //       ),),
      //     SizedBox(height: 10,),
      //    ]
      // ),
    );
  }
}

class _UserPhoneWidget extends StatelessWidget {
  const _UserPhoneWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('+380971039551',
    style: TextStyle(
      fontSize: 18,
      color: Colors.red
    ),);
  }
}

class _UserNameWidget extends StatelessWidget {
  const _UserNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Elena Daniel for Wolf',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container (
      width: 400,
      height: 400,
      child:  Placeholder(),

    );
  }
}
