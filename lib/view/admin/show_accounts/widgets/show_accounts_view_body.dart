
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mosand/view/manager/widgets/ShadowContainer.dart';
import 'package:mosand/view/resourse/color_manager.dart';

class ShowAccountsViewBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_,index)=>BuildShowAccountItem(index:index),
    );
  }
}

class BuildShowAccountItem extends StatelessWidget {
  final int index;

  const BuildShowAccountItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('account name'),
        subtitle: Text('account status'),
        trailing: Icon(Icons.circle_rounded,color: index.isOdd?ColorManager.error:ColorManager.success,),
      ),
    );
  }
}
