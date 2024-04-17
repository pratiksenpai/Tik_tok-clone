import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/login_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tiktok Clone',
              style: TextStyle(
                  fontSize: 35,
                  color: buttonColor,
                  fontWeight: FontWeight.w900),
            ),
            const Text(
              'Register',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://plus.unsplash.com/premium_photo-1664361480105-33afc4559c40?w=1400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c3BsYXNofGVufDB8fDB8fHww'),
                  backgroundColor: Colors.black,
                ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () => authController.pickImage(),
                      icon: const Icon(Icons.add_a_photo),
                    ))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _usernameController,
                labelText: 'Username',
                icon: Icons.person,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                isObscure: true,
                labelText: 'Password',
                icon: Icons.email,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: InkWell(
                onTap: () => authController.registerUser(
                    _usernameController.text,
                    _emailController.text,
                    _passwordController.text,
                    authController.profilePhoto),
                child: const Center(
                    child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'already have an account?',
                  style: TextStyle(fontSize: 20),
                ),
                InkWell(
                    child: Text(
                      ' Login',
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ),
                    onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
