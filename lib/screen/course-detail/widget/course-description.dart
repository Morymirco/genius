import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/model/model.dart';
import 'package:coursenligne/util/util.dart';
import 'package:flutter/material.dart';

class CourseDescription extends StatefulWidget {
  const CourseDescription({ Key? key, this.course }) : super(key: key);
  final Course ? course;

  @override
  State<CourseDescription> createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescription> {

  String? firstHalf;
  String ? secondHalf;

  bool flag = true;

    @override
  void initState() {
    super.initState();
    if (widget.course!.courseDescription!.length > 50) {
      firstHalf = widget.course!.courseDescription!.substring(0, 70);
      secondHalf =widget.course!.courseDescription!.substring(70, widget.course!.courseDescription!.length);
    } else {
      firstHalf = widget.course!.courseDescription;
      secondHalf = '';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descriptions',
          style: TextStyle(
            color: AppColors.colorTint700,
            fontSize: getProportionateScreenWidth(14)
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        secondHalf!.isEmpty
          ? Text(firstHalf!)
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  flag ? (firstHalf! + '...') : (firstHalf! + secondHalf!),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: AppColors.colorTint600,
                    height: 1.5
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? 'Voir plus' : 'Voir moins',
                        style: TextStyle(color: AppColors.colorPrimary),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
      ],
    );
  }
}