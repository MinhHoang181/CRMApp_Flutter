import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:cntt2_crm/models/Conversation/Conversation.dart';

//Components
import 'conversation_item.dart';

class ListConversation extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  void _onRefresh() async {
    await AzsalesData.instance.conversations.refreshData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    bool check = await AzsalesData.instance.conversations.loadMoreData();
    if (check) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final conversationList = Provider.of<ConversationList>(context);
    final conversations = conversationList.sort(increase: false);
    return SmartRefresher(
      header: ClassicHeader(
        idleText: 'Kéo xuống để làm mới danh sách tin nhắn',
        releaseText: 'Thả ra để làm mới danh sách tin nhắn',
        refreshingText: 'Đang làm mới danh sách tin nhắn',
        completeText: 'Đã làm mới danh sách tin nhắn',
        failedText: 'Làm mới danh sách tin nhắn thất bại',
      ),
      enablePullUp: conversationList.pageInfo.hasNextPage ? true : false,
      footer: ClassicFooter(
        canLoadingText: 'Tải thêm tin nhắn',
        loadingText: 'Đang tải thêm tin nhắn',
        noDataText: 'Đã tải hết tin nhắn',
        failedText: 'Tải tin nhắn thất bại',
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      child: CustomScrollView(
        slivers: [
          SliverImplicitlyAnimatedList<Conversation>(
            items: conversations,
            areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
            itemBuilder: (context, animation, item, i) {
              return SizeFadeTransition(
                sizeFraction: 0.7,
                curve: Curves.easeInOut,
                animation: animation,
                child: ChangeNotifierProvider<Conversation>.value(
                  value: item,
                  child: ConversationItem(),
                ),
              );
            },
            updateItemBuilder: (context, animation, item) {
              return SizeFadeTransition(
                sizeFraction: 0.7,
                curve: Curves.easeInOut,
                animation: animation,
                child: ChangeNotifierProvider<Conversation>.value(
                  value: item,
                  child: ConversationItem(),
                ),
              );
            },
            removeItemBuilder: (context, animation, item) {
              return SizeFadeTransition(
                sizeFraction: 0.7,
                curve: Curves.easeInOut,
                animation: animation,
                child: ChangeNotifierProvider<Conversation>.value(
                  value: item,
                  child: ConversationItem(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
