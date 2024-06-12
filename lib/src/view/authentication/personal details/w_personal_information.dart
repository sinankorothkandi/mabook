import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mabook/src/controller/user_informatin_contrller.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/const/text_field.dart';

Form detailsAddingForm(UserDetailsController ctrl, BuildContext context) {
  return Form(
    key: ctrl.userFormKey,
    child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        imagePicker(ctrl),
        const SizedBox(
          height: 20,
        ),
        CustomTextFiel(
          titleText: 'Full Name',
          hintText: 'enter your name',
          controller: ctrl.nameController.value,
          validatorText: 'please enter your name',
        ),
        CustomTextFiel(
            titleText: 'Phone No',
            keyboardtype: TextInputType.phone,
            hintText: 'enter your number',
            controller: ctrl.numberController.value,
            validatorText: 'please enter your number'),
        CustomTextFiel(
          titleText: 'Address',
          hintText: 'enter your address',
          controller: ctrl.addressController.value,
          validatorText: 'please enter your address',
          maxline: null,
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, top: 5, right: 80, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Blood Group',
                style: GoogleFonts.poppins(color: green, fontSize: 20),
              ),
              Text(
                'Gender',
                style: GoogleFonts.poppins(color: green, fontSize: 20),
              ),
            ],
          ),
        ),
        selectingGenterAndBG(ctrl),
        const SizedBox(
          height: 7,
        ),
        seletingDob(ctrl, context),
        savingBottun(ctrl)
      ],
    ),
  );
}

Padding savingBottun(UserDetailsController ctrl) {
  return Padding(
      padding: const EdgeInsets.only(
        top: 40,
      ),
      child: SizedBox(
        width: 365,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            if (ctrl.userFormKey.currentState!.validate()) {
              ctrl.addUserDetails();
             
            } else {
              Get.snackbar(
                  "Validation Error", "Please correct the form errors.");
              return;
            }
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: green,
          ),
          child: const Text(
            "Add Details",
            style: TextStyle(color: white, fontSize: 18),
          ),
        ),
      ));
}

Padding seletingDob(UserDetailsController ctrl, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Of Birth',
          style: GoogleFonts.poppins(color: green, fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: green, width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                children: [
                  ctrl.dob.value == null
                      ? Text(
                          "enter date of birth",
                          style: GoogleFonts.poppins(color: grey, fontSize: 20),
                        )
                      : Text(
                          DateFormat('dd-MMM-yyyy').format(ctrl.dob.value!),
                          style: GoogleFonts.poppins(color: grey, fontSize: 20),
                        ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      await ctrl.showDOBCalendarDialog(context);
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: grey,
                    ),
                  ),
                ],
              ),
            )),
      ],
    ),
  );
}

Padding selectingGenterAndBG(UserDetailsController ctrl) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Row(children: [
      SizedBox(
          height: 45,
          width: 125,
          child: TextFormField(
            controller: ctrl.bloodGroupController.value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 30),
              hintText: 'blood ',
              hintStyle: GoogleFonts.poppins(color: grey, fontSize: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: green, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: green, width: 3),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter blood group';
              }
              return null;
            },
          )),
      const Spacer(),
      Container(
          height: 45,
          width: 125,
          decoration: BoxDecoration(
            border: Border.all(color: green, width: 2),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: ctrl.dropdownValue.value,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                style: const TextStyle(color: grey),
                dropdownColor: white,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    ctrl.setDropdownValue(newValue);
                  }
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'One',
                    child:
                        Text('Male', style: GoogleFonts.poppins(fontSize: 19)),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Two',
                    child: Text('Female',
                        style: GoogleFonts.poppins(fontSize: 19)),
                  ),
                ],
              ),
            ),
          )),
    ]),
  );
}

GestureDetector imagePicker(UserDetailsController ctrl) {
  return GestureDetector(
    onTap: () {
      ctrl.pickImage();
    },
    child: CircleAvatar(
      backgroundColor: Colors.blueGrey,
      radius: 50,
      backgroundImage: ctrl.imageFile.value != null
          ? FileImage(ctrl.imageFile.value!)
          : null,
      child: ctrl.imageFile.value == null
          ? const Icon(
              Icons.add_photo_alternate,
              color: black,
            )
          : null,
    ),
  );
}
