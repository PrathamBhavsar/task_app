import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../core/constants/enums/user_role.dart';
import '../../core/dto/login_dto.dart';
import '../../core/dto/register_dto.dart';
import '../../data/models/priority.dart';
import '../../old/widgets/action_button.dart';
import '../providers/auth_provider.dart';
import '../providers/priority_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Auth")),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text(provider.currentUser?.name ?? ""),
                Text(provider.currentUser?.email ?? ""),
                ActionBtn(
                  btnTxt: 'register',
                  onPress: () async {
                    provider.register(
                      RegisterUserDTO(
                        name: 'hi',
                        email: 'test8@gmail.com',
                        password: '111111',
                        role: UserRole.salesperson,
                        profileBgColor: 'qwerty',
                      ),
                    );
                  },
                  fontColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
                ActionBtn(
                  btnTxt: 'login',
                  onPress: () async {
                    provider.login(
                      LoginUserDTO(
                          email: 'test7@gmail.com', password: '111111'),
                    );
                  },
                  fontColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
                ActionBtn(
                  btnTxt: 'logout',
                  onPress: () async {
                    provider.logout();
                  },
                  fontColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
    );
  }
}
