import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/di.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/search/presentation/manager/search_cubit.dart';
import 'package:p/screens/search/presentation/widgets/all/company_card_all.dart';
import 'package:p/screens/search/presentation/widgets/all/event_card_all.dart';
import 'package:p/screens/search/presentation/widgets/all/trip_card_all.dart';
import 'package:p/screens/search/presentation/widgets/seperate/company_card.dart';
import 'package:p/screens/search/presentation/widgets/seperate/event_card.dart';
import 'package:p/screens/search/presentation/widgets/seperate/trip_card.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:shimmer/shimmer.dart';

class FilteringAllEtc extends StatefulWidget {
  final String initialText;
  final TextEditingController controller;

  FilteringAllEtc({super.key, required this.initialText})
      : controller = TextEditingController(text: initialText);

  @override
  State<FilteringAllEtc> createState() => _FilteringAllEtcState();
}

class _FilteringAllEtcState extends State<FilteringAllEtc> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<String> selectedCategory = ValueNotifier<String>('All');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialText.isNotEmpty) {
        _searchFromApi(widget.initialText, selectedCategory.value);
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<SearchCubit>().loadNextPage(
              _mapCategoryToType(selectedCategory.value),
              widget.controller.text.trim(),
              10,
            );
      }
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _searchFromApi(String query, String category) {
    final type = _mapCategoryToType(category);
    if (query.isEmpty) return;
    context.read<SearchCubit>().search(
          type: type,
          query: query,
          pageSize: 10,
          pageIndex: 1,
        );
  }

  String _mapCategoryToType(String category) {
    switch (category) {
      case 'Travel':
        return 'Travels';
      case 'Event':
        return 'Events';
      case 'Company':
        return 'Companies';
      default:
        return '';
    }
  }

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 6,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
          baseColor: const Color(0xffD8D1CA),
          highlightColor: const Color(0xffCBC0B6),
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: const Text(
              "Refine Your Search",
              style: TextStyle(fontFamily: "pop", fontSize: 17),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              children: [
                Card(
                  color:
                      isLight ? const Color(0xFFD7D1D1) : const Color(0xFF8C8282),
                  elevation: 3,
                  shadowColor:
                      isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r)),
                  child: TextField(
                    cursorColor: ColorApp.primaryColor,
                    controller: widget.controller,
                    onChanged: (value) {
                      _searchFromApi(value, selectedCategory.value);
                    },
                    style: const TextStyle(
                        fontFamily: "pop", color: Colors.black, fontSize: 12),
                    decoration: InputDecoration(
                      fillColor: isLight
                          ? const Color(0xFFD7D1D1)
                          : const Color(0xFF8C8282),
                      filled: true,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      suffixIcon: Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isLight
                                ? ColorApp.primaryColor
                                : ColorApp.primaryColorDark,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.r),
                            onTap: () {},
                            child: const Icon(Icons.search, color: Colors.white),
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 9),
                      border: const OutlineInputBorder(),
                      hintText: "Start typing to search...",
                      label: Text(
                        "Where to ?",
                        style: TextStyle(
                          fontFamily: "pop",
                          color: isLight ? const Color(0xFF787474) : Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                                isLight ? const Color(0xFF787474) : Colors.white,
                            fontSize: 13.sp,
                            fontFamily: "pop",
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                DefaultTabController(
                  length: 4,
                  child: TabBar(
                    onTap: (index) {
                      final categories = ['All', 'Travel', 'Event', 'Company'];
                      selectedCategory.value = categories[index];
                      _searchFromApi(
                          widget.controller.text, selectedCategory.value);
                    },
                    indicatorWeight: 4,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: ColorApp.primaryColor,
                    labelColor: ColorApp.primaryColor,
                    unselectedLabelColor: Colors.black,
                    labelPadding:  EdgeInsets.zero,
                    tabs: const [
                      Text("All",
                          style: TextStyle(fontFamily: "pop", fontSize: 12)),
                      Text("Travel",
                          style: TextStyle(fontFamily: "pop", fontSize: 12)),
                      Text("Event",
                          style: TextStyle(fontFamily: "pop", fontSize: 12)),
                      Text("Company",
                          style: TextStyle(fontFamily: "pop", fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (widget.controller.text.isEmpty) {
                        return const Center(
                          child: Text("Field is empty",
                              style: TextStyle(
                                  fontFamily: "pop",
                                  fontSize: 12,
                                  color: Colors.black54)),
                        );
                      }

                      if (state.status == SearchStatus.loading) {
                        return _buildShimmer();
                      }

                      if (state.status == SearchStatus.error) {
                        return Center(
                          child: Text(
                              state.errorMessage ?? "Something went wrong.",
                              style: const TextStyle(color: Colors.red)),
                        );
                      }

                      final results = <Widget>[];

                      if (state.resultType == SearchResultType.travels) {
                        results.addAll(state.travels?.items?.map(
                              (e) => TripCard(model: e),
                            ) ??
                            []);
                      } else if (state.resultType == SearchResultType.events) {
                        results.addAll(state.events?.map(
                              (e) => EventCard(model: e),
                            ) ??
                            []);
                      } else if (state.resultType ==
                          SearchResultType.companies) {
                        results.addAll(state.companies?.items?.map(
                              (e) => CompanyCard(model: e),
                            ) ??
                            []);
                      } else if (state.resultType == SearchResultType.all) {
                        results
                          ..addAll(state.all?.travels?.items?.map(
                                (e) => TripCardAll(model: e),
                              ) ??
                              [])
                          ..addAll(state.all?.events?.items?.map(
                                (e) => EventCardAll(model: e),
                              ) ??
                              [])
                          ..addAll(state.all?.companies?.items?.map(
                                (e) => CompanyCardAll(model: e),
                              ) ??
                              []);
                      }

                      if (results.isEmpty) {
                        return const Center(
                            child: Text("No results found",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontSize: 12,
                                    color: Colors.black54)));
                      }

                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: results.length,
                        separatorBuilder: (_, __) =>
                            const Divider(indent: 20, endIndent: 20),
                        itemBuilder: (context, index) => results[index],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
