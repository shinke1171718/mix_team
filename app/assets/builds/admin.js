// app/javascript/form/confirm.js
document.addEventListener("turbo:load", function() {
  $(".btn_loading").on("submit", function() {
    $(this).prop("disabled", true);
    $(".loading").fadeIn();
  });
  $(".confirm-btn").on("click", function(event) {
    event.preventDefault();
    if (!confirm("\u51E6\u7406\u3092\u5B9F\u884C\u3057\u3066\u3088\u308D\u3057\u3044\u3067\u3059\u304B\uFF1F")) {
      return false;
    } else {
      $(this).prop("disabled", true);
      $(".loading").fadeIn();
      $(this).closest("form").submit();
    }
  });
  $("form").on("turbo:submit-start", function() {
    $(this).find('input[type="submit"]').prop("disabled", true);
    $(".loading").fadeIn();
  });
  function loaderClose() {
    $(".loading").fadeOut("slow");
  }
  setTimeout(loaderClose, 30000);
});

// app/javascript/form/autofill_template.js
$(document).on("turbo:load", function() {
  $(".template__link").on("click", function(event) {
    event.preventDefault();
    var templateType = $(this).data("template");
    if (templateType === 1) {
      $(".title-field").val("\u30B7\u30E3\u30C3\u30D5\u30EB\u30E9\u30F3\u30C1");
      $(".min-size-field").val(3);
      $(".max-size-field").val(4);
      var memoText = `\u4ECA\u65E5\u306E\u304A\u984C\uFF1A\u3007\u3007
\u5F53\u65E5\u306E\u671D\u793C\u524D\u307E\u3067\u306B\u53C2\u52A0\u3057\u3066\u304F\u3060\u3055\u3044\uFF01`;
      $(".memo-field").val(memoText);
      var today = new Date;
      var dayOfWeek = today.getDay();
      var daysUntilWednesday = (3 - dayOfWeek + 7) % 7;
      if (daysUntilWednesday === 0) {
        daysUntilWednesday = 7;
      }
      var nextWednesday = new Date(today);
      nextWednesday.setDate(today.getDate() + daysUntilWednesday);
      var formattedDate = nextWednesday.toISOString().split("T")[0];
      $(".date-field").val(formattedDate);
    }
  });
});
