import 'package:faucet_base_app/providers/form_state.dart';
import 'package:faucet_base_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/ui/text.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(true),
      child: Builder(builder: (context) {
        AppState state = Provider.of<AppState>(context);
        return Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 40),
              const SizedBox(height: 20),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Email ID',
                  filled: true,
                  prefixIcon: Icon(Icons.atm),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(12, 3, 6, 3),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: password,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  prefixIcon: const Icon(Icons.lock, size: 22),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      state.passwordView = !state.passwordView;
                      debugPrint(state.passwordView.toString());
                    },
                    icon: Icon(
                        state.passwordView ? Icons.remove_red_eye : Icons.add),
                  ),
                  fillColor: Colors.transparent,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(12, 3, 6, 3),
                ),
                obscureText: state.passwordView ? true : false,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EmailLogin(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            ),
                            side: BorderSide(
                                width: 1, color: Constants.blueGrey)),
                        primary: Colors.white,
                      ),
                      child: const DesignText(
                        'Log in',
                        color: Constants.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const DesignText(
                "OR",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            ),
                            side: BorderSide(
                                width: 1, color: Constants.blueGrey)),
                        primary: Colors.white,
                      ),
                      child: const DesignText(
                        'Sign up',
                        color: Constants.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const DesignText(
                "Version 1.0.0(1) - release",
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              
            ],
          ),
        );
      }),
    );
  }
}
