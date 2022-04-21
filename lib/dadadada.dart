// stream: FirebaseFirestore.instance
//     .collection('amenities')
// .where('gym_id', arrayContains: doc["gym_id"])
// .snapshots(),
builder: (BuildContext context, AsyncSnapshot snapshot) {
if (!snapshot.hasData) {
return Center(child: CircularProgressIndicator());
}
if (snapshot.connectionState ==
ConnectionState.waiting) {
return Center(child: CircularProgressIndicator());
}
var documents = snapshot.data.docs;
print(documents);
