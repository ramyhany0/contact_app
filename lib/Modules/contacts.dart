import 'package:contact/Core/app_colors.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  static List<Map<String, String>> contacts = [];

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                    Image.asset(
                      width: 177,
                      Contacts.contacts[index]["image"]!,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      height: 24,
                      width:
                          ((Contacts.contacts[index]["name"]!.length) * 10) + 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.gold,
                      ),
                      child: Center(
                        child: Text(
                          Contacts.contacts[index]["name"]!,
                          style: TextStyle(
                              color: AppColors.darkBlue, fontSize: 14),
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
                  padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: AppColors.gold,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              maxLines: 1,
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
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: AppColors.white,
                          ),
                          onPressed: () => _deleteContact(index),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
