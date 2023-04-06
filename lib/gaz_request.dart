import 'package:flutter/material.dart';
import 'api/api.dart';
import 'constants/constants.dart';
import 'home_page.dart';
import 'model/request_model.dart';
import 'widgets/drop_down.dart';
import 'widgets/text_form_field.dart';

class GazRequest extends StatefulWidget {
  const GazRequest({super.key});

  @override
  State<GazRequest> createState() => _GazRequestState();
}

class _GazRequestState extends State<GazRequest> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late GazRequestModel gazRequestModel;

  bool isApiCallProcess = false;

  List<String> places = [
    'النسيم',
    'العيون',
  ];

  List<String> layers = [
    '1',
    '2',
    '3',
    '4',
  ];

  List<String> numbers = [
    '1',
    '2',
    '3',
  ];

  @override
  void initState() {
    gazRequestModel = GazRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainColor,
          title: const Text('طلب الغاز'),
        ),
        body: Stack(
          children: [
            Form(
              key: globalKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                children: [
                  //name
                  customTextFormField(
                    hintText: 'الاسم',
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'أدخل الاسم';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      gazRequestModel.name = value.toString();
                    },
                  ),

                  //phone
                  customTextFormField(
                    hintText: 'الهاتف',
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'أدخل رقم الهاتف';
                      }
                      if (value!.toString().length != 8) {
                        return 'الرجاء إدخال رقم هاتف صحيح';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      gazRequestModel.mobile = value.toString();
                    },
                  ),

                  // place
                  droupDownMenu(
                    onChanged: (item) => setState(() {
                      if (item == places[0]) {
                        gazRequestModel.adress = "1";
                      } else {
                        gazRequestModel.adress = "2";
                      }
                    }),
                    prefix: const Icon(
                      Icons.place,
                      color: Colors.grey,
                    ),
                    items: places,
                    hintText: 'اختر المنظقة',
                  ),

                  // القطعة
                  droupDownMenu(
                    onChanged: (item) => setState(() {
                      gazRequestModel.block = item;
                    }),
                    prefix: const Icon(
                      Icons.layers,
                      color: Colors.grey,
                    ),
                    items: layers,
                    hintText: 'اختر القطعة',
                  ),

                  //street
                  customTextFormField(
                    hintText: 'شارع',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.location_city,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'أدخل رقم الشارع';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      gazRequestModel.street = value.toString();
                    },
                  ),
                  //house
                  customTextFormField(
                    hintText: 'منزل',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.home,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'أدخل رقم المنزل';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      gazRequestModel.house = value.toString();
                    },
                  ),

                  // عدد الغاز
                  droupDownMenu(
                    onChanged: (item) => setState(() {
                      gazRequestModel.counter = item;
                    }),
                    prefix: const Icon(
                      Icons.numbers,
                      color: Colors.grey,
                    ),
                    items: numbers,
                    hintText: 'اختر عدد الغاز',
                  ),
                  const SizedBox(height: 40),

                  //
                  ElevatedButton(
                    onPressed: () {
                      if (validateAndSave()) {
                        setState(
                          () {
                            isApiCallProcess = true;
                          },
                        );
                        apiRequest(
                          gazRequestModel: gazRequestModel,
                        ).then(
                          (value) async {
                            setState(() {
                              isApiCallProcess = false;
                            });

                            if (value[0].send == "ok") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('تم ارسال طلبك'),
                                    content:
                                        const Text('سوف يتم الاتصال بك قريبا'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyHomePage(),
                                              ),
                                              (Route<dynamic> route) => false);
                                        },
                                        child: const Text('موافق'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              setState(
                                () {
                                  isApiCallProcess = false;
                                },
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('لم يتم ارسال طلبك'),
                                    content: Text(value[0].msg!),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('موافق'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kMainColor,
                      fixedSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'طلب',
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: isApiCallProcess ? true : false,
              child: Stack(
                children: [
                  ModalBarrier(
                    color: Colors.white.withOpacity(0.6),
                    dismissible: true,
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final FormState? form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
