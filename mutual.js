//클릭한 값 전송
$('.btn').click(function(){
  $('#hidden_val').val($(this).attr('name'));
  document.forms["submit"].submit();
});
