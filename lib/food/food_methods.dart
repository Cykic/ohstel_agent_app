import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ohostel_hostel_agent_app/food/models/extras_food_details.dart';
import 'package:ohostel_hostel_agent_app/food/models/fast_food_details_model.dart';

import 'models/food_details_model.dart';

class FoodMethods {
  final CollectionReference foodCollectionRef =
      Firestore.instance.collection('food');

  final CollectionReference orderedFoodCollectionRef =
      Firestore.instance.collection('orderedFood');

  Future<void> saveFoodToServer({@required FastFoodModel foodModel}) async {
    try {
      DocumentSnapshot doc =
          await foodCollectionRef.document(foodModel.fastFoodName).get();

      if (doc.exists) {
        print('Fast Food Already Exist');
        throw Exception('Fast Food Already Exist');
      } else if (!doc.exists) {
        await foodCollectionRef
            .document(foodModel.fastFoodName)
            .setData(foodModel.toMap());
        Fluttertoast.showToast(msg: 'Hostel Added To DateBase');
      }
      //
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }

  Future<void> saveFoodItemToServer({@required ItemDetails foodItems}) async {
    try {
      print('laoding......');
      DocumentSnapshot doc =
          await foodCollectionRef.document(foodItems.itemFastFoodName).get();

      if (doc.exists) {
        await foodCollectionRef
            .document(foodItems.itemFastFoodName)
            .updateData({
          'itemDetails': FieldValue.arrayUnion([foodItems.toMap()]),
        });

        Fluttertoast.showToast(msg: 'Hostel Added To DateBase');
      } else if (!doc.exists) {
        print(foodItems.itemFastFoodName);
        print('Fast Food Name Not Found');
        throw Exception('Fast Food Name Not Found');
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }

  Future<void> saveExtraFoodItemToServer(
      {@required ExtraItemDetails extraFoodItems}) async {
    try {
      print('laoding......');
      DocumentSnapshot doc = await foodCollectionRef
          .document(extraFoodItems.extraItemFastFoodName)
          .get();

      if (doc.exists) {
        await foodCollectionRef
            .document(extraFoodItems.extraItemFastFoodName)
            .updateData({
          'extraItems': FieldValue.arrayUnion([extraFoodItems.toMap()]),
        });

        Fluttertoast.showToast(msg: 'Hostel Added To DateBase');
      } else if (!doc.exists) {
        print(extraFoodItems.extraItemFastFoodName);
        print('Fast Food Name Not Found');
        throw Exception('Fast Food Name Not Found');
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }

  Future updateItemDetails({
    @required List itemDetails,
    @required String fastFoodName,
  }) async {
    try {
      print('lolll');

      await foodCollectionRef.document(fastFoodName).updateData({
        'itemDetails': itemDetails,
      });
      print('Updated!!');
      Fluttertoast.showToast(msg: 'Updated!!');
    } catch (err) {
      print(err);
      Fluttertoast.showToast(msg: '$err');
    }
  }

  Future<void> saveDrinkToServer({@required ItemDetails itemDetails}) async {
    try {
      FastFoodModel foodModel = FastFoodModel(
        fastFoodName: 'drinks',
        address: 'none',
        openTime: 'always Open',
        logoImageUrl: null,
        itemDetails: [itemDetails.toMap()],
        extraItems: [],
        itemCategoriesList: [],
        haveExtras: false,
        uniName: 'all',
        locationName: 'none',
        display: false,
      );

      DocumentSnapshot doc =
          await foodCollectionRef.document(foodModel.fastFoodName).get();

      if (doc.exists) {
        print('Drink Collection Already Exist');
        await foodCollectionRef.document(foodModel.fastFoodName).updateData({
          'itemDetails': FieldValue.arrayUnion([itemDetails.toMap()]),
        });
      } else if (!doc.exists) {
        await foodCollectionRef
            .document(foodModel.fastFoodName)
            .setData(foodModel.toMap(), merge: true);
        Fluttertoast.showToast(msg: 'Drink Added To DateBase');
      }
      //
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }
}
