import 'package:smartui_components/custom_widget/button_view/custom_button.dart';
import 'package:smartui_components/custom_widget/custom_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartui_components/custom_widget/appbar_view/custom_appbar.dart';
import 'package:smartui_components/custom_widget/text_field_view/custom_text_field.dart';
import 'package:smartui_components/custom_widget/drop_down_view/custom_drop_down.dart';

class AppBarDemoScreen extends StatefulWidget {
  const AppBarDemoScreen({super.key});

  @override
  State<AppBarDemoScreen> createState() => _AppBarDemoScreenState();
}

class _AppBarDemoScreenState extends State<AppBarDemoScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  String? selectedCity;

  List<String> selectedSkills = [];

  String? selectedCountry;

  final List<String> countryList = [
    "India",
    "USA",
    "Japan",
    "Australia",
    "UAE",
    "UK"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(
        elevation: 1,
        title: "Demo Screen",
        backIcon: true,
        isCenterTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const Center(
            child: Text(
              "This is a demo screen using CustomAppbar.",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          CustomTextFormFieldWidget(
            textController: nameController,
            labelText: "Full Name",
            hintText: "Enter your name",
            keyboardType: TextInputType.text,
          ),

          const SizedBox(height: 20),

          CustomTextFormFieldWidget(
            textController: phoneController,
            labelText: "Mobile Number",
            hintText: "Enter mobile number",
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 20),

          CustomTextFormFieldWidget(
            textController: emailController,
            labelText: "Email Address",
            hintText: "Enter your email",
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 30),

          CustomButton(title: "Submit", onTap: () {
            if (kDebugMode) {
              print("Name: ${nameController.text}");
            }
            if (kDebugMode) {
              print("Phone: ${phoneController.text}");
            }
            if (kDebugMode) {
              print("Email: ${emailController.text}");
            }
          }),

          const SizedBox(height: 30),
          CustomImageWidget(
            "https://picsum.photos/200/300",
            100,
            100,
          ),

          const SizedBox(height: 30,),
          CustomDropDown<String>(
            label: "Select City",
            mode: DropdownMode.single,
            items: ["Surat", "Rajkot", "Vadodara"],
            selectedItem: selectedCity,
            displayText: (item) => item,
            onSingleSelect: (value) {
              setState(() => selectedCity = value);
            },
          ),

          const SizedBox(height: 20,),
          CustomDropDown<String>(
            label: "Select Skills",
            mode: DropdownMode.multi,
            items: ["Flutter", "Dart", "Firebase", "API"],
            selectedItems: selectedSkills,
            displayText: (item) => item,
            onMultiSelect: (list) {
              setState(() => selectedSkills = list);
            },
          ),

          const SizedBox(height: 30,),
          CustomDropDown<String>(
            label: "Search Country",
            mode: DropdownMode.searchable,
            items: countryList,
            selectedItem: selectedCountry,
            displayText: (item) => item,
            onSingleSelect: (value) {
              setState(() => selectedCountry = value);
            },
          )


        ],),
      ),
    );
  }
}
