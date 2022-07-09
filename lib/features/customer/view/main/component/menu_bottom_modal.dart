import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:order_app_client/features/customer/data/response/base_response.dart';
import 'package:order_app_client/features/customer/domain/entity/menu.dart';
import 'package:order_app_client/features/customer/resources/color/base_color.dart';
import 'package:order_app_client/features/customer/viewmodel/main/tab_home_vm.dart';

class DetailMenuBottomModal extends StatefulWidget {
  const DetailMenuBottomModal({
    Key? key,
    required this.menu,
    required this.vm,
  }) : super(key: key);

  final Menu menu;
  final TabHomeViewModel vm;

  @override
  State<StatefulWidget> createState() => DetailMenuBottomModalState();
}

class DetailMenuBottomModalState extends State<DetailMenuBottomModal> {
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _itemCount = widget.vm.carts[widget.menu.id] ?? 0;
    });

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: 1,
              child: Image.network(
                widget.menu.imageUrl,
                width: 150,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text("Failed to load Image");
                },
              )),
          const SizedBox(height: 15),
          Text(widget.menu.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 5),
          Text(
            widget.menu.description,
            style: const TextStyle(
              fontSize: 12,
              color: AppDefaultColor.defaultGrey,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Stock: ${widget.menu.stock}",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Rp${widget.menu.price}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (_itemCount == 0) return;

                    setState(() {
                      _itemCount--;
                    });
                    widget.vm.decrementCarts(widget.menu.id);
                  },
                  icon: const Icon(Icons.remove)),
              Text('$_itemCount'),
              IconButton(
                onPressed: () {
                  setState(() {
                    _itemCount++;
                  });
                  widget.vm.incrementCarts(widget.menu.id);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.vm.addToCarts(widget.menu).then((value) {
                    EasyLoading.showSuccess(value.message);
                    Navigator.pop(context);
                  }).catchError((err) {
                    if (err is BaseResponse && err.statusCode == 401) {
                      EasyLoading.showError(err.message);
                      Future.delayed(
                        const Duration(seconds: 1),
                        () => Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false),
                      );
                      return;
                    }
                    EasyLoading.showError("Fail to save data");
                  });
                },
                child: const Text("Add To Cart"),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
