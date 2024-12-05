import 'package:debugging_optimizing_ecommerce_challenge/advanced_ecommerce/bottom_sheet_top_icon.dart';
import 'package:debugging_optimizing_ecommerce_challenge/advanced_ecommerce/provider/filter_provider.dart';
import 'package:debugging_optimizing_ecommerce_challenge/advanced_ecommerce/entity/filter_request.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final FilterAndSortProductsProvider provider;
  const FilterWidget({super.key, required this.provider});
  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  String _sortBy = 'Price';
  bool isAvailable = false;

  @override
  void initState() {
_minPriceController.text ="${ widget.provider.filterRequest?.minPrice?? 0}";
_maxPriceController.text ="${ widget.provider.filterRequest?.maxPrice?? 1000}";
    super.initState();
  }
  @override
  void dispose() {
    _categoryController.dispose();
    _maxPriceController.dispose();
    _minPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            left: 16,
            top: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30),
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BottomSheetTopIcon(),
              const Center(
                child: Text(
                  "Filter ProductsList",
                  // style: AppTextStyles.style16SemiBold(
                  //     color: AppColors.text2),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'min price',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _maxPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'max price',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isAvailable,
                      onChanged: (value) {
                        setState(() {
                          isAvailable = value!;
                        });
                      }),
                  const Text('Available'),
                ],
              ),
              Row(
                children: [
                  const Text('Sort By'),
                  const SizedBox(width: 30),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _sortBy,
                      items: const <String>['Price', 'Rating']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _sortBy = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    widget.provider.filterRequest =
                        FilterRequest(//productsLength: productsLength,
                            category: _categoryController.text,
                            minPrice: double.parse(_minPriceController.text),
                            maxPrice: double.parse(_maxPriceController.text),
                            isAvailable: isAvailable,
                            productInFilter:widget.provider.products ,
                            sortCriteria: _sortBy);
                    widget.provider.filterAndSortProduct();
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text('Apply Filter'),
                ),
              ),
            ]));
  }
}
