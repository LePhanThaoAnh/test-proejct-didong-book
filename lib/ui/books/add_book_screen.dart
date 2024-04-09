// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/book.dart';
// import '../shared/dialog_utils.dart';
// import 'books_manager.dart';

// class AddBookScreen extends StatefulWidget {
//   static const routeName = '/add-book';

//   AddBookScreen(
//     Book? book, {
//     super.key,
//   }) {
//     if (book == null) {
//       this.book = Book(
//         id: null,
//         title: '',
//         price: 0,
//         author: '',
//         description: '',
//         category: '',
//         imageUrl: '',
//       );
//     } else {
//       this.book = book;
//     }
//   }
//   late final Book book;
//   @override
//   State<AddBookScreen> createState() => _AddBookScreenState();
// }

// class _AddBookScreenState extends State<AddBookScreen> {
//   final _imageUrlController = TextEditingController();
//   final _imageUrlFocusNode = FocusNode();
//   final _editForm = GlobalKey<FormState>();
//   late Book _addedBook;
//   var _isLoading = false;
//   bool _isValidImageUrl(String value) {
//     return (value.startsWith('http') || value.startsWith('https')) &&
//         (value.endsWith('.png') ||
//             value.endsWith('.jpg') ||
//             value.endsWith('.jpeg'));
//   }

// //khởi tạo biến
//   @override
//   void initState() {
//     _imageUrlFocusNode.addListener(() {
//       if (!_imageUrlFocusNode.hasFocus) {
//         if (!_isValidImageUrl(_imageUrlController.text)) {
//           return;
//         }
//         setState(() {});
//       }
//     });
//     _addedBook = widget.book;
//     _imageUrlController.text = _addedBook.imageUrl;
//     super.initState();
//   }

//   // giải phóng biến
//   @override
//   void dispose() {
//     _imageUrlController.dispose();
//     _imageUrlFocusNode.dispose();
//     super.dispose();
//   }

//   Future<void> _saveForm() async {
//     final isValid = _editForm.currentState!.validate();
//     if (!isValid) {
//       return;
//     }
//     _editForm.currentState!.save();

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final booksManager = context.read<BooksManager>();
//       if (_addedBook.id != null) {
//         await booksManager.updateBook(_addedBook);
//       } else {
//         await booksManager.addBook(_addedBook);
//       }
//     } catch (error) {
//       if (mounted) {
//         await showErrorDialog(context, 'Something went wrong.');
//       }
//     }

//     setState(() {
//       _isLoading = false;
//     });
//     if (mounted) {
//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Book'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: _saveForm,
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _editForm,
//                 child: ListView(
//                   children: <Widget>[
//                     _buildTitleField(),
//                     _buildPriceField(),
//                     _buildDescriptionField(),
//                     _buildBookPreview(),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   TextFormField _buildTitleField() {
//     return TextFormField(
//       initialValue: _addedBook.title,
//       decoration: const InputDecoration(labelText: 'Title'),
//       textInputAction: TextInputAction.next,
//       autofocus: true,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please provide a value';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _addedBook = _addedBook.copyWith(title: value);
//       },
//     );
//   }

//   TextFormField _buildPriceField() {
//     return TextFormField(
//       initialValue: _addedBook.price.toString(),
//       decoration: const InputDecoration(labelText: 'Price'),
//       textInputAction: TextInputAction.next,
//       keyboardType: TextInputType.number,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter a price';
//         }
//         if (double.tryParse(value) == null) {
//           return 'Please enter a valid number';
//         }
//         if (double.parse(value) <= 0) {
//           return 'Please enter a number greater than zero.';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _addedBook = _addedBook.copyWith(price: double.parse(value!));
//       },
//     );
//   }

//   TextFormField _buildDescriptionField() {
//     return TextFormField(
//       initialValue: _addedBook.description,
//       decoration: const InputDecoration(labelText: 'Description'),
//       maxLines: 3,
//       keyboardType: TextInputType.multiline,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please privide a description';
//         }
//         if (value.length < 10) {
//           return 'Should be at least 10 characters long.';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _addedBook = _addedBook.copyWith(description: value);
//       },
//     );
//   }

//   Widget _buildBookPreview() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         Container(
//           width: 100,
//           height: 100,
//           margin: const EdgeInsets.only(top: 8, right: 8),
//           decoration: BoxDecoration(
//             border: Border.all(width: 1, color: Colors.grey),
//           ),
//           child: _imageUrlController.text.isEmpty
//               ? const Text('Enter a URL')
//               : FittedBox(
//                   child: Image.network(
//                     _imageUrlController.text,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//         ),
//         Expanded(
//           child: _buildImageURLField(),
//         )
//       ],
//     );
//   }

//   TextFormField _buildImageURLField() {
//     return TextFormField(
//       decoration: const InputDecoration(labelText: 'Image URL'),
//       keyboardType: TextInputType.url,
//       textInputAction: TextInputAction.done,
//       controller: _imageUrlController,
//       focusNode: _imageUrlFocusNode,
//       onFieldSubmitted: (value) => _saveForm(),
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter an image URL';
//         }
//         if (!_isValidImageUrl(value)) {
//           return 'Please enter a valid image URL.';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _addedBook = _addedBook.copyWith(imageUrl: value);
//       },
//     );
//   }

//   // Future<void> _saveForm() async {

//   // }
// }
