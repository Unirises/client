import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../core/authentication_bloc/authentication_bloc.dart';
import '../../../../core/client_bloc/client_bloc.dart';
import '../../../../core/user_collection_bloc/user_collection_bloc.dart';
import '../../../../core/widgets/profile_picture.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../transactions/pages/transaction_list_page.dart';
import '../../../wallet/presentation/wallet_page.dart';
import '../widgets/account_page_list_item_template.dart';

class AccountIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCollectionBloc, UserCollectionState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: ProfilePage(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                            child: ProfilePictureWidget(
                                url: state.userCollection.photo)),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.userCollection.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text(
                                    'Edit your profile',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      AccountPageListItemTemplate(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: TransactionListPage(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        title: 'Transactions',
                      ),
                      BlocBuilder<ClientBloc, ClientState>(
                        builder: (context, walletState) {
                          if (walletState is ClientLoaded) {
                            return AccountPageListItemTemplate(
                              onTap: () {
                                pushNewScreen(
                                  context,
                                  screen: WalletPage(),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              title: 'Wallet',
                              trailingText:
                                  'PHP ${walletState.client.balance.toStringAsFixed(2)}',
                            );
                          }
                          return Container();
                        },
                      ),
                      AccountPageListItemTemplate(
                        onTap: () => context
                            .bloc<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequested()),
                        title: 'Log Out',
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                            '${snapshot.data.appName} | version ${snapshot.data.version}');
                      }
                      return CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
