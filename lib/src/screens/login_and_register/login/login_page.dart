import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_segu_v2/src/provider/login_provider.dart';
import 'package:proyect_segu_v2/src/screens/screen_tutor/home_tutor_page.dart';
import 'package:proyect_segu_v2/src/screens/screen_user/home_user_page.dart';
import 'package:proyect_segu_v2/src/services/push_notification.dart';
import 'package:proyect_segu_v2/src/utils/showsnacbar.dart';
import 'package:proyect_segu_v2/src/widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;
  static String? token;

  @override
  void initState() {
    super.initState();
    token = PushNotificationService.token;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // LOGEARSE
  void onFormLogin(String usernameOrEmail, String password, context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final String usernameOrEmailLower = usernameOrEmail.toLowerCase();

      loginProvider.loginUser(
        usernameOrEmail: usernameOrEmail,
        password: password,
        onSuccess: () async {
          // VERIFICAR SI EL USUARIO HA VERIFICADO SU CORREO ELECTRONICO
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null && user.emailVerified) {
            // SI EL USUAIRO HA VERIFICADO SU CORREO ELECTRONICO
            setState(() {
              _isLoading = false;
            });

            dynamic userData = await loginProvider.getUserData(user.email!);
            String userRole = userData['rol'];

            // CAMBIAR ESTADO DE AUNTENTICACION
            loginProvider.checkAuthState();

            // NAVEGAR AL INICIO
            if (userRole.contains("tutor")) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageTutor(userData: userData),
                ),
              );
            } else if (userRole.contains("user")) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageUser(userData: userData),
                ),
              );
            }
          } else {
            // SI EL USUARIO NOHA VERIFICADO SU CORREO ELECTRONICO
            setState(() {
              _isLoading = false;
            });
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Verifica tu correo"),
                  content: const Text(
                    "Por favor verifica tu correo electrónico para continuar",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Aceptar"),
                    )
                  ],
                );
              },
            );
          }
        },
        onError: (error) {
          showSnackbar(context, error);
        },
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Evitará el desbordamiento al abrir el teclado
      body: SingleChildScrollView(
        // Envuelve todo en un SingleChildScrollView
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  width: 200,
                  child: Image.asset('assets/images/inicio_sesion.png'),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextFormField(
                            controller: _emailController,
                            labelText: 'Email o Username',
                            icon: Icons.email,
                            inputType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 12,
                        ),
                        buildTextFormField(
                            controller: _passwordController,
                            labelText: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                            validator: Validator.validationPassword),
                        const SizedBox(height: 20),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40),
                                child: SizedBox(
                                  height: 50, // Altura del botón
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      onFormLogin(_emailController.text,
                                          _passwordController.text, context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                    child: const Text(
                                      "Iniciar sesion",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("¿No tienes una cuenta?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/register");
                                },
                                child: const Text(
                                  "Registrate",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ],
                    )),
              ),
            ),
            Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  //topRight: Radius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
