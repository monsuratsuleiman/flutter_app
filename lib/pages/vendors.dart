import 'package:flutter/material.dart';
import 'package:flutter_app/api/vendor-api.dart';
import 'package:provider/provider.dart';

import '../providers/paged-fetch-notifier.dart';

class VendorsPage extends StatelessWidget {
  const VendorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vendors")),
      body: Selector<PageItemsNotifier<Vendor>, int?>(
        // Selector is a widget from package:provider. It allows us to listen
        // to only one aspect of a provided value. In this case, we are only
        // listening to the catalog's `itemCount`, because that's all we need
        // at this level.
        selector: (context, pagedItems) => pagedItems.itemCount,
        builder: (context, itemCount, child) =>
            ListView.builder(
              // When `itemCount` is null, `ListView` assumes an infinite list.
              // Once we provide a value, it will stop the scrolling beyond
              // the last element.
              itemCount: itemCount,
              padding: const EdgeInsets.symmetric(vertical: 18),
              itemBuilder: (context, index) {
                // Every item of the `ListView` is individually listening
                // to the catalog.
                var vendorCatalog = Provider.of<PageItemsNotifier<Vendor>>(
                    context);

                // Catalog provides a single synchronous method for getting
                // the current data.
                var item = vendorCatalog.getByIndex(index);

                if (item.name == "...") {
                  return const LoadingVendorTile();
                }

                return VendorItem(item: item);
              },
            ),
      ),
    );
  }
}


/// This is the widget responsible for building the item in the list,
/// once we have the actual data [item].
class VendorItem extends StatelessWidget {
  final Vendor item;

  const VendorItem({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: Colors.primaries.first,
          ),
        ),
        title: Text(item.name, style: Theme.of(context).textTheme.headline6),
        trailing: TextButton(
          child: const Text('Edit'),
          onPressed: () {
            Navigator.pushNamed(context, '/vendors/details', arguments: {'id': item.id});
          },
        ),
      ),
    );
  }
}

/// This is the widget responsible for building the "still loading" item
/// in the list (represented with "..." and a crossed square).
class LoadingVendorTile extends StatelessWidget {
  const LoadingVendorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const AspectRatio(
          aspectRatio: 1,
          child: Placeholder(),
        ),
        title: Text('...', style: Theme.of(context).textTheme.headline6),
        trailing: const Text('\$ ...'),
      ),
    );
  }
}