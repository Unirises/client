import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../bloc/authentication_bloc.dart';
import '../bloc/user_collection_bloc.dart';
import '../profile/profile_page.dart';
import 'widgets/account_page_list_item_template.dart';
import 'widgets/profile_picture_widget.dart';

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
                        ProfilePictureWidget(url: state.userCollection.photo),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.userCollection.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 26)),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      // AccountPageListItemTemplate(
                      //   onTap: () {
                      //     pushNewScreen(
                      //       context,
                      //       screen: VerificationStatusPage(),
                      //       withNavBar: false,
                      //       pageTransitionAnimation:
                      //           PageTransitionAnimation.cupertino,
                      //     );
                      //   },
                      //   title: 'Verification Status',
                      // ),
                      // const AccountPageListItemTemplate(
                      //   title: 'Business Profile',
                      // ),
                      // const AccountPageListItemTemplate(
                      //   title: 'Invoices',
                      // ),
                      // AccountPageListItemTemplate(
                      //   trailingText: '${state.userCollection.gems} Gems',
                      //   title: 'Rider Rewards',
                      // ),
                      AccountPageListItemTemplate(
                        onTap: () => context
                            .bloc<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequested()),
                        title: 'Log Out',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
