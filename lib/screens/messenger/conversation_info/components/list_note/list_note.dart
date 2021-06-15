import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Models
import 'package:cntt2_crm/models/Note.dart';
import 'package:cntt2_crm/models/list_model/NoteList.dart';

//Components
import 'components/note_item.dart';

class ListNode extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return _listNode(context);
  }

  void _onRefresh(NoteList noteList) async {
    await noteList.refreshData();
    _refreshController.refreshCompleted();
  }

  void _onLoading(NoteList noteList) async {
    bool check = await noteList.loadMoreData();
    if (check) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  Widget _listNode(BuildContext context) {
    final noteList = Provider.of<NoteList>(context);
    final notes = noteList.list;
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      margin: EdgeInsets.only(top: Layouts.SPACING / 2),
      child: SmartRefresher(
        header: ClassicHeader(
          idleText: 'Kéo xuống để làm mới danh sách ghi chú',
          releaseText: 'Thả ra để làm mới danh sách ghi chú',
          refreshingText: 'Đang làm mới danh sách ghi chú',
          completeText: 'Đã làm mới danh sách ghi chú',
          failedText: 'Làm mới danh sách ghi chú thất bại',
        ),
        enablePullUp: noteList.pageInfo.hasNextPage ? true : false,
        footer: ClassicFooter(
          canLoadingText: 'Tải thêm ghi chú',
          loadingText: 'Đang tải thêm ghi chú',
          noDataText: 'Đã tải hết ghi chú',
          failedText: 'Tải ghi chú thất bại',
        ),
        onRefresh: () => _onRefresh(noteList),
        onLoading: () => _onLoading(noteList),
        controller: _refreshController,
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) => ChangeNotifierProvider<Note>.value(
            value: notes[index],
            child: NoteItem(),
          ),
        ),
      ),
    );
  }
}
