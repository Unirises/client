import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../core/client_bloc/client_bloc.dart';
import '../blocs/cubit/checkout_cubit.dart';
import '../models/Store.dart';
import '../widgets/item_listing.dart';
import 'checkout_page.dart';
import 'company_page.dart';

class StoreDetailsPage extends StatefulWidget {
  final Store store;
  const StoreDetailsPage(this.store);

  @override
  _StoreDetailsPageState createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(vsync: this, length: widget.store.categories.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        if (state is ClientLoaded) {
          if (state.client.delivery_status == 'idle' ||
              state.client.delivery_status == null) {
            return Scaffold(
              floatingActionButton:
                  (context.watch<CheckoutCubit>().state.items.length > 0)
                      ? FloatingActionButton(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.shopping_bag,
                          ),
                          onPressed: () {
                            pushNewScreen(
                              context,
                              screen: CheckoutPage(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                        )
                      : null,
              appBar: AppBar(
                centerTitle: true,
                bottom: TabBar(
                  isScrollable: true,
                  controller: _controller,
                  tabs: widget.store.categories
                      .map((e) => Tab(
                            text: e.name,
                          ))
                      .toList(),
                ),
                title: Text(widget.store.location.place),
                actions: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: CompanyPage(widget.store),
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                  ),
                ],
              ),
              body: TabBarView(
                controller: _controller,
                children: widget.store.categories.isEmpty
                    ? []
                    : widget.store.categories
                        .map((e) => ClassificationListing(
                              category: e,
                              store: widget.store,
                            ))
                        .toList(),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(),
                title: Text(widget.store.location.place),
                centerTitle: true,
              ),
              body: Center(
                child: Text('Go back to see your ride details.'),
              ),
            );
          }
        } else {
          return Scaffold(
            floatingActionButton:
                (context.watch<CheckoutCubit>().state.items.length > 0)
                    ? FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.shopping_bag,
                        ),
                        onPressed: () {
                          pushNewScreen(
                            context,
                            screen: CheckoutPage(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                      )
                    : null,
            appBar: AppBar(
              centerTitle: true,
              bottom: TabBar(
                isScrollable: true,
                controller: _controller,
                tabs: widget.store.categories
                    .map((e) => Tab(
                          text: e.name,
                        ))
                    .toList(),
              ),
              title: Text(widget.store.location.place),
              actions: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      pushNewScreen(
                        context,
                        screen: CompanyPage(widget.store),
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                  ),
                ),
              ],
            ),
            body: TabBarView(
              controller: _controller,
              children: widget.store.categories.isEmpty
                  ? []
                  : widget.store.categories
                      .map((e) => ClassificationListing(
                            category: e,
                            store: widget.store,
                          ))
                      .toList(),
            ),
          );
        }
      },
    );
  }
}
