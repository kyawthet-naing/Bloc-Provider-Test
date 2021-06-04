import 'package:flutter/material.dart';
import 'package:pro_vider/ob/json_ob.dart';
import 'package:pro_vider/ob/response_ob.dart';
import 'package:pro_vider/pages/third_page.dart';
import 'package:pro_vider/provider/http_provider.dart';
import 'package:provider/provider.dart';

class HttpRequest extends StatelessWidget {
  const HttpRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HttpProvider httpProvider = Provider.of<HttpProvider>(context);
    httpProvider.getData();
    return Scaffold(
      appBar: AppBar(title: Text('Http Request')),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ThirdPage()));
              },
              child: Text('Go Third Page')),
          Expanded(
            child: Consumer<HttpProvider>(
              builder: (_, HttpProvider hProvider, __) {
                ResponseOb resOb = hProvider.responseOb;
                if (resOb.msgState == MsgState.data) {
                  List<JsonOb> jsList = resOb.data;
                  return ListView(
                    children: jsList
                        .map((e) => ListTile(
                              title: Text(e.title!),
                              subtitle: Text(e.body!),
                            ))
                        .toList(),
                  );
                } else if (resOb.msgState == MsgState.loading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text('Error'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
