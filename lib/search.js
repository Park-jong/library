$(".datarow").click(function(){
    let stat = $(this).children(".stat")[0].innerText;
    let book = $(this).children(".book_id")[0].innerText;
    if($("#loanform").length && stat == '대출가능'){
        let select = confirm("대출하시겠습니까?");
        if (select){
            $("#book_id").val(book);
            $("#loanform").submit();
        }
    }
});