part of 'pages.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  void initState() {
    super.initState();
  }

  final _loginKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  bool isHidden = true;
  String _status = "";
  String _message = "";

  @override
  void dispose() {
    ctrlEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Send Email'),
          centerTitle: true,
          backgroundColor: const Color(0XFF79018C),
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(255, 185, 108, 196),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Form(
                key: _loginKey,
                child: Column(children: [
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFF79018C),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    controller: ctrlEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return !EmailValidator.validate(value.toString())
                          ? 'Invalid email!'
                          : null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: const Color(0XFF79018C)),
                      onPressed: () async {
                        if (_loginKey.currentState!.validate()) {
                          await NamikloudService.sendMail(
                                  ctrlEmail.text.toString())
                              .then((value) {
                            var result = json.decode(value.body);
                            _message = result['message'].toString();
                            _status = result['status'].toString();
                          });
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                _status,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(_message),
                              actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            const Color(0XFF79018C)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Try Again'))
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                'Form Unfill',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content:
                                  const Text('Please fill all the fields!'),
                              actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            const Color(0XFF79018C)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Try Again'))
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text("Send")),

                  //   ElevatedButton.icon(
                  //       style: ElevatedButton.styleFrom(
                  //           shape: const StadiumBorder(),
                  //           backgroundColor: const Color(0XFF79018C)),
                  //       onPressed: () async {
                  //         if (_loginKey.currentState!.validate()) {
                  //           await NamikloudService.sendMail(ctrlEmail.toString())
                  //               .then((value) {
                  //             var result = json.decode(value.body);
                  //             showDialog(
                  //               context: context,
                  //               builder: (context) => AlertDialog(
                  //                 title: const Text(
                  //                   'Booking Confirmation',
                  //                   style: TextStyle(fontWeight: FontWeight.bold),
                  //                 ),
                  //                 content: Text(
                  //                   // 'Email: ${ctrlEmail.text}\nPass: ${ctrlPass.text}\nPhone Number: ${ctrlNumber.text}\nCity: ${ctrlCity.text}',
                  //                   '${result.message}',
                  //                 ),
                  //                 actions: [
                  //                   TextButton(
                  //                       style: TextButton.styleFrom(
                  //                           backgroundColor: Colors.white,
                  //                           foregroundColor:
                  //                               const Color(0XFF79018C)),
                  //                       onPressed: () {
                  //                         Navigator.pop(context);
                  //                       },
                  //                       child: const Text('Ok')),
                  //                 ],
                  //               ),
                  //             );
                  //           });
                  //         } else {
                  //           showDialog(
                  //             context: context,
                  //             builder: (context) => AlertDialog(
                  //               title: const Text(
                  //                 'Booking Failed',
                  //                 style: TextStyle(fontWeight: FontWeight.bold),
                  //               ),
                  //               content: const Text('Please fill all the fields!'),
                  //               actions: [
                  //                 TextButton(
                  //                     style: TextButton.styleFrom(
                  //                         backgroundColor: Colors.white,
                  //                         foregroundColor: const Color(0XFF79018C)),
                  //                     onPressed: () {
                  //                       Navigator.pop(context);
                  //                     },
                  //                     child: const Text('Try Again'))
                  //               ],
                  //             ),
                  //           );
                  //         }
                  //       },
                  //       icon: const Icon(Icons.save),
                  //       label: const Text("Book Now")),
                  // ]),
                ]))));
  }
}
