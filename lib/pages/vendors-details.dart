import 'package:flutter/material.dart';
import 'package:flutter_app/api/vendor-api.dart';
import 'package:provider/provider.dart';

import '../providers/paged-fetch-notifier.dart';

class VendorDetailsPage extends StatefulWidget {
  const VendorDetailsPage({super.key, required this.id});

  final int id;
  @override
  State<VendorDetailsPage> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetailsPage> {

  final _formKey = GlobalKey<FormState>();
  final Future<Vendor> vendor = Future<Vendor>.microtask(() => fetchVendor(12));




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Vendor'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: FutureBuilder<Vendor>(
                  future: fetchVendor(widget.id),
                  builder: (BuildContext context, AsyncSnapshot<Vendor> snapshot){
                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...[
                            TextFormField(
                              initialValue: snapshot.data!.name,
                              decoration: const InputDecoration(
                                filled: true,
                                hintText: 'Enter a name...',
                                labelText: 'Name',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  // title = value.;
                                });
                              },
                            )
                          ].expand(
                                (widget) => [
                              widget,
                              const SizedBox(
                                height: 24,
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}