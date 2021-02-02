// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'flutter_fb_news.dart';

// Customize the appearance of the posts
class FbNewsConfig {
  /// Subtitle in the every feeditem
  final String subtitle;

  /// The [waiting] widget is displayed when the data is loaded
  ///
  /// #### DEFAULT
  /// ```dart
  /// Column(
  ///   children: [
  ///       CircularProgressIndicator(),
  ///       SizedBox(
  ///           height: 10,
  ///       )
  ///   ],
  /// );
  /// ```
  final Widget waiting;

  /// The [noDataOrError] widget is displayed if the response contains no data or an error
  ///
  /// #### DEFAULT
  /// ```dart
  /// Card(
  ///   color: Colors.red,
  ///    child: Row(
  ///       mainAxisAlignment: MainAxisAlignment.center,
  ///       children: [
  ///           Text(
  ///               snapshot.error.toString(),
  ///               style: TextStyle(
  ///                   color: Colors.white,
  ///               ),
  ///           )
  ///       ],
  ///   ),
  /// );
  /// ```
  final Widget noDataOrError;

  /// #### Select which fields to display
  /// Supported fields are
  /// ```dart
  /// [
  ///   FbNewsFields.header,
  ///   FbNewsFields.attachmentsPhotos,
  ///   FbNewsFields.attachmentsVideos,
  ///   FbNewsFields.message,
  ///   FbNewsFields.footer,
  /// ];
  /// ```
  ///
  /// #### DEFAULT
  /// ```dart
  /// [
  ///   FbNewsFields.header,
  ///   FbNewsFields.attachmentsPhotos,
  ///   FbNewsFields.attachmentsVideos,
  ///   FbNewsFields.message,
  ///   FbNewsFields.footer,
  /// ];
  /// ```
  final List<FbNewsFieldName> fields;

  /// Set the Color of the border
  ///
  /// #### DEFAULT
  /// Theme.of(context).accentColor
  final Color borderColor;

  /// Toogle the display of the border
  ///
  /// #### DEFAULT = true
  final bool showBorder;

  /// Set the Color of the background
  ///
  /// #### DEFAULT
  /// If this property is null then [CardTheme.color] of [ThemeData.cardTheme]
  /// is used. If that's null then [ThemeData.cardColor] is used.
  final Color backgroundColor;

  /// Set the Color of the text
  final Color textColor;

  /// Set the Color of a link
  final Color linkColor;

  FbNewsConfig({
    this.subtitle = "von Facebook",
    this.waiting,
    this.noDataOrError,
    fields,
    this.borderColor,
    this.showBorder = true,
    this.backgroundColor,
    this.textColor,
    this.linkColor,
  }) : fields = [
          FbNewsFields.header,
          FbNewsFields.attachmentsPhotos,
          FbNewsFields.attachmentsVideos,
          FbNewsFields.message,
          FbNewsFields.footer,
        ];
}
