document.addEventListener("turbo:load", function() {

  //多重送信制限
  $('.btn_loading').on('submit', function () {
    $(this).prop('disabled', true);
    $('.loading').fadeIn();
  });

  //confirmが必要なボタンの処理
  $('.confirm-btn').on('click', function (event) {
    event.preventDefault();

    if (!confirm('処理を実行してよろしいですか？')) {
      return false;
    } else {
      $(this).prop('disabled', true);
      $('.loading').fadeIn();
      $(this).closest('form').submit();
    }
  });

  // Turboフレームのリロード時、フォーム送信後にボタンを無効化する処理
  $("form").on("turbo:submit-start", function() {
    // フォーム送信後にsubmitボタンを無効化
    $(this).find('input[type="submit"]').prop('disabled', true);
    $('.loading').fadeIn();
  });

  function loaderClose() {
    $(".loading").fadeOut('slow');
  }
  setTimeout(loaderClose, 30000);
});
