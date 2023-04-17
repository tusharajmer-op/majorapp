/*module to implement firestore requests*/
import "package:cloud_firestore/cloud_firestore.dart";

class FirestoreDatabase {
  final dbase = FirebaseFirestore.instance;
//funtion to fetch Quotes from firestore
  Future getQuote() async {
    dynamic res = ["error"];
    try {
      final quote = await dbase.collection("quotes").get();
      return [
        quote.docs[0].get("quotes").toString(),
        quote.docs[0].get("author").toString()
      ];
    } catch (e) {
      return res;
    }
  }

//funtion to fetch songs from firestore
  Future getSongs() async {
    try {
      final songsData = await dbase.collection("music").get();
      List<Map<String, dynamic>> updatedDocs = songsData.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        // add new field to data map
        data['isVideo'] = false;
        // return the updated document data
        return data;
      }).toList();
      return updatedDocs;
    } catch (e) {
      rethrow;
    }
  }

// Function to fetch videos from firestore
  Future getvideos() async {
    try {
      final songsData = await dbase.collection("videos").get();

      List<Map<String, dynamic>> updatedDocs = songsData.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        // add new field to data map
        data['isVideo'] = true;
        // return the updated document data
        return data;
      }).toList();

      return updatedDocs;
    } catch (e) {
      rethrow;
    }
  }

//funtion to fetch categories from firestore
  Future getCatagory() async {
    try {
      final categorysData = await dbase.collection("category").get();
      return categorysData.docs;
    } catch (e) {
      rethrow;
    }
  }

//funtion to fetch songs based on query from firestore
  Future getmusic(query) async {
    try {
      final categorysData = await dbase
          .collection("music")
          .where("category", isEqualTo: query)
          .get();

       
      List<Map<String, dynamic>> updatedDocs = categorysData.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        // add new field to data map
        data['isVideo'] = false;
        // return the updated document data
        return data;
      }).toList();   
      return updatedDocs;
    } catch (e) {
      rethrow;
    }
  }
  Future getvideosquery(query) async {
    try {
      final categorysData = await dbase
          .collection("videos")
          .where("category", isEqualTo: query)
          .get();

       
      List<Map<String, dynamic>> updatedDocs = categorysData.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        // add new field to data map
        data['isVideo'] = true;
        // return the updated document data
        return data;
      }).toList();   
      return updatedDocs;
    } catch (e) {
      rethrow;
    }
  }
}
