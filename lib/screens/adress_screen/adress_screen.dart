import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/models/adress_model.dart';
import 'package:kayan/models/order_model.dart';
import 'package:kayan/screens/adress_screen/adress_card.dart';
import 'package:kayan/shared/shared.dart';

class Adress extends StatefulWidget {
  const Adress({Key? key}) : super(key: key);
  @override
  State<Adress> createState() => _AdressState();
}

class _AdressState extends State<Adress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _streetNameController;
  late final TextEditingController _cityNameController;
  late final TextEditingController _stateNameController;
  late final TextEditingController _detailsController;
  late final TextEditingController _floorNoController;
  late final TextEditingController _buildNoController;
  late final FocusNode _stateNode;
  late final FocusNode _cityNode;
  late final FocusNode _buildNoNode;
  late final FocusNode _floorNoNode;
  late final FocusNode _detailsNode;

  @override
  void initState() {
    if (HomeCubit.get(context).adresses.isEmpty) {
      _streetNameController = TextEditingController();
      _cityNameController = TextEditingController();
      _stateNameController = TextEditingController();
      _floorNoController = TextEditingController();
      _buildNoController = TextEditingController();
      _detailsController = TextEditingController();
      _stateNode = FocusNode();
      _cityNode = FocusNode();
      _buildNoNode = FocusNode();
      _floorNoNode = FocusNode();
      _detailsNode = FocusNode();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (HomeCubit.get(context).adresses.isEmpty) {
      _buildNoController.dispose();
      _cityNameController.dispose();
      _stateNameController.dispose();
      _floorNoController.dispose();
      _buildNoController.dispose();
      _detailsController.dispose();
      _buildNoNode.dispose();
      _stateNode.dispose();
      _cityNode.dispose();
      _detailsNode.dispose();
      _floorNoNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              //statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Theme.of(context).scaffoldBackgroundColor),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 60.0,
                horizontal: 32.0,
              ),
              child: HomeCubit.get(context).adresses.isNotEmpty
                  ? ListView.builder(
                      itemCount: HomeCubit.get(context).adresses.length,
                      itemBuilder: (context, index) {
                        return AdressCard(
                            onTap: () {
                              final cubit = HomeCubit.get(context);
                              HomeCubit.get(context).initailCart();

                              HomeCubit.get(context).addOrder(OrderModel(
                                  cubit.total,
                                  cubit.cartList.values.toList(),
                                  OrderStatus.onRoad,
                                  'الخمبس',
                                  'الخامسى مساءا',
                                  cubit.adresses[index]));
                              // int count = 0;
                              // Navigator.of(context)
                              //     .popUntil((_) => count++ >= 2);
                              // Navigator.pop(context);
                              // Navigator.pushAndRemoveUntil(context,
                              //     MaterialPageRoute(
                              //   builder: (context) {
                              //     return const MainScreen();
                              //   },
                              // ), (route) => false);
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'تم ارسال طلبك بنجاح',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Cairo',
                                              color: Colors.lightGreen),
                                    ),
                                    content: Text(
                                      'سوف يتم مراجعة طلبك وتحديد موعد تسليمه ف خلال 24 ساعة ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Cairo',
                                              color: Colors.lightGreen),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            int count = 0;
                                            Navigator.of(context)
                                                .popUntil((_) => count++ >= 2);
                                          },
                                          child: Text(
                                            'حسنا',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo',
                                                    color: Colors.lightGreen),
                                          ))
                                    ],
                                  );
                                },
                              );

                              showCentralToast(
                                  text: 'تم ارسال طلبك بنجاح',
                                  state: ToastStates.success);
                            },
                            adressModel:
                                HomeCubit.get(context).adresses[index]);
                      },
                    )
                  : AdreesForm(
                      formKey: _formKey,
                      streetNameController: _streetNameController,
                      cityNode: _cityNode,
                      stateNode: _stateNode,
                      cityNameController: _cityNameController,
                      buildNoNode: _buildNoNode,
                      stateNameController: _stateNameController,
                      floorNoNode: _floorNoNode,
                      buildNoController: _buildNoController,
                      detailsNode: _detailsNode,
                      floorNoController: _floorNoController,
                      detailsController: _detailsController,
                    ),
            ),
          ),
        ));
  }
}

class AdreesForm extends StatelessWidget {
  const AdreesForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController streetNameController,
    required FocusNode cityNode,
    required FocusNode stateNode,
    required TextEditingController cityNameController,
    required FocusNode buildNoNode,
    required TextEditingController stateNameController,
    required FocusNode floorNoNode,
    required TextEditingController buildNoController,
    required FocusNode detailsNode,
    required TextEditingController floorNoController,
    required TextEditingController detailsController,
  })  : _formKey = formKey,
        _streetNameController = streetNameController,
        _cityNode = cityNode,
        _stateNode = stateNode,
        _cityNameController = cityNameController,
        _buildNoNode = buildNoNode,
        _stateNameController = stateNameController,
        _floorNoNode = floorNoNode,
        _buildNoController = buildNoController,
        _detailsNode = detailsNode,
        _floorNoController = floorNoController,
        _detailsController = detailsController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _streetNameController;
  final FocusNode _cityNode;
  final FocusNode _stateNode;
  final TextEditingController _cityNameController;
  final FocusNode _buildNoNode;
  final TextEditingController _stateNameController;
  final FocusNode _floorNoNode;
  final TextEditingController _buildNoController;
  final FocusNode _detailsNode;
  final TextEditingController _floorNoController;
  final TextEditingController _detailsController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اضافة عنوان جديد',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Cairo',
                  color: Colors.lightGreen),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _streetNameController,
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_cityNode),
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'يجب ادخال اسم الشارع';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'اسم الشارع',
                hintText: 'اكتب اسم الشارع',
              ),
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_stateNode),
              textInputAction: TextInputAction.next,
              controller: _cityNameController,
              focusNode: _cityNode,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'يجب كتابة اسم مدينتك';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'المدينة',
                hintText: 'مدينتك',
              ),
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_buildNoNode),
              textInputAction: TextInputAction.next,
              controller: _stateNameController,
              focusNode: _stateNode,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'يجب كتابة تبع اي محافظة';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'المحافظة',
                hintText: 'محافظتك',
              ),
            ),
            const SizedBox(height: 24.0),

            TextFormField(
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_floorNoNode),
              textInputAction: TextInputAction.next,
              controller: _buildNoController,
              keyboardType: TextInputType.number,
              focusNode: _buildNoNode,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'يجب تحديد رقم المنزل او المبني';
                } else if (int.tryParse(val) == null) {
                  return 'يجب كتابة رقم منزل صحيح';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'رقم المنزل',
                hintText: 'رقم المنزل',
              ),
            ),
            const SizedBox(height: 24.0),

            TextFormField(
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_detailsNode),
              textInputAction: TextInputAction.next,
              controller: _floorNoController,
              focusNode: _floorNoNode,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'يجب تحديد رقم الطابق ';
                } else if (int.tryParse(val) == null) {
                  return 'يجب كتابة رقم طابق صحيح';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'رقم الطابق',
                hintText: 'رقم الطابق',
              ),
            ),
            const SizedBox(height: 24.0),

            TextFormField(
              // onEditingComplete: () => FocusManager.instance.primaryFocus?.unfocus(),
              textInputAction: TextInputAction.newline,
              maxLines: 6,

              textAlignVertical: TextAlignVertical.top,
              maxLength: 300,
              //expands: true,
              controller: _detailsController,
              focusNode: _detailsNode,
              decoration: const InputDecoration(
                labelText: 'ملاحظات',
                hintText: 'ملاحظات',
              ),
            ),
            const SizedBox(height: 16.0),
            // const Center(
            //         child: CircularProgressIndicator(
            //           color: Colors.lightGreen,
            //         ),
            //       )
            //     :
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  fixedSize: const Size(double.maxFinite, 60)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final AdressModel adress = AdressModel(
                      streetName: _streetNameController.text.trim(),
                      city: _cityNameController.text.trim(),
                      state: _stateNameController.text.trim(),
                      buildNo: int.parse(_buildNoController.text.trim()),
                      floor: int.parse(_floorNoController.text.trim()),
                      details: _detailsController.text.trim());
                  HomeCubit.get(context).addAdress(adress);
                  HomeCubit.get(context).initailCart();
                  HomeCubit.get(context).addOrder(OrderModel(
                      HomeCubit.get(context).total,
                      HomeCubit.get(context).cartList.values.toList(),
                      OrderStatus.review,
                      'الخمبس',
                      'الخامسة مساءا',
                      adress));
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'تم ارسال طلبك بنجاح',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Cairo',
                                  color: Colors.lightGreen),
                        ),
                        content: Text(
                          'سوف يتم مراجعة طلبك وتحديد موعد تسليمه ف خلال 24 ساعة ',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Cairo',
                                  color: Colors.lightGreen),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                int count = 0;
                                Navigator.of(context)
                                    .popUntil((_) => count++ >= 2);
                              },
                              child: Text(
                                'حسنا',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Cairo',
                                        color: Colors.lightGreen),
                              ))
                        ],
                      );
                    },
                  );
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return const MainScreen();
                  //   },
                  // ), (route) => false);
                  // int count = 0;
                  // Navigator.of(context).popUntil((_) => count++ >= 2);
                  //Navigator.pop(context);

                  showCentralToast(
                      text: 'تم ارسال طلبك بنجاح', state: ToastStates.success);
                }
              },
              child: Text(
                'اضافة عنوان',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                    ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}