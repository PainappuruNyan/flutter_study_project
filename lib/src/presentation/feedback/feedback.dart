import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/feedback/feedback_bloc.dart';
import '../../core/constants/colors.dart';
import '../../data/models/user_feedback_model.dart';
import '../profile/profile_screen.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  static const String routeName = '/feedback';

  TextEditingController feedbackTitle = TextEditingController();
  TextEditingController feedbackBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedbackBloc>(
      create: (BuildContext context) => FeedbackBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Обратная связь'),
        ),
        body: BlocConsumer<FeedbackBloc, FeedbackState>(
  listener: (BuildContext context, FeedbackState state) {
    if (state is FeedbackSuccess) {
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext context) => const ProfileScreen())
      );
    }
  },
  builder: (BuildContext context, FeedbackState state) {
    if (state is FeedbackLoading) {
      return const Center(child: CircularProgressIndicator(),);
    }
    return Padding(
          padding: EdgeInsets.all(16.sp),
          child: Card(
            elevation: 6,
            child: Container(
              height: 500.h,
              padding: EdgeInsets.all(20.sp),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      controller: feedbackTitle,
                      style: const TextStyle(fontSize: 14, fontFamily: 'Robot'),
                      decoration: const InputDecoration(
                          floatingLabelStyle:
                          TextStyle(color: MyColors.kTextSecondary),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: MyColors.kPrimary)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: MyColors.kPrimary)),
                          labelText: 'Заголовок',
                          prefixIcon: Icon(
                            Icons.local_post_office_outlined,
                            color: MyColors.kTextSecondary,
                          )),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.sp),
                    height: 270.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 500,
                        controller: feedbackBody,
                        cursorColor: MyColors.kPrimary,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Robot'),
                        decoration: InputDecoration(
                          counterText: '',
                          floatingLabelStyle:
                          const TextStyle(color: MyColors.kTextSecondary),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).cardColor,
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).cardColor,
                              )),
                          labelText: 'Текст сообщения',
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Отмена',
                            style: TextStyle(color: MyColors.kPrimary),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            context.read<FeedbackBloc>().add(
                              FeedbackPost(feedback: UserFeedbackModel(
                                title: feedbackTitle.text,
                                text: feedbackBody.text,
                              ))
                            );
                          },
                          color: MyColors.kPrimary,
                          child: const Text(
                            'Отправить',
                            style: TextStyle(color: MyColors.kWhite),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
  },
),
      ),
    );
  }
}
