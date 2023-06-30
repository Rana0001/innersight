import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/component/message.dart';
import 'package:innersight/models/appointment_book.dart';
import 'package:innersight/models/payment.dart';
import 'package:innersight/models/reports.dart';
import 'package:intl/intl.dart';
import '../models/appointment.dart';
import '../models/doctors.dart';
import '../models/patient.dart';

class Services {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  /// Creating a signup function
  Future<bool> signUpWithGoogle(BuildContext context) async {
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in flow
        return false;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the access token
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      bool value = await firebaseFirestore
          .collection('patients')
          .where("email", isEqualTo: googleUser.email)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          Messages.errorMessage("Error! User Already Exist.", context);
          return true;
        }
        return false;
      });

      if (value) {
        return false;
      } else {
        // Sign up with Firebase using the Google credential
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Access the user information
        final User? user = userCredential.user;
        if (user != null) {
          // Extract the required information from the user object
          String? email = user.email;
          String? profile = user.photoURL;
          String? firstName = user.displayName?.split(" ")[0];
          String? lastName = user.displayName?.split(" ")[1];
          String? phone = user.phoneNumber;

          // Create a Patient model instance with the extracted information
          Patient patient = Patient(
            id: user.uid,
            email: email,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            profileUrl: profile,
            date: "",
          );

          // Save the patient information to your desired storage (e.g., Firestore)
          bool result = await firebaseFirestore
              .collection('patients')
              .doc(_auth.currentUser!.uid)
              .set(patient.toJson())
              .then((value) {
            return true;
          }).catchError((err) {
            return false;
          });

          if (result) {
            return true;
          }
        }
      }
    } catch (e) {
      // Handle any errors that occurred during the signup process
      Messages.errorMessage(
          'Error signing up with Google: ${e.toString()}', context);
      debugPrint(e.toString());
      return false;
    }
    return false;
  }

  /// Creating a signup function using firebase and store data in firebase firestore
  Future<bool> signUp(
      Patient? patient, String password, BuildContext context) async {
    try {
      // Create a new user in Firebase using the email and password
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: patient!.email!, password: password);

      // Access the newly created user instance
      final User? user = userCredential.user;
      await user?.sendEmailVerification();
      patient.id = user?.uid;
      if (user != null) {
        // Save the patient information to your desired storage (e.g., Firestore)
        bool result = await firebaseFirestore
            .collection('patients')
            .doc(_auth.currentUser!.uid)
            .set(patient.toJson())
            .then((value) {
          return true;
        });

        if (result) {
          return true;
        }
      }
    } catch (e) {
      // Handle any errors that occurred during the signup process
      Messages.errorMessage('Error signing up: ${e.toString()}', context);
      return false;
    }
    return false;
  }

  Future<bool> loginWithGoogle(BuildContext context) async {
    try {
      // Trigger the Google sign-in flow
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in flow
        return false;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the access token
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        bool result = await firebaseFirestore
            .collection('patients')
            .doc(_auth.currentUser!.uid)
            .get()
            .then((value) {
          debugPrint(_auth.currentUser?.uid.toString());
          debugPrint(value.data().toString());
          Constant.patient = Patient.fromJson(value.data());
          return true;
        });
        if (result) {
          return true;
        }
      }
    } catch (e) {
      Messages.errorMessage(
          'Error signing in with Google: ${e.toString()}', context);
      return false;
    }
    return false;
  }

  /// Creating a login function using firebase
  Future<bool> loginWithEmail(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = userCredential.user;
      if (user!.emailVerified) {
        bool value = await firebaseFirestore
            .collection('patients')
            .doc(_auth.currentUser!.uid)
            .get()
            .then((value) {
          Constant.patient = Patient.fromJson(value.data());
          return true;
        });
        if (value) {
          return true;
        }
      } else {
        Messages.errorMessage("Error! Email Not Verified.", context);
        return false;
      }
    } catch (e) {
      Messages.errorMessage('Error signing in: ${e.toString()}', context);
      return false;
    }

    return false;
  }

  /// Creating a logout function
  Future<bool> logout(BuildContext context) async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      Constant.patient = Patient();
      return true;
    } catch (e) {
      Messages.errorMessage('Error signing out: ${e.toString()}', context);
      return false;
    }
  }

  Future<void> sendForgetMail(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Messages.errorMessage(e.toString(), context);
    }
  }

  Future<void> changePassword(String email, String password, String newPassword,
      BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = userCredential.user;
      if (user != null) {
        await user.updatePassword(newPassword).then((value) {
          Messages.successMessage("Password Changed Successfully", context);
        }).catchError((err) {
          Messages.errorMessage(err.toString(), context);
        });
      } else {
        Messages.errorMessage("Current Password is not Matched.", context);
      }
    } catch (e) {
      Messages.errorMessage(e.toString(), context);
    }
  }

  Future<bool> makePayment(Payment payment, BuildContext context) async {
    try {
      payment.patientId = _auth.currentUser!.uid;

      bool value = await firebaseFirestore
          .collection('payments')
          .doc(_auth.currentUser!.uid)
          .set(payment.toJson())
          .then((value) {
        Messages.successMessage("Payment Done Successfully", context);
        return true;
      }).catchError((err) {
        Messages.errorMessage(err.toString(), context);
        return false;
      });
      return value;
    } catch (err) {
      Messages.errorMessage(err.toString(), context);
      return false;
    }
  }

  Future<bool> setMedicalReport(
      String typeOfRecord, List<File> imageRecords, String issuedBy) async {
    List<String> images = [];

    for (int i = 0; i < imageRecords.length; i++) {
      File imageFile = imageRecords[i];
      String imageName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

      Reference storageReference = firebaseStorage
          .ref("patient/${Constant.patient.id}/reports")
          .child(imageName);

      UploadTask uploadTask = storageReference.putFile(imageFile);
      String profileUrl = await (await uploadTask).ref.getDownloadURL();
      images.add(profileUrl);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print(
            'Upload ${i + 1}/${imageRecords.length}: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
      }, onError: (Object e) {
        print('Error uploading image ${i + 1}: $e');
      }, onDone: () {
        print('Image ${i + 1} uploaded successfully.');
      });
    }

    Reports reports = Reports(
      typeOfRecord: typeOfRecord,
      reportImages: images,
      issuedBY: issuedBy,
      dateOfUpload: DateFormat("yyyy-MM-dd").format(DateTime.now()),
    );

    bool result = await firebaseFirestore
        .collection('patients')
        .doc(Constant.patient.id)
        .collection('reports')
        .doc()
        .set(reports.toJson())
        .then((value) => true)
        .catchError((error) {
      debugPrint(error.toString());
      return false;
    });

    return result;
  }

  Future<List<Reports>> getReports() async {
    try {
      List<Reports> listReport = [];

      Reports reports = Reports();
      await firebaseFirestore
          .collection('patients')
          .doc(Constant.patient.id)
          .collection('reports')
          .get()
          .then((value) {
        for (var docs in value.docs) {
          reports = Reports.fromJson(docs.data());

          /// print docs

          listReport.add(reports);
          Constant.reportID.add(docs.id.toString());
        }
      });
      return listReport;
    } catch (err) {
      return [];
    }
  }

  /// Delete a single report
  Future<bool> deleteReport(String reportId) async {
    try {
      await firebaseFirestore
          .collection('patients')
          .doc(Constant.patient.id)
          .collection('reports')
          .doc(reportId)
          .delete();
      return true;
    } catch (err) {
      return false;
    }
  }

  /// Get all doctor
  Future<List<Doctor>> getAllDoctor() async {
    try {
      List<Doctor> listDoctor = [];

      Doctor doctor = Doctor();
      await firebaseFirestore.collection('doctors').get().then((value) {
        for (var docs in value.docs) {
          doctor = Doctor.fromJson(docs.data());

          /// print docs

          listDoctor.add(doctor);
        }
      });
      return listDoctor;
    } catch (err) {
      return [];
    }
  }

  Future<List<String>> getAppointment(String? date, String docID) async {
    await firebaseFirestore
        .collection('doctors')
        .doc(docID)
        .collection('appointments')
        .doc("$docID-$date")
        .get()
        .then((value) {
      if (value.exists) {
        Constant.appointment = Appointment.fromJson(value.data()!);
        debugPrint(Constant.appointment.timeSlot.toString());
      } else {
        Constant.appointment = Appointment();
      }
    }).catchError((err) {
      Constant.appointment = Appointment();
      debugPrint(err.toString());
    });
    return Constant.appointment.timeSlot!;
  }

  Future<bool> bookAppointment(
      AppointmentBooked appointmentBooked, BuildContext context) async {
    appointmentBooked.patientID = _auth.currentUser!.uid;
    try {
      bool result = await firebaseFirestore
          .collection('booked_appointments')
          .doc(
              "${appointmentBooked.doctorId}-${appointmentBooked.date}-${appointmentBooked.timeSlot}")
          .set(appointmentBooked.toJson())
          .then((value) {
        Messages.successMessage("Appointment Booked Successfully", context);
        return true;
      }).catchError((err) {
        Messages.errorMessage(err.toString(), context);
        return false;
      });
      return result;
    } catch (err) {
      Messages.errorMessage(err.toString(), context);
      return false;
    }
  }

  Future<bool> updateProfile(
      {Patient? patient, File? img, BuildContext? context}) async {
    try {
      if (img != null) {
        final storage = firebaseStorage.ref("patient/${Constant.patient.id}");
        storage.putFile(img);
        String profileUrl = await storage.getDownloadURL();
        debugPrint(profileUrl);
        patient!.profileUrl = profileUrl;
      } else {
        patient!.profileUrl = Constant.patient.profileUrl;
      }

      bool result = await firebaseFirestore
          .collection('patients')
          .doc(_auth.currentUser!.uid)
          .update(patient.toJson())
          .then((value) async {
        await firebaseFirestore
            .collection('patients')
            .doc(_auth.currentUser!.uid)
            .get()
            .then((value) {
          if (value.exists) {
            Constant.patient = Patient.fromJson(value.data()!);
          }
        });
        Messages.successMessage("Profile Updated Successfully", context!);
        return true;
      }).catchError((err) {
        Messages.errorMessage(err.toString(), context!);
        return false;
      });
      return result;
    } catch (err) {
      Messages.errorMessage(err.toString(), context!);
      return false;
    }
  }

  Future<Doctor> getDoctor(String docID) async {
    Doctor doctor = Doctor();

    try {
      doctor = await firebaseFirestore
          .collection('doctors')
          .doc(docID)
          .get()
          .then((value) {
        Constant.doctor = Doctor.fromJson(value.data()!);
        return Doctor.fromJson(value.data()!);
      });
      return doctor;
    } catch (err) {
      return doctor;
    }
  }
}
