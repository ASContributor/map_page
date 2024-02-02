import 'package:flutter/material.dart';
import 'package:map_page/View/Sreens/map_screen.dart';

import '../customWidgets/customAppBar.dart';

class SellProduce extends StatefulWidget {
  const SellProduce({super.key});

  @override
  State<SellProduce> createState() => _SellProduceState();
}

class _SellProduceState extends State<SellProduce> {
  final _formKey = GlobalKey<FormState>();

  List<String> dropdownValues = List.generate(10, (index) => 'Item $index');
  List<String> QuantityUnit = ['Kg', 'g'];
  String selectedValue = 'Item 0';
  String selectedQuantity = 'Kg';
  TextEditingController VarietyController = TextEditingController();
  TextEditingController QuantityController = TextEditingController();
  TextEditingController UnitController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  TextEditingController NoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SubmitButton(context),
      ),
      appBar: const CustomAppBar(
        title: 'Sell Produce',
        ButtonIsNotVisible: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 18, left: 16, right: 16, bottom: 8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ----Type of Crop ---------------------------
                  const Text(
                    ' Type of Crop ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomDropdown(
                      DropdownList: dropdownValues,
                      CurrentValue: selectedValue,
                      DropDownType: 'TypeCrop'),
                  // -------------Variety---------------
                  CustomTextInputField(
                      title: 'Variety',
                      Controller: VarietyController,
                      isNumaric: false),
                  // -------------Expected Quantity-------------
                  SizedBox(
                    child: Row(
                      children: [
                        Flexible(
                            flex: 3,
                            child: CustomTextInputField(
                                title: 'Expected Quantity',
                                Controller: QuantityController,
                                isNumaric: true)),
                        Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, top: 33),
                              child: CustomDropdown(
                                  DropdownList: QuantityUnit,
                                  CurrentValue: selectedQuantity,
                                  DropDownType: 'Quantity'),
                            )),
                      ],
                    ),
                  ),
                  // ------------Price (per Kg)------------------
                  CustomTextInputField(
                      title: 'Price (per Kg)',
                      Controller: PriceController,
                      isNumaric: true),
                  // Note
                  CustomTextInputField(
                      title: 'Note',
                      Controller: NoteController,
                      isNumaric: false),
                  // ------------Image---------------
                  const Text(
                    ' Image ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  print('Click First Image');
                                },
                                child: Image.asset('assets/cropImage.jpeg')),
                          )),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  print('Click Second Image');
                                },
                                child: Image.asset('assets/cropImage.jpeg')),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector SubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          var data = {
            'TypeOfCrop': selectedValue,
            'Variety': VarietyController.text,
            'ExpectedQuantity': QuantityController.text,
            'Quantity': selectedQuantity,
            'Price': PriceController.text,
            'Note': NoteController.text
          };
          print('FornData $data');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MapScreen()));
        }
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        child: const Center(
            child: Text(
          'Add My Produce',
          style: TextStyle(color: Colors.white, fontSize: 17),
        )),
      ),
    );
  }

// ----------------------------------------------------------------------------
  Widget CustomDropdown(
      {required List<String> DropdownList,
      required String CurrentValue,
      required String DropDownType}) {
    return Container(
      // height: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.5, color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: DropdownButtonFormField<String>(
          onChanged: (newValue) {
            if (DropDownType == 'TypeCrop') {
              setState(() {
                selectedValue = newValue!;
              });
            } else if (DropDownType == 'Quantity') {
              setState(() {
                selectedQuantity = newValue!;
              });
            }
          },
          value: CurrentValue,
          // onChanged: (String? newValue) {
          //   setState(() {
          //     CurrentValue = newValue!;
          //   });
          // },
          items: DropdownList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: const InputDecoration(border: InputBorder.none),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select an item';
            }
            return null;
          },
        ),
      ),
    );
  }

// ---------------------------------------------------------------------------
  Widget CustomTextInputField(
      {required String title,
      required TextEditingController Controller,
      required bool isNumaric}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ),
      Container(
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0.5, color: Colors.black)),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextFormField(
              keyboardType:
                  isNumaric ? TextInputType.number : TextInputType.text,
              validator: (value) {
                if (value == '') {
                  return '* required';
                } else {
                  return null;
                }
              },
              controller: Controller,
              decoration: const InputDecoration(
                  focusColor: Colors.transparent, border: InputBorder.none),
              autofocus: false,
            ),
          ))
    ]);
  }
}
