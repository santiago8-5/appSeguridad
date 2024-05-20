import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyect_segu_v2/src/provider/register_provider.dart';
import 'package:proyect_segu_v2/src/services/push_notification.dart';
import 'package:proyect_segu_v2/src/utils/showsnacbar.dart';
import 'package:proyect_segu_v2/src/widgets/dropdown_button.dart';
import 'package:proyect_segu_v2/src/widgets/text_form_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rolController = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;
  static String? token;
  UserRole? _selectedRole;

  @override
  void initState() {
    super.initState();
    token = PushNotificationService.token;
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void submitRegister() async {
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // VERIFICAR SI EL NOMBRE DE USUARIO YA EXISTE
      final bool existUserName =
          await registerProvider.chekUserExist(_usernameController.text);

      if (existUserName) {
        setState(() {
          _isLoading = false;
        });

        showSnackbar(context, "El nombre de usuario ya existe");

        return;
      }

      // VERIFICAR SI EL EMAIL YA EXISTE
      final bool existEmail =
          await registerProvider.chekEmailExist(_emailController.text);
      if (existEmail) {
        setState(() {
          _isLoading = false;
        });

        showSnackbar(context, "El email ya existe");

        return;
      }

      // REGISTRAR AL USUARIO
      try {
        await registerProvider.registerUser(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          role: _selectedRole ??
              UserRole
                  .user, // Utilizando UserRole.user como valor predeterminado
          token: token!,
          onError: (error) {
            showSnackbar(context, error);
          },
        );

        // ENVIAR CORREO DE VERFIFICACION
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        showSnackbar(context, "Revise su correo para verificar su cuenta");
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        showSnackbar(context, e.toString());
      } catch (e) {
        showSnackbar(context, e.toString());
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Registrar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildTextFormField(
                      controller: _usernameController,
                      labelText: 'Username',
                      icon: Icons.person_2_outlined,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    buildTextFormField(
                      controller: _emailController,
                      labelText: 'Email',
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    buildTextFormField(
                      controller: _passwordController,
                      labelText: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                      validator: Validator.validationPassword,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 300,
                          child: buildDropdownFormField(
                            labelText: 'Select',
                            icon: Icons.arrow_drop_down,
                            items: [
                              DropdownMenuItem<UserRole>(
                                value: UserRole.tutor,
                                child: Text('Tutor'),
                              ),
                              DropdownMenuItem<UserRole>(
                                value: UserRole.user,
                                child: Text('Usuario'),
                              ),
                            ],
                            value: _selectedRole, // Tipo UserRole?
                            onChanged: (UserRole? newValue) {
                              // Tipo UserRole?
                              setState(() {
                                _selectedRole = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    submitRegister, // Corregir la llamada de la función
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text(
                                  "Registrarse",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
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
                            Navigator.pushNamed(context, "/login");
                          },
                          child: const Text(
                            "Inicia sesión",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
