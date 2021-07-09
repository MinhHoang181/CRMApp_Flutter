import 'package:cntt2_crm/models/Conversation/Conversations.dart';
import 'package:cntt2_crm/models/Conversation/FilterConversation.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Models
import 'package:cntt2_crm/models/Conversation/Conversation.dart';

//Components
import 'conversation_item.dart';
import 'empty_list_conversation.dart';

class ListConversation extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  void _onRefresh(Conversations conversations,
      FilterConversation filterConversation) async {
    await conversations.refreshData(filterConversation);
    _refreshController.refreshCompleted();
  }

  void _onLoading(Conversations conversations,
      FilterConversation filterConversation) async {
    bool check = await conversations.loadMoreData(filterConversation);
    if (check) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final conversations = context.watch<Conversations>();
    final filter = context.watch<FilterConversation>();
    return SmartRefresher(
      header: ClassicHeader(
        idleText: 'Kéo xuống để làm mới danh sách tin nhắn',
        releaseText: 'Thả ra để làm mới danh sách tin nhắn',
        refreshingText: 'Đang làm mới danh sách tin nhắn',
        completeText: 'Đã làm mới danh sách tin nhắn',
        failedText: 'Làm mới danh sách tin nhắn thất bại',
      ),
      enablePullUp: conversations.pageFilter(filter).hasNextPage ? true : false,
      footer: ClassicFooter(
        canLoadingText: 'Tải thêm tin nhắn',
        loadingText: 'Đang tải thêm tin nhắn',
        noDataText: 'Đã tải hết tin nhắn',
        failedText: 'Tải tin nhắn thất bại',
      ),
      onRefresh: () => _onRefresh(conversations, filter),
      onLoading: () => _onLoading(conversations, filter),
      controller: _refreshController,
      child: _buildList(context, conversations, filter),
    );
  }

  Widget _buildList(BuildContext context, Conversations conversations,
      FilterConversation filter) {
    final list = conversations.list(filter);
    return list.isEmpty
        ? EmptyListConversation()
        : CustomScrollView(
            slivers: [
              SliverImplicitlyAnimatedList<Conversation>(
                items: list,
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
          );
  }
}
