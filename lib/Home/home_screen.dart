import 'package:contact/Core/app_colors.dart';
import 'package:contact/Modules/contacts.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? _image;

  Future<void> _pickImage(StateSetter setDialogState) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      setDialogState(() {});
    }
  }

  void _addNewContact() {
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(builder: (context, setDialogState) {
        return AlertDialog(
          backgroundColor: AppColors.darkBlue,
          content: Container(
            height: 420,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickImage(setDialogState);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.gold)),
                          width: 120,
                          height: 120,
                          child: _image == null
                              ? Lottie.asset(
                                  'assets/animation/image_picker.json')
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nameController.text.isNotEmpty
                                  ? nameController.text
                                  : "User name",
                              style: TextStyle(
                                  color: nameController.text.isNotEmpty
                                      ? AppColors.gold
                                      : Colors.grey,
                                  fontSize: 12),
                            ),
                            Divider(
                              color: AppColors.gold,
                            ),
                            Text(
                              emailController.text.isNotEmpty
                                  ? emailController.text
                                  : "User email",
                              style: TextStyle(
                                  color: emailController.text.isNotEmpty
                                      ? AppColors.gold
                                      : Colors.grey,
                                  fontSize: 12),
                            ),
                            Divider(
                              color: AppColors.gold,
                            ),
                            Text(
                              phoneController.text.isNotEmpty
                                  ? phoneController.text
                                  : "User phone",
                              style: TextStyle(
                                  color: phoneController.text.isNotEmpty
                                      ? AppColors.gold
                                      : Colors.grey,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: TextFormField(
                      style: TextStyle(color: AppColors.gold),
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 8, left: 16),
                        hintText: "Enter user name",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a valid name";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setDialogState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    child: TextFormField(
                      style: TextStyle(color: AppColors.gold),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 8, left: 16),
                        hintText: "Enter user email",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                      ),
                      validator: (value) {
                        bool emailValid = RegExp(
                                r"^(?=[a-zA-Z0-9._%+-]{1,64}@)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(value!);
                        if (value.isEmpty) {
                          return "Enter email";
                        } else if (!emailValid) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setDialogState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    child: TextFormField(
                      style: TextStyle(color: AppColors.gold),
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 8, left: 16),
                        hintText: "Enter user phone",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors.gold),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setDialogState(() {});
                      },
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.darkBlue,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            Contacts.contacts.add({
                              "image": _image!.path,
                              "name": nameController.text,
                              "email": emailController.text,
                              "phone": phoneController.text,
                            });
                          });
                          _image = null;
                          nameController.clear();
                          emailController.clear();
                          phoneController.clear();
                          Navigator.of(ctx).pop();
                        }
                      },
                      child: Text('Enter user'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _deleteContact(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Delete Contact"),
        content: Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                Contacts.contacts.removeAt(index);
              });
              Navigator.of(ctx).pop();
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _deleteLastContact() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Delete Contact"),
        content: Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                Contacts.contacts.removeLast();
              });
              Navigator.of(ctx).pop();
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Route Logo.png',
          width: 117,
          height: 39,
          fit: BoxFit.fill,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Contacts.contacts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lottie Animation
                      Lottie.asset(
                        'assets/animation/empty_list.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "There is No Contacts Added Here",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.gold,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: Contacts.contacts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8)),
                                  child: Image.file(
                                    File(Contacts.contacts[index]["image"]!),
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  height: 24,
                                  width: ((Contacts.contacts[index]["name"]!
                                              .length) *
                                          10) +
                                      8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.gold,
                                  ),
                                  child: Center(
                                    child: Text(
                                      Contacts.contacts[index]["name"]!,
                                      style: TextStyle(
                                          color: AppColors.darkBlue,
                                          fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 4, right: 8, left: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                color: AppColors.gold,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.email,
                                          color: AppColors.darkBlue, size: 20),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          Contacts.contacts[index]["email"]!,
                                          style: TextStyle(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone,
                                          color: AppColors.darkBlue, size: 20),
                                      SizedBox(width: 4),
                                      Text(
                                        Contacts.contacts[index]["phone"]!,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 31,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: AppColors.white,
                                      ),
                                      onPressed: () => _deleteContact(index),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.delete),
                                          SizedBox(width: 4),
                                          Text("Delete"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: Contacts.contacts.length >= 1,
            child: FloatingActionButton(
              foregroundColor: AppColors.white,
              backgroundColor: Colors.red,
              onPressed: () => _deleteLastContact(),
              child: Icon(Icons.delete),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Visibility(
            visible: Contacts.contacts.length < 6,
            child: FloatingActionButton(
              foregroundColor: AppColors.darkBlue,
              backgroundColor: AppColors.gold,
              onPressed: _addNewContact,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
