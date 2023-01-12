import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';

class IdCard extends StatelessWidget {
  const IdCard(this.id, this.role, {super.key, required this.login});

  final int id;
  final String role;
  final String login;

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onLongPress: () async {
        await Clipboard.setData(ClipboardData(text: login));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Логин скопирован')),
        );
      },
      child: Card(
        color: Theme.of(context).canvasColor,
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(9.sp),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Switch.adaptive(
                  activeColor: MyColors.kPrimary,
                  inactiveThumbColor: MyColors.kPrimary,
                  value: themeProvider.isDarkMode,
                  onChanged: (bool value) {
                    final ThemeProvider provider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    provider.toggleTheme(value);
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Роль: ',
                    style: TextStyle(
                      color: MyColors.kPrimary,
                    ),
                  ),
                  Text(role)
                ],
              ),
              Text(
                'Login $login',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
