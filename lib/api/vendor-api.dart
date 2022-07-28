
// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'package:flutter_app/api/paged-items.dart';

const vendorLength = 200;

/// This function emulates a REST API call. You can imagine replacing its
/// contents with an actual network call, keeping the signature the same.
///
/// It will fetch a page of items from [startingIndex].
Future<Vendor> fetchVendor(int id) async {
  // We're emulating the delay inherent to making a network call.
  await Future<void>.delayed(const Duration(milliseconds: 500));
  return Vendor(name: "Vendor $id", id: id);
}
Future<PagedItems<Vendor>> fetchPage(int startingIndex, int itemsPerPage) async {
  // We're emulating the delay inherent to making a network call.
  await Future<void>.delayed(const Duration(milliseconds: 500));

  // If the [startingIndex] is beyond the bounds of the catalog, an
  // empty page will be returned.
  if (startingIndex > vendorLength) {
    return PagedItems(
      items: [],
      startingIndex: startingIndex,
      hasNext: false,
    );
  }

  // The page of items is generated here.
  return PagedItems(
    items: List.generate(
        min(itemsPerPage, vendorLength - startingIndex),
            (index) =>
            Vendor(
              name: 'Vendor #${startingIndex + index}',
              id: index,
            )),
    startingIndex: startingIndex,
    // Returns `false` if we've reached the [catalogLength].
    hasNext: startingIndex + itemsPerPage < vendorLength,
  );
}



class Vendor {
  final int id;

  final String name;

  Vendor({
    required this.name,
    required this.id,
  });
}
