$(document).on('turbo:load', function() {
  $('.template__link').on('click', function(event) {
    event.preventDefault();

    // data-template 属性の値を取得
    var templateType = $(this).data('template');

    if (templateType === 1) {
      // イベント名の自動入力
      $('.title-field').val('シャッフルランチ');

      // 1グループの人数を設定
      $('.min-size-field').val(3);
      $('.max-size-field').val(4);

      // メモの自動入力
      var memoText = "今日のお題：〇〇\n当日の朝礼前までに参加してください！";
      $('.memo-field').val(memoText);

      // 直近の水曜日を取得して日付フィールドに設定
      var today = new Date();
      var dayOfWeek = today.getDay();  // 現在の曜日 (0: 日曜日, 1: 月曜日, ... 6: 土曜日)
      var daysUntilWednesday = (3 - dayOfWeek + 7) % 7; // 3は水曜日を表す
      if (daysUntilWednesday === 0) {
        daysUntilWednesday = 7; // もし今日が水曜日なら、次の水曜日を取得
      }

      // 直近の水曜日の日付を計算
      var nextWednesday = new Date(today);
      nextWednesday.setDate(today.getDate() + daysUntilWednesday);

      // 日付を 'YYYY-MM-DD' の形式にフォーマットして入力フィールドにセット
      var formattedDate = nextWednesday.toISOString().split('T')[0];
      $('.date-field').val(formattedDate);
    }
  });
});
